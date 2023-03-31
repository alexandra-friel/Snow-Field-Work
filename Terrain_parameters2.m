%% 


excel_file = '2023-03-17_StackRock_LDP_GNSS_Rover5.xlsx';
data = xlsread(excel_file, 'G:H');
disp(data);
plot(data,'.','MarkerSize',10); 

%% SLOPE 

% read in slope raster file
[slope, slope_R] = readgeoraster('DryCreekBase1m_WGS84UTM11-slope.tif');
% grab X and Y coordinate
slope_X = slope_R.XWorldLimits(1):(slope_R.XWorldLimits(2)-slope_R.XWorldLimits(1))/(length(slope(1,:))-1):slope_R.XWorldLimits(2);
slope_Y = slope_R.YWorldLimits(1):(slope_R.YWorldLimits(2)-slope_R.YWorldLimits(1))/(length(slope(:,1))-1):slope_R.YWorldLimits(2);

% reproject data points to UTM
p = slope_R.ProjectedCRS; % grab projection from slope reference info
[data_X, data_Y] = projfwd(p, data(:,2), data(:,1));

% plot to make sure it worked
figure(1); clf;
xlabel('Easting [m]');
ylabel('Northing [m]');
imagesc(slope_X, slope_Y, slope); hold on;
plot(data_X, data_Y, '.m','MarkerSize',20);
% interpolate slope at data points
data_slope = interp2(slope_X, slope_Y, slope, data_X, data_Y);

 %% ASPECT
[aspect, aspect_R] = readgeoraster('DryCreekBase1m_WGS84UTM11-aspect.tif');
aspect_X = aspectR.XWorldLimits(1):(aspect_R.XworldLimits(2)-aspectR.XWorldLimits(1))/length(aspect(1,:))-1:aspect_R.XworldLimits(2);
aspect_Y = aspectR.YWorldLimits(1):(aspect_R.YworldLimits(2)-aspectR.YWorldLimits(1))/length(aspect(1,:))-1:aspect_R.YworldLimits(2);


%% ELEVATION

[DEM, DEM_R] = readgeoraster('DryCreekBase1m_WGS84UTM11_DEM.tif');
DEM_X = aspectR.XWorldLimits(1):(DEM_R.XworldLimits(2)-DEMR.XWorldLimits(1))/length(DEM(1,:))-1:DEM_R.XworldLimits(2);
DEM_Y = aspectR.YWorldLimits(1):(DEM_R.YworldLimits(2)-DEMR.YWorldLimits(1))/length(DEM(1,:))-1:DEM_R.YworldLimits(2);



