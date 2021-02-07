%%%%%%%%%%%%%%%%% Create Request Structure %%%%%%%%%%%%%%%%%
function y = Request(point1,point2,Radius)
y = struct('spt',struct('p',geopoint(random('Uniform',point1.Latitude,point2.Latitude), random('Uniform',point1.Longitude,point2.Longitude)),'r',Radius),'tpr',[((randi(13)-1)*2),((randi(13)-1)*2)]);
if(y.tpr(1)>16)
    y.tpr=[y.tpr(1)-8 y.tpr(1)];
else
    y.tpr=[y.tpr(1) y.tpr(1)+8];
end
end