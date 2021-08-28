# atm-blending
Atmospheric blending for COASTAL Act application

Users who only need to check out the latest code or certain tags can clone the repository without having a GitHub account:   
`git clone https://github.com/NOAA-EMC/atm-blending.git`   
or with GitHub account   
`git clone git@github.com:NOAA-EMC/atm-blending.git`     
`cd atm-blending`      
      

### 0- Fill the templates and retrieve the forcings from hpss from operation RAP, GFS, HRRR and COASTAL Act HWRF 
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

Add the master blend domain corner (_lon_min_ and _lat_min_),  dimension (_nlon_ and _nlat_) and spatial resolution (_dlon_ and _dlat_).     
Define the path to NDBC observations and define the regional domain coverage (_lon_w_, _lon_e_ and _lat_s_, _lat_n_).     
     

 execute   
`bash prep.sh`   
This program fills the templates templates:     
- Atmospheric model outputs retrival from HPSS (grib2 format).    
- Atmospheric model interpolation to master blend domain and grib2 to NetCDF format conversion.    
- Observation data retrieval:    
   NDBC:     
   It is taken from [NDBC](https://dods.ndbc.noaa.gov/) and avialable locally in _NDBCfiles_.     
   Satellite ([coastwatch](https://coastwatch.noaa.gov/cw/satellite-data-products/sea-surface-height/along-track.html)):     
   - Jason-3: ftp://ftpcoastwatch.noaa.gov/pub/socd/lsa/johnk/coastwatch/j3    
   - Sentinel-3A: ftp://ftpcoastwatch.noaa.gov/pub/socd/lsa/johnk/coastwatch/3a     
   - Sentinel-3B: ftp://ftpcoastwatch.noaa.gov/pub/socd/lsa/johnk/coastwatch/3b    
   - CryoSat-2: ftp://ftpcoastwatch.noaa.gov/pub/socd/lsa/johnk/coastwatch/c2     
   - SARAL: ftp://ftpcoastwatch.noaa.gov/pub/socd/lsa/johnk/coastwatch/sa     
   - Jason-2: ftp://ftpcoastwatch.noaa.gov/pub/socd/lsa/johnk/coastwatch/j2 (available through 1 Oct. 2019).     
           
- Blending and recipe scripts:
   - hwrf model integration: `forcing/blending_routine_hwrf.m`    
   - Statitical analysis to determine the master _recipe_: `forcing/recipe_prep.m`   
   - Blending: `forcing/blending_routine.m`      
- Interpolation on unstrcutured meshes for WW3 and ADCRIC models
   - `forcing/str_2_unstr_interp.m`     
 
## The generated programs should be excuted  in the following order:    
### 1- ATM Data Retrieval. 
- GFS output retrieval from HPSS (login node):       
 `forcing/retrieve_atm_gfs_hpss.sh`      
- GFS output interpolation on the master blend domain and convert grib2 to NeTCDF (computational node):       
 `forcing/gfs_grib2_to_nc4.sh` (optional)      
- HRRR output retrieval from HPSS (login node):       
 `forcing/retrieve_atm_hrrr_hpss.sh`      
- HRRR output interpolation on the master blend domain and convert grib2 to NeTCDF (computational node):       
 `forcing/hrrr_grib2_to_nc4.sh` (optional)      
- HWRF output retrieval from HPSS (login node):       
 `forcing/retrieve_atm_hwrf_hpss.sh`      
- HWRF output interpolation on the master blend domain and convert grib2 to NeTCDF (computational node):       
 `forcing/hwrf_grib2_to_nc4.sh` (optional)      
- RAP output retrieval from HPSS (login node):       
 `forcing/retrieve_atm_rap_hpss.sh`      
- RAP model output projection NCEP rotated latlon (cmoputational node):     
 `forcing/rap_grib2_projection.sh`      
- RAP output interpolation on the master blend domain and convert grib2 to NeTCDF (cmoputational node):       
 `forcing/rap_grib2_to_nc4.sh` (optional)    
- Integrate HWRF outputs (native grids: core, storm, synoptic) with cycle2cycle smoothing (computational node):       
 `forcing/blending_routine_hwrf.m`      
### 2- Observaton Data Retrieval.      
- Buoy (login node):       
 `forcing/retrieve_buoy.sh`      
- Satellite Altimeters (login node):      
 `forcing/retrieve_sat_alt.sh`      
### 3- Statistical Analysis and recipe preparation.     
![stat](https://user-images.githubusercontent.com/37336972/131204538-ec5bc597-4510-48ff-8452-030b0f5f42e6.png)

- Recipe preparation based models' output comparison with observations (RMSE) within impacted area (computational node):        
 `forcing/recipe_prep.m`    
 This script generates `Statiscital_Anaylsis.log` and `recipe`.      
### 4- Master Blend Preparation.      
- Blending model outputs based on the `recipe` (computational node):    
 `forcing/blending_routine.m`      
### 5- Interpolation on Downstream models' domain.      
- Interpolation on the trinagular unstructured mesh- hourly (computational node):      
 `forcing/str_2_unstr_interp.m`      
 - Append hourly atmospheric foricng including wind speed at 10 m and pressure at MSL into one single netcdf file (computational node):      
 `forcing/append_unstr_nc4.sh`      
### 6- plotting the Master blend (optional).    
- plotting atmospheric forcing from the master blend files on the master blend domain:      
 `forcing/plotting_master_blend.m`    
- plotting atmospheric forcing from the master blend interpolated on the unstructured domain:      
 `forcing/plotting_master_blend_unstr.m`     
