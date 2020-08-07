#! /bin/bash

#
# Copyright (c) 2020 cTuning foundation.
# See CK COPYRIGHT.txt for copyright details.
#
# See CK LICENSE.txt for licensing details.
#   
# Installation script for the EdgeTPU library.
#

wget --no-cookies ${PACKAGE_URL}${PACKAGE_NAME}
dpkg -x $PACKAGE_NAME .

return 0
