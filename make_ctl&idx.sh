#! /bin/bash
# This script allows you to create .ctl & .grb2.idx files from .grb2
# The script must be placed among the folders of years,
# Please be sure to specify the name of the folder in the YYYY format (Ex. 2015, 1944)
# =============================================================================
for dir in *; do
    if [ -d "$dir" ]; then
        echo "year:${dir} -------------------------------------------------------";
        cd ${dir}
        for param_dir in *; do 
            echo "             param:${param_dir}========================================";
            cd ${param_dir}
            for file in *.grb2; do
                echo "                          file:${file}"
                g2ctl.pl "${file}" >"${file%.*}.ctl"
                gribmap -i "${file%.*}.ctl"
            done
            cd ..
        done
        cd ..
    fi;
done;
echo "All files has been converted.";

