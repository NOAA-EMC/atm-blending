function [N_GLOBAL,ERR_GLOBAL,N_REGIONAL,ERR_REGIONAL] = satellite_wind_error(sat_netcdf,var_sat_lon,var_sat_lat,var_sat_time,var_sat_v,model_netcdf,var_model_lon,var_model_lat,var_model_time,var_model_u,var_model_v,lon_min,lon_max,lat_min,lat_max,plott)
%-------------------------------------------------------------------------
% This program compares the satellite observation (along track) and model %
% outouts (gridded).                                                      %
% Ali Abdolali (EMC/NCEP/NOAA ali.abdolali@noaa.gov                       %
%-------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%    INPUT    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%sat_netcdf: the name of netcdf file for observations
%var_sat_lon: the name of variable for longitude in observations [Q,1]
%var_sat_lat: the name of variable for latitude in observations [Q,1]
%var_sat_time: the name of variable for time in observations [Q,1]
%var_sat_v: the name of variable to be compared with the model in
%observations [Q,1]
%ww3_netcdf: the name of netcdf file for WW3 (gridded) 
%var_model_lon: the name of variable for longitude in WW3 [M,1]
%var_model_lat: the name of variable for latitude in WW3 [P,1]
%var_model_time: the name of variable for time in WW3 [M,1]
%var_model_u: the name of variable to be compared with the observations in
%model [P,M] (u component)
%var_model_v: the name of variable to be compared with the observations in
%model [P,M] (v component)
%[lon_min lon_max]: logitude minimum and maximum bounds for regional analysis
%[lat_min lat_max]: latitude minimum and maximum bounds for regional analysis
% PLOTT: plot the data if plott=1 
%%%%%%%%%%%%%%%%%%%    OUTPUT    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%N_GLOBAL: number of observations and model outputs for all data
%ERR_GLOBAL: Root mean square error (rmse) for all data
%N_REGIONAL: number of observations and model outputs for regional coverage
%ERR_REGIONAL: Root mean square error (rmse) for regional coverage
%%%%%%%%%%%%%%%%%%%%%%%% Dependency %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%convert_time: reads the unit from satellite/model and convert them to
% matlab time
%%%%%%%%%%%%%%%%%%%    example   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[N_GLOBAL,ERR_GLOBAL,N_REGIONAL,ERR_REGIONAL] = satellite_wind_error...
%('satellite.nc','lon','lat','time','wind_speed_alt','gfs.nc',...
%'longitude','latitude','time','UGRD_10maboveground',...
%'VGRD_10maboveground',40,60,10,50)
%-------------------------------------------------------------------------
%read satellie data
latsat=double(ncread(sat_netcdf,var_sat_lat));
lonsat=double(ncread(sat_netcdf,var_sat_lon));
lonsat(lonsat<0)=lonsat(lonsat<0)+360;
[timesat]=convert_time(sat_netcdf,var_sat_time);
vsat=double(ncread(sat_netcdf,var_sat_v));
vsat(vsat<0)=nan;
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
VMODEL_GLOBAL=interp3(Y,X,T,vmodel,latsat,lonsat,timesat);
%number of scatters
DIFF_GLOBAL=VMODEL_GLOBAL-vsat;
[in,jn]=find(~isnan(DIFF_GLOBAL));
lonsat1=lonsat(in);
latsat1=latsat(in);
N_GLOBAL=length(DIFF_GLOBAL(~isnan(DIFF_GLOBAL)));
%RMSE
%ERR_GLOBAL=rmse(VWW3_GLOBAL,vsat);
ERR_GLOBAL = sqrt(nanmean((VMODEL_GLOBAL-vsat).^2));  % Root Mean Squared Error
%-------------------------------------------------------------------------
%regional
[ii,jj]=find(lonsat>=lon_min & lonsat<=lon_max & latsat>=lat_min & latsat<=lat_max);
VMODEL_REGIONAL=VMODEL_GLOBAL(ii);
vsat2=vsat(ii);
lonsat2=lonsat(ii);
latsat2=latsat(ii);
%number of scatters
DIFF_REGIONAL=VMODEL_REGIONAL-vsat2;
N_REGIONAL=length(DIFF_REGIONAL(~isnan(DIFF_REGIONAL)));
%RMSE
%ERR_REGIONAL=rmse(VWW3_REGIONAL,vsat2);
ERR_REGIONAL = sqrt(nanmean((VMODEL_REGIONAL-vsat2).^2));  % Root Mean Squared Error
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
    scatter(lonsat1,latsat1,'.b');
    hold on
    scatter(lonsat2(~isnan(DIFF_REGIONAL)),latsat2(~isnan(DIFF_REGIONAL)),'r')
    hold on
    plot(long,lat,'k');
    hold on
    plot([lon_min lon_max lon_max lon_min lon_min],[lat_min lat_min lat_max lat_max lat_min],'m')
    box on
    axis on
    xlim([nanmin(lonmodel),nanmax(lonmodel)])
    ylim([nanmin(latmodel),nanmax(latmodel)])
    xlabel('Longitude','FontSize',12)
    ylabel('Latitude','FontSize',12)
    
    subplot(1,2,2)
    p1=scatter(vsat,VMODEL_GLOBAL,'xb');
    hold on;
    p2=scatter(vsat2,VMODEL_REGIONAL,'or');
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
    print('-dpng',[model_netcdf,'_satellite.png'])
   end
   %-------------------------------------------------------------------------
