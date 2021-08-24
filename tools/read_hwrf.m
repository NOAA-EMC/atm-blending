function [hwrf]=read_hwrf(atm_model,YYYY,MM,DD,HH,var,nx,ny)
%read HWRF
% read ranks
hwrf_grids={'core','storm','synoptic'};
% determine the cycle and forecast hour
FF0=rem(HH,6);
HH0=HH-FF0;
t0=datenum([YYYY,MM,DD,HH0,0,0]);
% define the previous cycle and corresponding forecast hour
FF1=FF0+6;
t1=t0-6/24;
%-------------------------------------------------------------------------
% define coeffients for ramping from cycle i-1 to cycle i
if FF0==0;coef=0.25;end
if FF0==1;coef=0.50;end
if FF0==2;coef=0.75;end
if FF0==3;coef=1.00;end
if FF0==4;coef=1.00;end
if FF0==5;coef=1.00;end
%-------------------------------------------------------------------------
% read hwrf from cycle i
for j=1:length(hwrf_grids)
 ncf    = ['hwrf.',num2str(YYYY),num2str(MM,'%02d'),num2str(DD,'%02d'),'_',num2str(HH0,'%02d'),'.f',num2str(FF0,'%02d'),'.',hwrf_grids{j},'.grib2.nc']
 if isfile(ncf)
   hwrf1.(sprintf(hwrf_grids{j})).time=convert_time(ncf,'time');
     for i=1:length(var)
         % check if variable exists
          ncid = netcdf.open(ncf,'nowrite');
          logic=1;
          try
             ID = netcdf.inqVarID(ncid,var{i});
              catch exception
              if strcmp(exception.identifier,'MATLAB:imagesci:netcdf:libraryFailure')
              logic = 0;
              end
          end
          netcdf.close(ncid)

          if logic==1
             hwrf1.(sprintf(hwrf_grids{j})).(sprintf(var{i}))=ncread(ncf,var{i});
          else
              if i==1
                  hwrf1.(sprintf(hwrf_grids{j})).(sprintf(var{i}))=nan*ones(nx,1);
              elseif i==2
                  hwrf1.(sprintf(hwrf_grids{j})).(sprintf(var{i}))=nan*ones(ny,1);
              else
             hwrf1.(sprintf(hwrf_grids{j})).(sprintf(var{i}))=nan*ones(nx,ny);
              end
             display([var{i},' does not exist'])
          end
     end
 else
     for i=1:length(var)
         if i==1
              hwrf1.(sprintf(hwrf_grids{j})).(sprintf(var{i}))=nan*ones(nx,1);
         elseif i==2
              hwrf1.(sprintf(hwrf_grids{j})).(sprintf(var{i}))=nan*ones(ny,1);
         else
         hwrf1.(sprintf(hwrf_grids{j})).(sprintf(var{i}))=nan*ones(nx,ny);
         end
     end
 display([ncf,' does not exist'])
 end
end
%-------------------------------------------------------------------------
%unify hwrf
for i=1:length(var)
    clear core;clear storm;clear synoptic;clear merged
    core=hwrf1.(sprintf(hwrf_grids{1})).(sprintf(var{i}));
    storm=hwrf1.(sprintf(hwrf_grids{2})).(sprintf(var{i}));
    synoptic=hwrf1.(sprintf(hwrf_grids{3})).(sprintf(var{i}));
    merged=core;
    merged(isnan(merged))=storm(isnan(merged));
    merged(isnan(merged))=synoptic(isnan(merged));
 hwrf1.(sprintf(var{i}))=merged;
end
%-------------------------------------------------------------------------
%-------------------------------------------------------------------------
% read hwrf from cycle i-1
for j=1:length(hwrf_grids)
 ncf    = ['hwrf.',datestr(t1,'yyyymmdd'),'_',datestr(t1,'HH'),'.f',num2str(FF1,'%02d'),'.',hwrf_grids{j},'.grib2.nc']
 if isfile(ncf)
   hwrf2.(sprintf(hwrf_grids{j})).time=convert_time(ncf,'time');
     for i=1:length(var)
         % check if variable exists
          ncid = netcdf.open(ncf,'nowrite');
          logic=1;
          try
             ID = netcdf.inqVarID(ncid,var{i});
              catch exception
              if strcmp(exception.identifier,'MATLAB:imagesci:netcdf:libraryFailure')
              logic = 0;
              end
          end
          netcdf.close(ncid)

          if logic==1
             hwrf2.(sprintf(hwrf_grids{j})).(sprintf(var{i}))=ncread(ncf,var{i});
          else
             hwrf2.(sprintf(hwrf_grids{j})).(sprintf(var{i}))=hwrf1.(sprintf(hwrf_grids{j})).(sprintf(var{i}));
             display([var{i},' does not exist'])
          end
     end
 else
     for i=1:length(var)
         hwrf2.(sprintf(hwrf_grids{j})).(sprintf(var{i}))=hwrf1.(sprintf(hwrf_grids{j})).(sprintf(var{i}));
     end
 display([ncf,' does not exist'])
 end
end
%-------------------------------------------------------------------------
%unify hwrf
for i=1:length(var)
    clear core;clear storm;clear synoptic;clear merged
    core=hwrf2.(sprintf(hwrf_grids{1})).(sprintf(var{i}));
    storm=hwrf2.(sprintf(hwrf_grids{2})).(sprintf(var{i}));
    synoptic=hwrf2.(sprintf(hwrf_grids{3})).(sprintf(var{i}));
    merged=core;
    merged(isnan(merged))=storm(isnan(merged));
    merged(isnan(merged))=synoptic(isnan(merged));
 hwrf2.(sprintf(var{i}))=merged;
end
%-------------------------------------------------------------------------
%smoothing
hwrf.time=datenum([YYYY,MM,DD,HH,0,00]);
hwrf.latitude=hwrf1.latitude;
hwrf.longitude=hwrf1.longitude;
for i=3:length(var)
 hwrf.(sprintf(var{i}))=(coef*hwrf1.(sprintf(var{i})))+((1-coef)*hwrf2.(sprintf(var{i})));
end
%-------------------------------------------------------------------------
%figure;pcolor(sqrt(hwrf1.UGRD_10maboveground.^2+hwrf1.VGRD_10maboveground.^2));shading interp;caxis([0 15]);
%figure;pcolor(sqrt(hwrf2.UGRD_10maboveground.^2+hwrf2.VGRD_10maboveground.^2));shading interp;caxis([0 15]);
%figure;pcolor(sqrt(hwrf1.UGRD_10maboveground.^2+hwrf1.VGRD_10maboveground.^2)-sqrt(hwrf2.UGRD_10maboveground.^2+hwrf2.VGRD_10maboveground.^2));shading interp;caxis([0 15]);
%figure;pcolor(hwrf.longitude,hwrf.latitude,flipud(rot90(sqrt(hwrf.UGRD_10maboveground.^2+hwrf.VGRD_10maboveground.^2))));shading interp;caxis([0 15]);
%title(['HWRF t = ',datestr(hwrf.time)])
end
