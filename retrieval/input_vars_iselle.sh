
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
STARTDATE="2014-07-30T00:00:00"
ENDDATE="2014-08-13T00:00:00"
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
FILEGFS='\/NCEPPROD\/hpssprod\/runhistory\/rh\$\{YY\}\/\$\{YY\}\$\{MM\}\/\$\{YY\}\$\{MM\}\$\{DD\}\/com_gfs_prod_gfs.\$\{YY\}\$\{MM\}\$\{DD\}\$\{HH\}.pgrb2_0p25.tar'
#name of files in the tar file
atmosGFS='.\/gfs.t\$\{HH\}z.pgrb2.0p25.f00'
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
export event=iselle09e
#HPSS path
export HWRFsource=/NCEPDEV/emc-hwrf/5year/Zaizhong.Ma/coastal/hiresmasks/iselle_2014/expens_iselle
#Start and End date
HWRF_STARTDATE="2014-07-31T18:00:00"
HWRF_ENDDATE="2014-08-09T18:00:00"
# HWRf time interval [hr]
HWRF_DT=1; 
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
export ATM1DEF=hwrf
export ATM2DEF=cfs
export ATM3DEF=cfs
export ATM4DEF=cfs
###############################################################################
#interpolation (master blend coverage)
lon_min='97.0'
nlon='12801'
dlon='0.015' 
lat_min='-34.0'
nlat='6801'
dlat='0.015'
#compression precision
dp='3'
##############################################################################
# observation
#NDBC
export NDBCfiles=/scratch2/COASTAL/coastal/save/NDBC
#statistical anaysis (impact area coverage)
lon_w='195.0'
lon_e='20.0'
lat_s='15.0'
lat_n='25.0'
DELTAT='1.0'
##############################################################################
# unstructured meshes
export fix_mesh=/scratch2/COASTAL/coastal/save/fix_WW3_Optimization/Meshes
export unstr_mesh=GESTOFS_Pacific_V2.msh
