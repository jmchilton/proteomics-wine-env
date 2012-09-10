#!/bin/bash

# From: http://www.linuxjournal.com/content/add-binary-payload-your-shell-scripts

TEMPLATE_FILE=setup_proteomics_wine_env.sh.template
INSTALL_FILE=setup_proteomics_wine_env.sh

# Check for payload format option (default is uuencode).
uuencode=1
if [[ "$1" == '--binary' ]]; then
    binary=1
    uuencode=0
    shift
fi
if [[ "$1" == '--uuencode' ]]; then
    binary=0
    uuencode=1
    shift
fi

if [[ ! "$1" ]]; then
    echo "Usage: $0 [--binary | --uuencode] PAYLOAD_FILE"
    exit 1
fi


if [[ $binary -ne 0 ]]; then
    # Append binary data.
    sed \
        -e 's/uuencode=./uuencode=0/' \
        -e 's/binary=./binary=1/' \
         $TEMPLATE_FILE >$INSTALL_FILE
    echo "PAYLOAD:" >> $INSTALL_FILE

    cat $1 >>$INSTALL_FILE
fi
if [[ $uuencode -ne 0 ]]; then
    # Append uuencoded data.
    sed \
        -e 's/uuencode=./uuencode=1/' \
        -e 's/binary=./binary=0/' \
         $TEMPLATE_FILE >$INSTALL_FILE
    echo "PAYLOAD:" >> $INSTALL_FILE

    cat $1 | uuencode - >>$INSTALL_FILE
fi