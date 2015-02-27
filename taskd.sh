#!/bin/bash
export TASKDDATA=/var/taskd

# Create new configuration stub
rm -rf $TASKDDATA/orig
mkdir -p $TASKDDATA/orig
/usr/local/bin/taskd init --data $TASKDDATA/orig >/dev/null

# Run taskd
exec /usr/local/bin/taskd server
