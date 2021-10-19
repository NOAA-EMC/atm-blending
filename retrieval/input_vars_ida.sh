
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
STARTDATE="2021-08-26T00:00:00"
ENDDATE="2021-09-05T00:00:00"
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
FILEGFS='\/NCEPPROD\/hpssprod\/runhistory\/rh\$\{YY\}\/\$\{YY\}\$\{MM\}\/\$\{YY\}\$\{MM\}\$\{DD\}\/com_gfs_prod_gfs.\$\{YY\}\$\{MM\}\$\{DD\}_\$\{HH\}.gfs_pgrb2.tar'
#name of files in the tar file
atmosGFS='.\/gfs.\$\{YY\}\$\{MM\}\$\{DD\}\/\$\{HH\}\/atmos\/gfs.t\$\{HH\}z.pgrb2.0p25.f00'
###############################################################################
#HRRR
#HPSS path
FILEHRRR='\/NCEPPROD\/hpssprod\/runhistory\/rh\$\{YY\}\/\$\{YY\}\$\{MM\}\/\$\{YY\}\$\{MM\}\$\{DD\}\/com_hrrr_prod_hrrr.\$\{YY\}\$\{MM\}\$\{DD\}'
###############################################################################
#RAP
#HPSS path
FILERAP='\/NCEPPROD\/hpssprod\/runhistory\/rh\$\{YY\}\/\$\{YY\}\$\{MM\}\/\$\{YY\}\$\{MM\}\$\{DD\}\/com_rap_prod_rap.\$\{YY\}\$\{MM\}\$\{DD\}'
###############################################################################
#HWRF
#event
export event=ida09l
#HPSS path
#operational hwrf
export HWRFsource=/NCEPPROD/2year/hpssprod/runhistory/rh2021/hwrf/09l
#Start and End date
HWRF_STARTDATE="2021-08-27T00:00:00"
HWRF_ENDDATE="2021-08-30T12:00:00"
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
export ATM1DEF=hrrr
export ATM2DEF=rap
export ATM3DEF=gfs
export ATM4DEF=gfs
###############################################################################
#interpolation
lon_min='226.0'
nlon='5600'
dlon='0.015' 
lat_min='5.0'
nlat='3700'
dlat='0.015'
#compression precision
dp='3'
##############################################################################
# observation
#NDBC
export NDBCfiles=/scratch2/COASTAL/coastal/save/NDBC
#statistical anaysis
lon_w='265.0'
lon_e='275.0'
lat_s='20.0'
lat_n='30.0'
DELTAT='1.0'
##############################################################################
# unstructured meshes
export fix_mesh=/scratch2/COASTAL/coastal/save/fix_WW3_Optimization/Meshes
export unstr_mesh=EC_120m.msh
