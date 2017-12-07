#!/bin/bash +x
#
# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#


#set -e

CHANNEL_NAME=$1
: ${CHANNEL_NAME:="mychannel"}
echo $CHANNEL_NAME


## Using docker-compose template replace private key file names with constants
function replacePrivateKey () {

	OPTS="-i"

    CURRENT_DIR=$PWD

	echo $CURRENT_DIR

	cd $CURRENT_DIR/../
	rm docker-compose.yaml
	cp docker-compose-template.yaml docker-compose.yaml

    cd $CURRENT_DIR/crypto-config/peerOrganizations/org1.example.com/ca/
    PRIV_KEY=$(ls *_sk)
    cd $CURRENT_DIR/../
    sed $OPTS "s/CA1_PRIVATE_KEY/${PRIV_KEY}/g" docker-compose.yaml
    cd $CURRENT_DIR/crypto-config/peerOrganizations/org2.example.com/ca/
    PRIV_KEY=$(ls *_sk)
    cd $CURRENT_DIR/../
    sed $OPTS "s/CA2_PRIVATE_KEY/${PRIV_KEY}/g" docker-compose.yaml
	
	cd $CURRENT_DIR
}


replacePrivateKey

