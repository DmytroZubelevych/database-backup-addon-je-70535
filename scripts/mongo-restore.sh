#!/bin/bash

if grep -q ^[[:space:]]*replSetName /etc/mongod.conf; then 
    export RS_NAME=$(grep ^[[:space:]]*replSetName /etc/mongod.conf|awk '{print $2}'); 
    export RS_SUFFIX="/?replicaSet=${RS_NAME}&readPreference=nearest"; 
else 
    export RS_SUFFIX=""; 
fi
mongorestore --uri="mongodb://${1}:${2}@localhost${RS_SUFFIX}" ~/dump 1>/dev/null
