#!/bin/bash
set -e

export IDF_PATH=/opt/esp/idf
export IDF_TOOLS_PATH=/opt/esp

export PS1='\u@esp-idf \w # '
export LC_ALL="en_US.UTF8"

. $IDF_PATH/export.sh


exec "$@"

