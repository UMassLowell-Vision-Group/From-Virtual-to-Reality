#!/bin/bash

cd /data1/vision/common/photorealistic/office_virtual_full/

for category in $(ls)
do
    cd $category
    cd Annotation
    for file in $(ls *.xml | sed 's/.xml//g')
    do       
        tail -n +2 $file.xml > tmp.xml
        mv tmp.xml $file.xml
    done
    cd ../..
done
