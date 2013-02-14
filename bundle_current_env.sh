#!/bin/bash
#
# Usage: bundle_current_env.sh [wine_directory]
# 
# This script will tar up a wine directory and
# create a script to deploy it on a new machine
# called setup_proteomics_wine_env.sh.
# 
# To bundle a specific wine directory pass it as an
# input to this script, Otherwise this script will 
# back to using the directory referenced by the 
# environment variable WINEPREFIX or finally 
# $HOME/.wine if that is not set.


PROJECT_DIR="$( cd "$( dirname "$0" )" && pwd )"
WINEPREFIX=${WINEPREFIX:-$HOME/.wine}
WINEDIRECTORY=${1:-$WINEPREFIX}

TARGET=$PROJECT_DIR/wine-bundle.tar.gz
if [ ! -f $TARGET ];
then
    tar czf $TARGET -C $WINEDIRECTORY .
fi
./add_payload.sh --binary $TARGET
chmod +x setup_proteomics_wine_env.sh
