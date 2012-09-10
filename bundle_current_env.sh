#!/bin/bash

PROJECT_DIR="$( cd "$( dirname "$0" )" && pwd )"
WINEPREFIX=${WINEPREFIX:-$HOME/.wine}

TARGET=$PROJECT_DIR/wine-bundle.tar.gz
if [ ! -f $TARGET ];
then
    tar czf $TARGET -C $WINEPREFIX .
fi
./add_payload.sh --binary $TARGET
chmod +x setup_proteomics_wine_env.sh