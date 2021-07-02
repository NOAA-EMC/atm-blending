#!/bin/bash
set -eux

HOME=${PWD}
#-----------------------------------------------------------------------------------#
if [ ! -r $HOME/forcing ];then mkdir $HOME/forcing
else
echo -e "\e[34m$HOME/forcing exists\e[0m"
fi
#-----------------------------------------------------------------------------------#
#                          1- Forcing GFS (0.25 deg)                                #
#-----------------------------------------------------------------------------------#
export FORCING_T="GFS"
#netcdf
NETCDF_SWITCH="YES"
source edit_inputs.sh
edit_forcing_gfs < parm/retrieve_atm_gfs_hpss.sh.IN > forcing/retrieve_atm_gfs_hpss.sh
echo -e "\e[34mGFS Forcing templates are filled\e[0m"
#-----------------------------------------------------------------------------------#
#                          2- Forcing HRRR (3 km)                                   #
#-----------------------------------------------------------------------------------#
export FORCING_T="HRRR"
#netcdf
NETCDF_SWITCH="YES"
source edit_inputs.sh
edit_forcing_hrrr < parm/retrieve_atm_hrrr_hpss.sh.IN > forcing/retrieve_atm_hrrr_hpss.sh
echo -e "\e[34mHRRR Forcing templates are filled\e[0m"
#-----------------------------------------------------------------------------------#
#                          3- Forcing RAP (13 km)                                   #
#-----------------------------------------------------------------------------------#
export FORCING_T="RAP"
#netcdf
NETCDF_SWITCH="NO"
source edit_inputs.sh
edit_forcing_rap < parm/retrieve_atm_rap_hpss.sh.IN > forcing/retrieve_atm_rap_hpss.sh
echo -e "\e[34mRAP Forcing templates are filled\e[0m"
#-----------------------------------------------------------------------------------#
#                          4- Forcing HWRF                                          #
#-----------------------------------------------------------------------------------#
export FORCING_T="HWRF"
#netcdf
NETCDF_SWITCH="YES"
source edit_inputs.sh
edit_forcing_hwrf < parm/retrieve_atm_hwrf_hpss.sh.IN > forcing/retrieve_atm_hwrf_hpss.sh
echo -e "\e[34mHWRF Forcing templates are filled\e[0m"
#-----------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------#
#                             EXECUTION                                             #
#-----------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------#
#                          5- Forcing GFS (0.25 deg) Retrieval                      #
#-----------------------------------------------------------------------------------#
cd ${HOME}/forcing
      bash retrieve_atm_gfs_hpss.sh
      echo -e "\e[31mGFS ATM file is retrieved\e[0m"     
#-----------------------------------------------------------------------------------#
#                          6- Forcing HRRR (3 km) Retrieval                         #
#-----------------------------------------------------------------------------------#
cd ${HOME}/forcing
      bash retrieve_atm_hrrr_hpss.sh
      echo -e "\e[31mHRRR ATM file is retrieved\e[0m"     
#-----------------------------------------------------------------------------------#
#                          7- Forcing RAP (13 km) Retrieval                         #
#-----------------------------------------------------------------------------------#
cd ${HOME}/forcing
      bash retrieve_atm_rap_hpss.sh
      echo -e "\e[31mRAP ATM file is retrieved\e[0m"     
#-----------------------------------------------------------------------------------#
#                          8- Forcing HWRF Retrieval                                #
#-----------------------------------------------------------------------------------#
cd ${HOME}/forcing
      bash retrieve_atm_hwrf_hpss.sh
      echo -e "\e[31mHWRF ATM file is retrieved\e[0m"     
#-----------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------#

