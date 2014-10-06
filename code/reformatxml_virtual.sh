#!/bin/bash

cd /data1/vision/common/photorealistic/office_virtual_full/

for category in $(ls)
do
    cd $category
    cd Annotation
    for file in $(ls *.xml)
    do       
        echo $file
        awk -v OFS="\t" '$1=$1' $file > tmp
        mv tmp $file
    done
    cd ../..
done
