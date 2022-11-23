#!/bin/sh

rm -rf /path/to/output/directory

packer build -force -parallel-builds=1 -timestamp-ui .