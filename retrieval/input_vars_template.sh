
###############################################################################
#
# Export variables to the input values
#
###############################################################################
HOME=${PWD}
MAIN=${PWD%/*}
export HOME_PATH="${HOME}"
export FOECING_PATH="${HOME}/forcing"
export MAINDIR="${MAIN}"
###############################################################################
#Operational HRRR, RAP, GFS
###############################################################################
#Start and End date for operational products
STARTDATE=<"yyyy-mm-ddTHH:MM:SS"> # FILL
ENDDATE=<"yyyy-mm-ddTHH:MM:SS"> #FILL
startd=$(date -d $STARTDATE +%s)
endd=$(date -d $ENDDATE +%s)
export SYEAR=$(date -d @$startd '+%Y')
export SMONTH=$(date -d @$startd '+%m')
export SDAY=$(date -d @$startd '+%d')
export SHOUR=$(date -d @$startd '+%2H')
export EYEAR=$(date -d @$endd '+%Y')
export EMONTH=$(date -d @$endd '+%m')
export EDAY=$(date -d @$endd '+%d')
export EHOUR=$(date -d @$endd '+%2H')
###############################################################################
#GFS
#HPSS path
FILEGFS=<'\/NCEPPROD\/hpssprod\/runhistory\/rh\$\{YY\}\/\$\{YY\}\$\{MM\}\/\$\{YY\}\$\{MM\}\$\{DD\}\/com_gfs_prod_gfs.\$\{YY\}\$\{MM\}\$\{DD\}_\$\{HH\}.gfs_pgrb2.tar'> # MODIFY (The archive format changes year to year)
#name of files in the tar file
atmosGFS=<'.\/gfs.\$\{YY\}\$\{MM\}\$\{DD\}\/\$\{HH\}\/atmos\/gfs.t\$\{HH\}z.pgrb2.0p25.f00'> # MODIFY (The archive format changes year to year)
###############################################################################
#HRRR
#HPSS path
FILEHRRR=<'\/NCEPPROD\/hpssprod\/runhistory\/rh\$\{YY\}\/\$\{YY\}\$\{MM\}\/\$\{YY\}\$\{MM\}\$\{DD\}\/com_hrrr_prod_hrrr.\$\{YY\}\$\{MM\}\$\{DD\}'> # MODIFY (The archive format changes year to year)
###############################################################################
#RAP
#HPSS path
FILERAP=<'\/NCEPPROD\/hpssprod\/runhistory\/rh\$\{YY\}\/\$\{YY\}\$\{MM\}\/\$\{YY\}\$\{MM\}\$\{DD\}\/com_rap_prod_rap.\$\{YY\}\$\{MM\}\$\{DD\}'> # MODIFY (The archive format changes year to year)
###############################################################################
#HWRF
#event
export event=<ida09l> # MODIFY (take the name from https://www.nhc.noaa.gov/gis/archive_besttrack.php?year=2021)
#HPSS path
export HWRFsource=</NCEPPROD/2year/hpssprod/runhistory/rh2021/hwrf/09l> MODIFY
#Start and End date
HWRF_STARTDATE=<"yyyy-mm-ddTHH:MM:SS"> # FILL
HWRF_ENDDATE=<"yyyy-mm-ddTHH:MM:SS"> # FILL
# HWRf time interval [hr]
HWRF_DT=3; 
starth=$(date -d $HWRF_STARTDATE +%s)
endh=$(date -d $HWRF_ENDDATE +%s)
export HSYEAR=$(date -d @$starth '+%Y')
export HSMONTH=$(date -d @$starth '+%m')
export HSDAY=$(date -d @$starth '+%d')
export HSHOUR=$(date -d @$starth '+%2H')
export HEYEAR=$(date -d @$endh '+%Y')
export HEMONTH=$(date -d @$endh '+%m')
export HEDAY=$(date -d @$endh '+%d')
export HEHOUR=$(date -d @$endh '+%2H')
###############################################################################
#interpolation (master blend coverage)
lon_min=<'226.0'> # FILL
nlon=<'5600'> # FILL
dlon=<'0.015'> # FILL 
lat_min=<'5.0'> # FILL
nlat=<'3700'> # FILL
dlat=<'0.015'> # FILL
#compression precision
dp='3'
##############################################################################
# observation
#NDBC
export NDBCfiles=</scratch2/COASTAL/coastal/save/NDBC> # FILL
#statistical anaysis (impact area coverage)
lon_w=<'265.0'> # FILL
lon_e=<'275.0'> # FILL
lat_s=<'20.0'> # FILL
lat_n=<'30.0'> # FILL
DELTAT=<'1.0'> # FILL
##############################################################################
# unstructured meshes
export fix_mesh=</scratch2/COASTAL/coastal/save/fix_WW3_Optimization/Meshes> # FILL
export unstr_mesh=<EC_120m.msh> # FILL
