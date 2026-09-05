#pragma once

#include <Arduino.h>

// Indoor Air Quality estimate derived from a BME68x gas resistance reading.
//
// This is NOT Bosch BSEC. BSEC is a closed source binary with its own licence, and its
// output is not reproducible from the public datasheet. What follows has the same shape -
// gas resistance compensated for water vapour, scored against a slowly adapting clean air
// baseline, reported on the same 0-500 scale with the same accuracy semantics - but the
// numbers are an estimate of the same quantity, not interchangeable with BSEC's.
//
// The scale, lower is cleaner:
//   0-50 excellent, 51-100 good, 101-150 lightly polluted, 151-200 moderately polluted,
//   201-250 heavily polluted, 251-350 severely polluted, 351-500 extremely polluted.

#define IAQ_HUMIDITY_OPTIMAL 40.0f     // %RH treated as ideal for indoor air
#define IAQ_HUMIDITY_WEIGHT 0.25f      // humidity contributes 25% of the score, gas 75%
#define IAQ_BURN_IN_MS 300000UL        // 5 min for the heater to stabilize before scoring
#define IAQ_BASELINE_RISE_TAU_S 300.0f // adapt up towards cleaner air over ~5 min
#define IAQ_BASELINE_FALL_TAU_S 86400.0f // decay down over ~a day, so pollution is not adopted
#define IAQ_ABS_HUMIDITY_SLOPE 0.03f   // gas resistance vs absolute humidity, per g/m3
#define IAQ_BURN_IN_SEC 300U           // same, in the accumulated-seconds domain
#define IAQ_ACCURACY_LOW_SEC 600U      // 10 min of tracked time
#define IAQ_ACCURACY_MED_SEC 1800U     // 30 min of tracked time
// A resumed session keeps its restored baseline, so it only needs the heater to settle
// rather than a full burn-in. A sleeping device is rarely awake long enough for more.
#define IAQ_RESUME_SETTLE_MS 2000UL

class CAirQuality {

public:
  CAirQuality();

  void reset();

  // Seed from values persisted in the configuration. Called before the first update() so a
  // restart or a deep sleep cycle continues the same baseline instead of starting over.
  void restore(float savedBaseline, uint32_t savedAccumulatedSec);
  // Account for wall clock time in which no readings were taken - a deep sleep interval, or
  // time powered off. The baseline adapts on elapsed time, so this has to be fed in or a
  // sleeping device would decay its baseline hundreds of times slower than real time.
  void addElapsedSeconds(uint32_t seconds);

  uint32_t getAccumulatedSeconds() const { return accumulatedSec; };
  bool hasBaseline() const { return baseline > 0; };
  // Feed one BME68x reading. Safe to call at any cadence; the baseline adapts on elapsed
  // time rather than sample count, so the read interval does not change the tuning.
  void update(float temperatureC, float humidityPct, float gasResistanceOhms);

  bool isValid() const { return accuracy > 0; };
  float getIAQ() const { return iaq; };                  // 0-500, lower is cleaner
  float getScore() const { return score; };              // 0-100, higher is cleaner
  uint8_t getAccuracy() const { return accuracy; };      // 0 stabilizing .. 3 calibrated
  float getBaseline() const { return baseline; };        // compensated clean air reference
  float getCompensatedGas() const { return compGas; };
  const char* getRating() const;
  const char* getAccuracyText() const;

  // Water vapour in g/m3. Gas resistance tracks absolute rather than relative humidity,
  // so this is what makes the compensation hold across different temperatures.
  static float absoluteHumidity(float temperatureC, float humidityPct);

private:
  unsigned long tFirstSample;
  unsigned long tLastUpdate;
  uint32_t accumulatedSec;   // tracked seconds, carried across sleeps and restarts
  uint32_t pendingElapsedSec; // time asleep, folded into the next update's delta
  bool resumed;              // started from a persisted baseline
  float baseline;
  float compGas;
  float iaq;
  float score;
  uint8_t accuracy;
};
