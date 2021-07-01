#! /usr/bin/env bash
set -eu

source input_vars.sh

function edit_forcing_gfs {

  SDATEATM="${SYEAR}-${SMONTH}-${SDAY}"
  EDATEATM="${EYEAR}-${EMONTH}-${EDAY}"
  sed  -e "s/FRC_BEG/$SDATEATM/g" \
       -e "s/FRC_END/$EDATEATM/g" \
       -e "s/NETCDF_SWITCH/$NETCDF_SWITCH/g" \
       -e "s/FILEHPSS/$FILEGFS/g" \
       -e "s/atmosHPSS/$atmosGFS/g" \
       -e "s/FORCING_T/${FORCING_T}/g"
}

function edit_forcing_hrrr {

  SDATEATM="${SYEAR}-${SMONTH}-${SDAY}"
  EDATEATM="${EYEAR}-${EMONTH}-${EDAY}"
  sed  -e "s/FRC_BEG/$SDATEATM/g" \
       -e "s/FRC_END/$EDATEATM/g" \
       -e "s/NETCDF_SWITCH/$NETCDF_SWITCH/g" \
       -e "s/FILEHPSS/$FILEHRRR/g" \
       -e "s/FORCING_T/${FORCING_T}/g"
}

function edit_forcing_rap {

  SDATEATM="${SYEAR}-${SMONTH}-${SDAY}"
  EDATEATM="${EYEAR}-${EMONTH}-${EDAY}"
  sed  -e "s/FRC_BEG/$SDATEATM/g" \
       -e "s/FRC_END/$EDATEATM/g" \
       -e "s/NETCDF_SWITCH/$NETCDF_SWITCH/g" \
       -e "s/FILEHPSS/$FILERAP/g" \
       -e "s/FORCING_T/${FORCING_T}/g"
}


function edit_forcing_hwrf {

  SDATEATM="${HSYEAR}-${HSMONTH}-${HSDAY}T${HSHOUR}:00:00"
  EDATEATM="${HEYEAR}-${HEMONTH}-${HEDAY}T${HEHOUR}:00:00"
  sed  -e "s/HFRC_BEG/$SDATEATM/g" \
       -e "s/HFRC_END/$EDATEATM/g" \
       -e "s/NETCDF_SWITCH/$NETCDF_SWITCH/g" \
       -e "s/FORCING_T/${FORCING_T}/g"
}
