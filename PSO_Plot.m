%%%%%%%%%%%%%%%%% Plot Points %%%%%%%%%%%%%%%%%
function PSO_Plot(StartPoint,EndPoint,WSNS,Rq,H,Itr,Par,CHNum)
worldmap([StartPoint.Latitude EndPoint.Latitude],[StartPoint.Longitude EndPoint.Longitude]);
WSNSP = [WSNS.spt];
points = vertcat(WSNSP(:).p);

% plotm(34,46)
% % geoshow(point,'DisplayType', 'point');

geoshow(points.Latitude,points.Longitude, 'DisplayType','point','Marker','.','MarkerEdgeColor','red')
% geoshow(point(1).lat,point(1).lon, 'DisplayType','point','Marker','.','MarkerEdgeColor','black')
% scatterm(points.Longitude,points.Latitude,5,'r','filled')

%b=randi(420);
[lattemp, lontemp] = scircle1(Rq.spt.p.Latitude,Rq.spt.p.Longitude, km2deg((Rq.spt.r)/1000));
scatterm(Rq.spt.p.Latitude,Rq.spt.p.Longitude,10,'g','filled');
plotm(lattemp,lontemp,'p');
color = ['r' 'g' 'b' 'k' 'y'];
%  scatterm(rq.spt.p.Latitude,rq.spt.p.Longitude,ratio*6000,'b')
if((nargin==7))
for i=1:size(H.I,2)
    for j= 1:size(H.I{i},1)
scatterm(WSNS(H.I{i}(j),H.J{i}(Itr,j,Par(i))).spt.p.Latitude,WSNS(H.I{i}(j),H.J{i}(Itr,j,Par(i))).spt.p.Longitude,5,color(i),'filled');
[lattemp, lontemp] = scircle1(WSNS(H.I{i}(j),H.J{i}(Itr,j,Par(i))).spt.p.Latitude,WSNS(H.I{i}(j),H.J{i}(Itr,j,Par(i))).spt.p.Longitude,km2deg((WSNS(H.I{i}(j),H.J{i}(Itr,j,Par(i))).spt.r)/1000));
plotm(lattemp,lontemp,color(i));
    end
end
else
    i= CHNum;
    for j= 1:size(H.I{i},1)
scatterm(WSNS(H.I{i}(j),H.J{i}(Itr,j,Par)).spt.p.Latitude,WSNS(H.I{i}(j),H.J{i}(Itr,j,Par)).spt.p.Longitude,5,color(i),'filled');
[lattemp, lontemp] = scircle1(WSNS(H.I{i}(j),H.J{i}(Itr,j,Par)).spt.p.Latitude,WSNS(H.I{i}(j),H.J{i}(Itr,j,Par)).spt.p.Longitude,km2deg((WSNS(H.I{i}(j),H.J{i}(Itr,j,Par)).spt.r)/1000));
plotm(lattemp,lontemp,color(i));
    end

end
title(strcat('Itration ' ,num2str(Itr)));
end