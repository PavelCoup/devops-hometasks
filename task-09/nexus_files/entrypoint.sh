#!/bin/bash

/scripts/configuring_nexus.sh >> /scripts/log &
/opt/sonatype/start-nexus-repository-manager.sh