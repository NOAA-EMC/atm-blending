#! /usr/bin/env bash
set -eu

source input_vars.sh

function edit_forcing_gfs {

  SDATEATM="${SYEAR}-${SMONTH}-${SDAY}"
  EDATEATM="${EYEAR}-${EMONTH}-${EDAY}"
  sed  -e "s/FRC_BEG/$SDATEATM/g" \
       -e "s/FRC_END/$EDATEATM/g" \
       -e "s/NETCDF_SWITCH/$NETCDF_SWITCH/g" \
       -e "s/NETCDF_COMP/$NETCDF_COMP/g" \
       -e "s/LON_MIN/$lon_min/g" \
       -e "s/NLON/$nlon/g" \
       -e "s/DLON/$dlon/g" \
       -e "s/LAT_MIN/$lat_min/g" \
       -e "s/NLAT/$nlat/g" \
       -e "s/DLAT/$dlat/g" \
       -e "s/DP/$dp/g" \
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
       -e "s/NETCDF_COMP/$NETCDF_COMP/g" \
       -e "s/LON_MIN/$lon_min/g" \
       -e "s/NLON/$nlon/g" \
       -e "s/DLON/$dlon/g" \
       -e "s/LAT_MIN/$lat_min/g" \
       -e "s/NLAT/$nlat/g" \
       -e "s/DLAT/$dlat/g" \
       -e "s/DP/$dp/g" \
       -e "s/FILEHPSS/$FILEHRRR/g" \
       -e "s/FORCING_T/${FORCING_T}/g"
}

function edit_forcing_rap {

  SDATEATM="${SYEAR}-${SMONTH}-${SDAY}"
  EDATEATM="${EYEAR}-${EMONTH}-${EDAY}"
  sed  -e "s/FRC_BEG/$SDATEATM/g" \
       -e "s/FRC_END/$EDATEATM/g" \
       -e "s/NETCDF_SWITCH/$NETCDF_SWITCH/g" \
       -e "s/NETCDF_COMP/$NETCDF_COMP/g" \
       -e "s/LON_MIN/$lon_min/g" \
       -e "s/NLON/$nlon/g" \
       -e "s/DLON/$dlon/g" \
       -e "s/LAT_MIN/$lat_min/g" \
       -e "s/NLAT/$nlat/g" \
       -e "s/DLAT/$dlat/g" \
       -e "s/DP/$dp/g" \
       -e "s/FILEHPSS/$FILERAP/g" \
       -e "s/FORCING_T/${FORCING_T}/g"
}


function edit_forcing_hwrf {

  SDATEATM="${HSYEAR}-${HSMONTH}-${HSDAY}T${HSHOUR}:00:00"
  EDATEATM="${HEYEAR}-${HEMONTH}-${HEDAY}T${HEHOUR}:00:00"
  sed  -e "s/HFRC_BEG/$SDATEATM/g" \
       -e "s/HFRC_END/$EDATEATM/g" \
       -e "s/NETCDF_SWITCH/$NETCDF_SWITCH/g" \
       -e "s/NETCDF_COMP/$NETCDF_COMP/g" \
       -e "s/LON_MIN/$lon_min/g" \
       -e "s/NLON/$nlon/g" \
       -e "s/DLON/$dlon/g" \
       -e "s/LAT_MIN/$lat_min/g" \
       -e "s/NLAT/$nlat/g" \
       -e "s/DLAT/$dlat/g" \
       -e "s/DP/$dp/g" \
       -e "s/FORCING_T/${FORCING_T}/g"
}


function edit_obs {

  SDATE="${SYEAR}-${SMONTH}-${SDAY}"
  EDATE="${EYEAR}-${EMONTH}-${EDAY}"
  sed  -e "s/FRC_BEG/$SDATE/g" \
       -e "s/FRC_END/$EDATE/g"
}

function edit_blending {

  SDATEHWRF="${HSYEAR}${HSMONTH}${HSDAY} ${HSHOUR}:00:00"  
  EDATEHWRF="${HEYEAR}${HEMONTH}${HEDAY} ${HEHOUR}:00:00"
  sed -e "s/HFRC_BEG/$SDATEHWRF/g" \
      -e "s/HFRC_END/$EDATEHWRF/g" \
      -e "s/EVENT/$event/g" \
      -e "s/NLON/$nlon/g"\
      -e "s/NLAT/$nlat/g"
}

function edit_smoothing {

  SDATEATM="${SYEAR}-${SMONTH}-${SDAY}"
  EDATEATM="${EYEAR}-${EMONTH}-${EDAY}"
  sed  -e "s/FRC_BEG/$SDATEATM/g" \
       -e "s/FRC_END/$EDATEATM/g"
}

function edit_recipe {

  SDATEATM="${SYEAR}${SMONTH}${SDAY} ${SHOUR}:00:00"
  EDATEATM="${EYEAR}${EMONTH}${EDAY} ${EHOUR}:00:00"
  sed  -e "s/FRC_BEG/$SDATEATM/g" \
       -e "s/FRC_END/$EDATEATM/g" \
       -e "s/LONW/$lon_w/g" \
       -e "s/LONE/$lon_e/g" \
       -e "s/LATS/$lat_s/g" \
       -e "s/LATN/$lat_n/g"
}

function edit_unstr_interp {

  SDATEATM="${SYEAR}${SMONTH}${SDAY} ${SHOUR}:00:00"
  EDATEATM="${EYEAR}${EMONTH}${EDAY} ${EHOUR}:00:00"
  sed  -e "s/FRC_BEG/$SDATEATM/g" \
       -e "s/FRC_END/$EDATEATM/g" \
       -e "s/UNSTR_MESH/$unstr_mesh/g" \
       -e "s/EVENT/$event/g" \
       -e "s/NLON/$nlon/g"\
       -e "s/NLAT/$nlat/g"
}
