pull data

year = subwrd(data,1)
lon_start = subwrd(data,2)
lon_end = subwrd(data,3)
lat_start = subwrd(data,4)
lat_end = subwrd(data,5)
param = subwrd(data,6)
month=1

say year' 'lon_start' 'lon_end' 'lat_start' 'lat_end' 'param

while(month<13)
    if (month<10)
        'open 'param'.cdas1.'year'0'month'.ctl'
    endif
    if (month>9)
        'open 'param'.cdas1.'year''month'.ctl'
    endif

    'q file' 
    line_1 = sublin(result, 1)
    status = subwrd(line_1, 1)
    if (status = 'No')
        if (month<10)
            say '! ERROR OPENNING FILE 'param'.cdas1.'year'0'month'.ctl'
        endif
        if (month>9)
            say '! ERROR OPENNING FILE 'param'.cdas1.'year''month'.ctl'
        endif
    else
    
        'set lon 'lon_start' 'lon_end
        'set lat 'lat_start' 'lat_end 
        'q file'    
        line_5 = sublin(result, 5)
        line_6 = sublin(result, 6)
        line_7 = sublin(result, 7)
        TimeSteps = subwrd(line_5, 12)
        NumOfVars = subwrd(line_6, 5)
        opt = subwrd(line_7, 1)

        'set t 1 ' TimeSteps
	'set gxout fwrite' 

        if (month<10)
            say 'writing 'param'.cdas1.'year'0'month'.ctl'
            'set fwrite 'opt'.cdas1.'year'0'month'.dat'
        endif

        if (month>9)
            say 'writing 'param'.cdas1.'year''month'.ctl'
            'set fwrite 'opt'.cdas1.'year''month'.dat'
        endif

        'd 'opt
        'disable fwrite'
        'close 1'

        if (param='wnd10m')
                if (month<10)
                    'open 'param'.cdas1.'year'0'month'.ctl'
                endif
                if (month>9)
                    'open 'param'.cdas1.'year''month'.ctl'
                endif

                'q file' 
            line_1 = sublin(result, 1)
            status = subwrd(line_1, 1)
            if (status = 'No')
                if (month<10)
                    say '! ERROR OPENNING FILE 'param'.cdas1.'year'0'month'.ctl'
                endif
                if (month>9)
                    say '! ERROR OPENNING FILE 'param'.cdas1.'year''month'.ctl'
                endif
            else
            
                'set lon 'lon_start' 'lon_end
        	'set lat 'lat_start' 'lat_end
                'q file'    
                line_5 = sublin(result, 5)
                line_6 = sublin(result, 6)
                line_8 = sublin(result, 8)
                TimeSteps = subwrd(line_5, 12)
                NumOfVars = subwrd(line_6, 5)
                opt_1 = subwrd(line_8, 1)

                'set t 1 ' TimeSteps
                'set gxout fwrite'  
	
                if (month<10)
                    say 'writing 'param'.cdas1.'year'0'month'.ctl'
                    'set fwrite 'opt_1'.cdas1.'year'0'month'.dat'
                endif

                if (month>9)
                    say 'writing 'param'.cdas1.'year''month'.ctl'
                    'set fwrite 'opt_1'.cdas1.'year''month'.dat'
                endif

                'd 'opt_1
                'disable fwrite'
                'close 1'

            endif

        endif
    endif
    month=month+1
endwhile
