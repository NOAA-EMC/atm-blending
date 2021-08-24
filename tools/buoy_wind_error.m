function [N_GLOBAL,ERR_GLOBAL,N_REGIONAL,ERR_REGIONAL] = buoy_wind_error(buoy_netcdf,var_buoy_name,var_buoy_lon,var_buoy_lat,var_buoy_time,var_buoy_v,model_netcdf,var_model_lon,var_model_lat,var_model_time,var_model_u,var_model_v,lon_min,lon_max,lat_min,lat_max,plott)
%-------------------------------------------------------------------------
% This program compares the buoy observation (wind speed) and atm model   %
% outouts (gridded).                                                      %
% Ali Abdolali (EMC/NCEP/NOAA ali.abdolali@noaa.gov                       %
%-------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%    INPUT    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%buoy_netcdf: the name of netcdf file for buoy observations
%var_buoy_name: the name of buoy station (station)
%var_buoy_time: the name of variable for time in buoy observations [Q,1]
%var_buoy_lon: the name of variable for longitude in observations [Q,1]
%var_buoy_lat: the name of variable for latitude in observations [Q,1]
%var_buoy_v: the name of variable to be compared with the model in
%observations [Q,1]
%model_netcdf: the name of netcdf file for ATM model (gridded) 
%var_model_lon: the name of variable for longitude in WW3 [M,1]
%var_model_lat: the name of variable for latitude in WW3 [P,1]
%var_model_time: the name of variable for time in WW3 [M,1]
%var_model_u: the name of variable to be compared with the observations in
%model [P,M] (U component)
%var_model_v: the name of variable to be compared with the observations in
%model [P,M] (V component)
%[lon_min lon_max]: logitude minimum and maximum bounds for regional analysis
%[lat_min lat_max]: latitude minimum and maximum bounds for regional analysis
% PLOTT: plot the data if plott=1 
%%%%%%%%%%%%%%%%%%%    OUTPUT    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%N_GLOBAL: number of observations and model outputs for all data
%ERR_GLOBAL: Root mean square error (rmse) for all data
%N_REGIONAL: number of observations and model outputs for regional coverage
%ERR_REGIONAL: Root mean square error (rmse) for regional coverage
%%%%%%%%%%%%%%%%%%%%%%%% Dependency %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%convert_time: reads the unit from buoy/satellite/model and convert them to
% matlab time
%%%%%%%%%%%%%%%%%%%    example   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[N_GLOBAL,ERR_GLOBAL,N_REGIONAL,ERR_REGIONAL] = ...
% buoy_wind_error('NDBC_obs.nc','station_name','lon','lat','time',...
% 'wind_speed_alt','gfs.nc','longitude','latitude','time',...
% 'UGRD_10maboveground',VGRD_10maboveground',40,60,10,50)
%-------------------------------------------------------------------------
%read buoy data
latbuoy_tmp1=double(ncread(buoy_netcdf,var_buoy_lat));
lonbuoy_tmp1=double(ncread(buoy_netcdf,var_buoy_lon));
lonbuoy_tmp1(lonbuoy_tmp1<0)=lonbuoy_tmp1(lonbuoy_tmp1<0)+360;
buoy_name=cellstr(flipud(rot90(ncread(buoy_netcdf,var_buoy_name))));
[timebuoy_tmp1]=convert_time(buoy_netcdf,var_buoy_time);
lonbuoy_tmp2=lonbuoy_tmp1.*ones(length(lonbuoy_tmp1),length(timebuoy_tmp1));
latbuoy_tmp2=latbuoy_tmp1.*ones(length(latbuoy_tmp1),length(timebuoy_tmp1));
timebuoy_tmp2=flipud(rot90(timebuoy_tmp1.*ones(length(timebuoy_tmp1),length(latbuoy_tmp1))));
vbuoy_tmp1=double(ncread(buoy_netcdf,var_buoy_v));
lonbuoy=lonbuoy_tmp2(:);
latbuoy=latbuoy_tmp2(:);
timebuoy=timebuoy_tmp2(:);
vbuoy=vbuoy_tmp1(:);
%-------------------------------------------------------------------------
%read model data
latmodel=double(ncread(model_netcdf,var_model_lat));
lonmodel=double(ncread(model_netcdf,var_model_lon));
lonmodel(lonmodel<0)=lonmodel(lonmodel<0)+360;
[timemod]=convert_time(model_netcdf,var_model_time);
%duplicate variable 30 min before and 30 min after timemodel
timemodel=[timemod-1/24/2; timemod+1/24/2];
umod=double(ncread(model_netcdf,var_model_u));
umod_d(:,:,1)=umod;umod_d(:,:,2)=umod;
vmod=double(ncread(model_netcdf,var_model_v));
vmod_d(:,:,1)=vmod;vmod_d(:,:,2)=vmod;
vmodel=sqrt(umod_d.^2+vmod_d.^2);
%mesh grid the gridded model for interpolation
[Y,X,T]=meshgrid(latmodel,lonmodel,timemodel);
%-------------------------------------------------------------------------
%global
%interpolation
VMODEL_GLOBAL=interp3(Y,X,T,vmodel,latbuoy,lonbuoy,timebuoy);
%number of scatters
DIFF_GLOBAL=VMODEL_GLOBAL-vbuoy;
N_GLOBAL=length(DIFF_GLOBAL(~isnan(DIFF_GLOBAL)));
%RMSE
ERR_GLOBAL = sqrt(nanmean((VMODEL_GLOBAL-vbuoy).^2));  % Root Mean Squared Error
%-------------------------------------------------------------------------
%regional
[ii,jj]=find(lonbuoy>=lon_min & lonbuoy<=lon_max & latbuoy>=lat_min & latbuoy<=lat_max);
VMODEL_REGIONAL=VMODEL_GLOBAL(ii);
vbuoy2=vbuoy(ii);
%number of scatters
DIFF_REGIONAL=VMODEL_REGIONAL-vbuoy2;
N_REGIONAL=length(DIFF_REGIONAL(~isnan(DIFF_REGIONAL)));
%RMSE
ERR_REGIONAL = sqrt(nanmean((VMODEL_REGIONAL-vbuoy2).^2));  % Root Mean Squared Error
%-------------------------------------------------------------------------
%plotting fields
   if plott==1
   close all
    width=1200;  % Width of figure for movie [pixels]
    height=500;  % Height of figure of movie [pixels]
    left=200;     % Left margin between figure and screen edge [pixels]
    bottom=200;  % Bottom margin between figure and screen edge [pixels]
 %load coastline for continent boundaries
 load coast
 long(long<0)=long(long<0)+360;
 long(long<2)=nan;
    
    figure
    set(gcf,'Position', [left bottom width height])
    subplot(1,2,1)
    scatter(lonbuoy_tmp1,latbuoy_tmp1,'ob');
    hold on
    scatter(lonbuoy(ii),latbuoy(ii),'xr');
    hold on
    plot(long,lat','k');
    hold on
    plot([lon_min lon_max lon_max lon_min lon_min],[lat_min lat_min lat_max lat_max lat_min],'m')
    box on
    axis on
    xlim([nanmin(lonmodel),nanmax(lonmodel)])
    ylim([nanmin(latmodel),nanmax(latmodel)])
    xlabel('Longitude','FontSize',12)
    ylabel('Latitude','FontSize',12)
    
    subplot(1,2,2)
    p1=scatter(vbuoy,VMODEL_GLOBAL,'xb');
    hold on;
    p2=scatter(vbuoy2,VMODEL_REGIONAL,'or');
    hold on
    p3=plot([0 10],[0 10],'k')
    legend([p1,p2,p3],['global-master Blend N = ',num2str(N_GLOBAL),' RMSE = ',num2str(ERR_GLOBAL)],['Regional N = ',num2str(N_REGIONAL),' RMSE = ',num2str(ERR_REGIONAL)],'1:1')
    xlim([0 10])
    ylim([0 10])
    axis on
    box on
    grid on
    xlabel('obs','FontSize',12)
    ylabel('model','FontSize',12)
    print('-dpng',[model_netcdf,'_buoy.png'])
   end
   %-------------------------------------------------------------------------
