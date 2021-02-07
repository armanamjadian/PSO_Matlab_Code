%%%%%%%%%%%%%%%%% Create WSNS Structure %%%%%%%%%%%%%%%%%
function y = Structure(sensors,Eng,p1,p2,Radius)
y = struct('nm','name','dsc','description','op',struct('nm','name','Inp','InputOp','Outp','OutputOp'),'eng',randi([1 5])/10,'spt',struct('p',geopoint(0, 0),'r',Radius),'tpr',[((randi(13,sensors,14)-1)*2), ((randi(13,sensors,14)-1)*2)]);
% y = struct('nm','name','dsc','description','op',struct('nm','name','Inp','InputOp','Outp','OutputOp'),'eng',Eng,'spt',struct('p',geopoint(0, 0),'r',Radius),'tpr',[((randi(13,sensors,14)-1)*2), ((randi(13,sensors,14)-1)*2)]);
S = struct('nm','name','dsc','description','op',struct('nm','name','Inp','InputPar','Outp','OutputPar'));
S=repmat(S,1,14);
timeRange = 8;
% for i=1:14
%     S(i) = S(1);
% end
S(:)=S(1);

S(1).nm = 'Ambient temperature sensing service';
S(1).dsc = 'Measures the ambient room temperature in degrees Celsius (C). Common use is for monitoring air temperatures.';
S(2).nm = 'Temperature sensing service';
S(2).dsc = 'Measures the temperature of the device in degrees Celsius (C).This sensor implementation varies across devices. Common use is for monitoring temperatures.';
S(3).nm = 'Relative humidity sensing service';
S(3).dsc = 'Measures the relative ambient humidity in percent (%). Common use is for monitoring dewpoint, absolute, and relative humidity.';
S(4).nm = 'Light sensing service';
S(4).dsc = 'Measures the ambient light level (illumination) in lx. Common use is for controlling a light, and adjusting its brightness.';
S(5).nm = 'Pressure sensing service';
S(5).dsc = 'Measures the ambient air pressure in hPa or mbar. Common use is for monitoring air pressure changes.';
S(6).nm = 'Gravity sensing service';
S(6).dsc = 'Measures the force of gravity in m/s2 that is applied to a device on all three physical axes (x, y and z). Common use is for motion detection (vibration, wobble, etc.).';
S(7).nm = 'Magnetic field sensing service';
S(7).dsc = 'Measures the ambient geomagnetic field for all three physical axes (x, y, z) in µT. Common use is for creating a compass.';
S(8).nm = 'Proximity sensing service';
S(8).dsc = 'Measures the proximity of an object relative to the view screen of a device. This sensor is typically used to determine whether a person is enough closely near the device.';
S(9).nm = 'Ambient smog sensing service';
S(9).dsc = 'Measures the ambient room smog in degrees mg/L. Common use is for monitoring air smog, and ?re alarm.';
S(10).nm = 'Wind direction sensing service';
S(10).dsc = 'Measures the wind direction. Common use is for monitoring the wind direction when there are something spread along the wind.';
S(11).nm = 'Wind power sensing service';
S(11).dsc = 'Measures the wind power. Common use is for monitoring the wind power in a weather application.';
S(12).nm = 'Accelerometer sensing service';
S(12).dsc = 'Measures the acceleration force in m/s2 that is applied to a device on all three physical axes (x, y, and z), including the force of gravity.';
S(13).nm = 'Rotation vector sensing service';
S(13).dsc = 'Measures the orientation of a device by providing the three elements of the device’s rotation vector.';
S(14).nm = 'Gyroscope sensing service';
S(14).dsc = 'Measures a device’s rate of rotation in rad/s around each of the three physical axes (x, y, and z).';
time1 = (randi(13,sensors,14)-1)*2;
% time2 = (randi(13,30,14)-1)*2;
% point = WSNS.spt.p;
% point.lat = repmat(point.lat,30,1);
% point.lon = repmat(point.lon,30,1);
y=repmat(y,14,30);
% point = struct('lat',zeros(sensors,1),'lon',zeros(sensors,1));
% point = repmat(point,14,1);
for i=1:14
    for j=1:sensors
%     WSNS(i,j)=WSNs;
    y(i,j).nm=S(i).nm;
    y(i,j).dsc = S(i).dsc;
%     WSNS(i,j).spt.p = geopoint(random('Uniform',25,45), random('Uniform',35,55));
%0.00533-0.005333
    y(i,j).spt.p = geopoint(random('Uniform',p1.Latitude,p2.Latitude), random('Uniform',p1.Longitude,p2.Longitude));
    if(time1(j,i)>16)
        y(i,j).tpr = [time1(j,i)-timeRange,time1(j,i)];
    else 
        y(i,j).tpr = [time1(j,i),time1(j,i)+timeRange];
    end
%     if((time2(j,i)==time1(j,i)) && time1(j,i) >= 4) WSNS(i,j).tpr ;= [time2(j,i)-4,time1(j,i)];end
%     if((time2(j,i)==time1(j,i)) && time1(j,i) < 4) WSNS(i,j).tpr = [time2(j,i),time1(j,i)+4];end
%     points(((i-1)*sensors)+j)= y(i,j).spt.p;
%     point(i).lat(j)= y(i,j).spt.p.Latitude;
%     point(i).lon(j) = y(i, j).spt.p.Longitude;

%     points(i,j)=WSNS(i,j).spt.p;
    end
    
end
% return y;
end