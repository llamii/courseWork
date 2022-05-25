#! /bin/bash
# This script allows you to convert .grb2 files into .dat files
# The script must be placed among the folders of years,
# PLease be sure to specify the name of the folder in the YYYY format (Ex. 2015, 1944)
# =============================================================================
# Set start and end values of longtitude & latitude: 
lon_start=120
lon_end=150
lat_start=30
lat_end=50
for years in *; do
    if [ -d "$years" ]; then
        cd ${years}
        for params in *; do
            if [ -d "$params" ]; then
                cd ${params}
                cp ../../grb2_to_dat.gs grb2_to_dat_cp.gs 
                echo $years $lon_start $lon_end $lat_start $lat_end $params | opengrads -blc "run grb2_to_dat_cp.gs"
                rm grb2_to_dat_cp.gs
                cd ..
            fi;
        done;
        cd ..   
    fi;
done;