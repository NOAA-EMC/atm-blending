
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
STARTDATE="2018-09-01T12:00:00"
ENDDATE="2018-09-17T00:00:00"
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
FILEGFS='\/NCEPPROD\/hpssprod\/runhistory\/rh\$\{YY\}\/\$\{YY\}\$\{MM\}\/\$\{YY\}\$\{MM\}\$\{DD\}\/gpfs_hps_nco_ops_com_gfs_prod_gfs.\$\{YY\}\$\{MM\}\$\{DD\}\$\{HH\}.pgrb2_0p25.tar'
#name of files in the tar file
atmosGFS='.\/gfs.t\$\{HH\}z.pgrb2.0p25.f00'
###############################################################################
#HRRR
#HPSS path
FILEHRRR='\/NCEPPROD\/hpssprod\/runhistory\/rh\$\{YY\}\/\$\{YY\}\$\{MM\}\/\$\{YY\}\$\{MM\}\$\{DD\}\/gpfs_hps_nco_ops_com_hrrr_prod_hrrr.\$\{YY\}\$\{MM\}\$\{DD\}'
###############################################################################
#RAP
#HPSS path
FILERAP='\/NCEPPROD\/hpssprod\/runhistory\/rh\$\{YY\}\/\$\{YY\}\$\{MM\}\/\$\{YY\}\$\{MM\}\$\{DD\}\/gpfs_hps_nco_ops_com_rap_prod_rap.\$\{YY\}\$\{MM\}\$\{DD\}'
###############################################################################
#HWRF
#event
export event=florence06l
#HPSS path
export HWRFsource=/NCEPDEV/emc-hwrf/5year/Zaizhong.Ma/coastal/hiresmasks/florence_2018/expens_florence
#Start and End date
HWRF_STARTDATE="2018-09-01T12:00:00"
HWRF_ENDDATE="2018-09-17T00:00:00"
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
lon_w='278.0'
lon_e='288.0'
lat_s='27.0'
lat_n='37.0'
DELTAT='1.0'
##############################################################################
# unstructured meshes
export fix_mesh=/scratch2/COASTAL/coastal/save/fix_WW3_Optimization/Meshes
export unstr_mesh=EC_120m.msh
