# atm-blending
Atmospheric blending for COASTAL Act application

Users who only need to check out the latest code or certain tags can clone the repository without having a GitHub account:   
`git clone https://github.com/NOAA-EMC/atm-blending.git`   
or with GitHub account   
`git clone git@github.com:NOAA-EMC/atm-blending.git`     
`cd atm-blending`      
      

## Fill the templates and retrieve the forcings from hpss from operation RAP, GFS, HRRR and COASTAL Act HWRF 
cd retrieval   
### modify _input_var.sh_
add the path on HPSS for GFS, RAP and HRRR:   
`FILEGFS=<path on hpss to GFS tar files>`   
`atmosGFS=<path on hpss to GFS tar files>`   
`FILEHRRR=<path on hpss to HRRR tar files>`   
`FILERAP=<path on hpss to RAP tar files>`   

and add the start day (_STARTDATE_) end day (_ENDDATE_) for operational products (RAP, HRRR and GFS):    
`STARTDATE="YYYY-MM-DDTHH:MM:SS"`    
` ENDDATE=""YYYY-MM-DDTHH:MM:SS"`  


For COASTAL Act HWRF:   
aadd the path on HPSS HWRF   
`HWRFsource=<path on hpss to HWRF tar files>`   
 and add the start day (_HWRF_STARTDATE_) end day (_HWRF_STARTDATE_)    
`HWRF_STARTDATE="YYYY-MM-DDTHH:MM:SS"`   
`HWRF_ENDDATE="YYYY-MM-DDTHH:MM:SS"`   


 execute   
`bash prep.sh`  
