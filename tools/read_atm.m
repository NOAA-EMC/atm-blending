function [atm]=read_atm(atm_model,YYYY,MM,DD,HH,var,nx,ny)
%read GFS and HRRR and RAP
%-------------------------------------------------------------------------
 ncf    = [atm_model,'.',num2str(YYYY),num2str(MM,'%02d'),num2str(DD,'%02d'),'_',num2str(HH,'%02d'),'.f00.grib2.nc']
 if isfile(ncf)
   atm.time=convert_time(ncf,'time');
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
             atm.(sprintf(var{i}))=ncread(ncf,var{i});
          else 
             atm.(sprintf(var{i}))=nan*ones(nx,ny);
             display([var{i},' does not exist'])
          end
     end
 else
 display([ncf,' does not exist'])
 end
end
%figure;pcolor(atm.longitude,atm.latitude,flipud(rot90(sqrt(atm.UGRD_10maboveground.^2+atm.VGRD_10maboveground.^2))));shading interp;caxis([0 15]);
%title([atm_model,' t = ',datestr(atm.time)])

