FILENAME_BUILDNO = 'versioning'
FILENAME_VERSION_H = 'include/version.h'

import datetime
import os

build_no = 0

try:
    with open(FILENAME_BUILDNO) as f:
        build_no = int(f.readline())
except:
    print('Starting build number from 1..')
    build_no = 0

build_no += 1
with open(FILENAME_BUILDNO, 'w+') as f:
    f.write(str(build_no))
    print('Build number: {}'.format(build_no))

semver = os.environ.get('SEMVER', '').strip()
if semver:
    version = f"{semver}.{build_no}"
else:
    version = f"0.0.dev.{build_no}"

hf = f"""
#ifndef BUILD_NUMBER
  #define BUILD_NUMBER "{build_no}"
#endif
#ifndef VERSION
  #define VERSION "{version} - {datetime.datetime.now()}"
#endif
#ifndef VERSION_SHORT
  #define VERSION_SHORT "{version}"
#endif
"""

with open(FILENAME_VERSION_H, 'w+') as f:
    f.write(hf)