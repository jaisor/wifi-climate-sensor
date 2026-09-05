#include <Arduino.h>
#include <math.h>
#include <ArduinoLog.h>

#include "AirQuality.h"

CAirQuality::CAirQuality() {
  reset();
}

void CAirQuality::reset() {
  tFirstSample = 0;
  tLastUpdate = 0;
  accumulatedSec = 0;
  pendingElapsedSec = 0;
  resumed = false;
  baseline = 0;
  compGas = 0;
  iaq = 0;
  score = 0;
  accuracy = 0;
}

void CAirQuality::restore(float savedBaseline, uint32_t savedAccumulatedSec) {
  if (savedBaseline <= 0 || isnan(savedBaseline)) {
    return;
  }
  baseline = savedBaseline;
  accumulatedSec = savedAccumulatedSec;
  resumed = true;
  // The baseline is trusted immediately; only the heater still has to settle. Accuracy
  // still reflects total tracked time, so a long history is not thrown away on a restart.
  accuracy = accumulatedSec < IAQ_ACCURACY_LOW_SEC ? 1
    : (accumulatedSec < IAQ_ACCURACY_MED_SEC ? 2 : 3);
  Log.noticeln(F("IAQ resumed with baseline %F Ohm, %u tracked seconds, accuracy %u"),
    baseline, accumulatedSec, accuracy);
}

void CAirQuality::addElapsedSeconds(uint32_t seconds) {
  if (seconds == 0) {
    return;
  }
  // Only queued, never added to accumulatedSec here: the next update() folds pending into
  // its delta and accumulates that, so adding it in both places would double count and
  // inflate the reported accuracy.
  pendingElapsedSec += seconds;
  Log.infoln(F("IAQ credited %u seconds of elapsed time with no readings"), seconds);
}

float CAirQuality::absoluteHumidity(float temperatureC, float humidityPct) {
  if (isnan(temperatureC) || isnan(humidityPct)) {
    return 0;
  }
  // Magnus formula for saturation vapour pressure in hPa, then the ideal gas law in g/m3
  float pSat = 6.112f * expf((17.67f * temperatureC) / (temperatureC + 243.5f));
  return 216.7f * (humidityPct / 100.0f * pSat) / (273.15f + temperatureC);
}

void CAirQuality::update(float temperatureC, float humidityPct, float gasResistanceOhms) {

  if (gasResistanceOhms <= 0 || isnan(gasResistanceOhms)) {
    return;
  }

  unsigned long now = millis();
  if (tFirstSample == 0) {
    tFirstSample = now;
    tLastUpdate = now;
  }

  // Water vapour pulls the gas resistance down independently of air quality, so lift it
  // back out before the reading is scored against the baseline.
  float absHum = absoluteHumidity(temperatureC, humidityPct);
  compGas = gasResistanceOhms * expf(IAQ_ABS_HUMIDITY_SLOPE * absHum);

  // Elapsed time includes any interval spent asleep, so the day-scale baseline decay runs
  // on wall clock time rather than on the handful of seconds a sleeping device is awake.
  unsigned long sessionMs = now - tFirstSample;
  float dt = (now - tLastUpdate) / 1000.0f + (float)pendingElapsedSec;
  pendingElapsedSec = 0;
  tLastUpdate = now;
  accumulatedSec += (uint32_t)dt;

  // A cold start has to wait out the heater's initial drift. A resumed session already has
  // a trusted baseline, so it only skips the first reading or two.
  unsigned long settleMs = resumed ? IAQ_RESUME_SETTLE_MS : IAQ_BURN_IN_MS;
  if (sessionMs < settleMs) {
    if (!resumed) {
      baseline = compGas; // seed, but do not score yet
      accuracy = 0;
    }
    return;
  }

  if (baseline <= 0) {
    baseline = compGas;
  } else if (dt > 0) {
    // Upper envelope: rise towards cleaner air in minutes, fall towards dirtier air over a
    // day. A fast fall would quietly adopt a polluted room as the new "clean" reference.
    float tau = compGas > baseline ? IAQ_BASELINE_RISE_TAU_S : IAQ_BASELINE_FALL_TAU_S;
    float alpha = 1.0f - expf(-dt / tau);
    baseline += (compGas - baseline) * alpha;
  }

  // Humidity term: full marks at IAQ_HUMIDITY_OPTIMAL, tapering to zero at 0% and 100%
  float humScore;
  float humOffset = humidityPct - IAQ_HUMIDITY_OPTIMAL;
  if (humOffset > 0) {
    humScore = (100.0f - IAQ_HUMIDITY_OPTIMAL - humOffset) / (100.0f - IAQ_HUMIDITY_OPTIMAL);
  } else {
    humScore = (IAQ_HUMIDITY_OPTIMAL + humOffset) / IAQ_HUMIDITY_OPTIMAL;
  }
  humScore = constrain(humScore, 0.0f, 1.0f) * IAQ_HUMIDITY_WEIGHT * 100.0f;

  // Gas term: how close this reading sits to the clean air reference
  float gasRatio = baseline > 0 ? compGas / baseline : 0.0f;
  gasRatio = constrain(gasRatio, 0.0f, 1.0f);
  float gasScore = gasRatio * (1.0f - IAQ_HUMIDITY_WEIGHT) * 100.0f;

  score = humScore + gasScore;
  iaq = (100.0f - score) * 5.0f;

  // Same meaning as BSEC's accuracy field: how far the baseline has had a chance to settle.
  // Measured against total tracked time so a restart does not discard a settled baseline.
  if (accumulatedSec < IAQ_ACCURACY_LOW_SEC) {
    accuracy = 1;
  } else if (accumulatedSec < IAQ_ACCURACY_MED_SEC) {
    accuracy = 2;
  } else {
    accuracy = 3;
  }

  Log.verboseln(F("IAQ %F (score %F) gas %FOhm comp %FOhm baseline %FOhm absHum %Fg/m3 accuracy %u"),
    iaq, score, gasResistanceOhms, compGas, baseline, absHum, accuracy);
}

const char* CAirQuality::getRating() const {
  if (accuracy == 0) {
    return "Stabilizing";
  }
  if (iaq <= 50) {
    return "Excellent";
  } else if (iaq <= 100) {
    return "Good";
  } else if (iaq <= 150) {
    return "Lightly polluted";
  } else if (iaq <= 200) {
    return "Moderately polluted";
  } else if (iaq <= 250) {
    return "Heavily polluted";
  } else if (iaq <= 350) {
    return "Severely polluted";
  }
  return "Extremely polluted";
}

const char* CAirQuality::getAccuracyText() const {
  switch (accuracy) {
    case 0: return "stabilizing";
    case 1: return "uncertain";
    case 2: return "calibrating";
    default: return "calibrated";
  }
}
