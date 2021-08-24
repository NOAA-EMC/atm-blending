#!/bin/bash
set -eux

HOME=${PWD}
#-----------------------------------------------------------------------------------#
if [ ! -r $HOME/forcing ];then mkdir $HOME/forcing
else
echo -e "\e[34m$HOME/forcing exists\e[0m"
fi
if [ ! -r $HOME/obs ];then mkdir $HOME/obs
else
echo -e "\e[34m$HOME/obs exists\e[0m"
fi

#-----------------------------------------------------------------------------------#
#                          1- Forcing GFS (0.25 deg)                                #
#-----------------------------------------------------------------------------------#
export FORCING_T="GFS"
#netcdf
NETCDF_SWITCH="YES"
NETCDF_COMP="NO"
source edit_inputs.sh
edit_forcing_gfs < parm/retrieve_atm_gfs_hpss.sh.IN > forcing/retrieve_atm_gfs_hpss.sh
edit_forcing_gfs < parm/gfs_grib2_to_nc4.sh.IN > forcing/gfs_grib2_to_nc4.sh
echo -e "\e[34mGFS Forcing templates are filled\e[0m"
#-----------------------------------------------------------------------------------#
#                          2- Forcing HRRR (3 km)                                   #
#-----------------------------------------------------------------------------------#
export FORCING_T="HRRR"
#netcdf
NETCDF_SWITCH="YES"
NETCDF_COMP="NO"
source edit_inputs.sh
edit_forcing_hrrr < parm/retrieve_atm_hrrr_hpss.sh.IN > forcing/retrieve_atm_hrrr_hpss.sh
edit_forcing_hrrr < parm/hrrr_grib2_to_nc4.sh.IN > forcing/hrrr_grib2_to_nc4.sh
echo -e "\e[34mHRRR Forcing templates are filled\e[0m"
#-----------------------------------------------------------------------------------#
#                          3- Forcing RAP (13 km)                                   #
#-----------------------------------------------------------------------------------#
export FORCING_T="RAP"
#netcdf
NETCDF_SWITCH="NO"
NETCDF_COMP="NO"
source edit_inputs.sh
edit_forcing_rap < parm/retrieve_atm_rap_hpss.sh.IN > forcing/retrieve_atm_rap_hpss.sh
echo -e "\e[34mRAP Forcing templates are filled\e[0m"
#-----------------------------------------------------------------------------------#
#                          4- Forcing HWRF                                          #
#-----------------------------------------------------------------------------------#
export FORCING_T="HWRF"
#netcdf
NETCDF_SWITCH="YES"
NETCDF_COMP="NO"
source edit_inputs.sh
edit_forcing_hwrf < parm/retrieve_atm_hwrf_hpss.sh.IN > forcing/retrieve_atm_hwrf_hpss.sh
edit_forcing_hwrf < parm/hwrf_grib2_to_nc4.sh.IN > forcing/hwrf_grib2_to_nc4.sh
echo -e "\e[34mHWRF Forcing templates are filled\e[0m"
#-----------------------------------------------------------------------------------#
#                     5- Observation (satellite and buoy)                           #
#-----------------------------------------------------------------------------------#
# satellite
source edit_inputs.sh
edit_obs < parm/retrieve_sat_alt.sh.IN > obs/retrieve_sat_alt.sh
echo -e "\e[34mSatellite obs templates is filled\e[0m"
# buoy
edit_obs < parm/retrieve_buoy.sh.IN > obs/retrieve_buoy.sh
echo -e "\e[34mBuoy obs templates is filled\e[0m"
#-----------------------------------------------------------------------------------#
#                     6- Blending and recipe                                        #
#-----------------------------------------------------------------------------------#
source edit_inputs.sh
edit_blending < parm/blending_routine.m.IN > forcing/blending_routine.m
edit_blending < parm/blending_routine_hwrf.m.IN > forcing/blending_routine_hwrf.m
edit_recipe < parm/recipe_prep.m.IN > forcing/recipe_prep.m

#-----------------------------------------------------------------------------------#
#                             EXECUTION                                             #
#-----------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------#
#                          7- Forcing GFS (0.25 deg) Retrieval                      #
#-----------------------------------------------------------------------------------#
cd ${HOME}/forcing
      bash retrieve_atm_gfs_hpss.sh
      echo -e "\e[31mGFS ATM file is retrieved\e[0m"     
#-----------------------------------------------------------------------------------#
#                          8- Forcing HRRR (3 km) Retrieval                         #
#-----------------------------------------------------------------------------------#
cd ${HOME}/forcing
      bash retrieve_atm_hrrr_hpss.sh
      echo -e "\e[31mHRRR ATM file is retrieved\e[0m"     
#-----------------------------------------------------------------------------------#
#                          9- Forcing RAP (13 km) Retrieval                         #
#-----------------------------------------------------------------------------------#
cd ${HOME}/forcing
#      bash retrieve_atm_rap_hpss.sh
      echo -e "\e[31mRAP ATM file is retrieved\e[0m"     
#-----------------------------------------------------------------------------------#
#                         10- Forcing HWRF Retrieval                                #
#-----------------------------------------------------------------------------------#
cd ${HOME}/forcing
      bash retrieve_atm_hwrf_hpss.sh
      echo -e "\e[31mHWRF ATM file is retrieved\e[0m"     
#-----------------------------------------------------------------------------------#
#                          11- observation                                          #
#-----------------------------------------------------------------------------------#
cd $HOME/obs
    echo -e "\e[36mObservations Retrieval ...\e[0m"
#satellite
   if [ -f satellite_obs.nc ]
   then
       echo -e "\e[34msatellite_obs.nc file exists\e[0m"
    else
       bash retrieve_sat_alt.sh
       echo -e "\e[31mSatellite files are downloaded\e[0m"
   fi
#-----------------------------------------------------------------------------------#
# buoy
   if [ -f BUOY.nc ]
   then
       echo -e "\e[34mBUOY.nc file exists\e[0m"
    else
       bash retrieve_buoy.sh
       echo -e "\e[31mBuoy files are downloaded\e[0m"
   fi
#-----------------------------------------------------------------------------------#

