excel_file = 'march172023fieldday.xlsx';
data = xlsread(excel_file, 'G:H');
disp(data);
plot(data,'.','MarkerSize',10); 

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
