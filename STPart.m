%%%%%%%%%%%%%%%%% Calculate Spatial And Temporal Part %%%%%%%%%%%%%%%%%
function y = STPart(WSNS,RQ,H,chnum,Itr,Par)
Valid = true;
y=struct('spt',0,'tpr',0);
Dis = @(A,B) deg2km(distance(A.spt.p.Latitude,A.spt.p.Longitude,B.spt.p.Latitude,B.spt.p.Longitude))*1000;
tprR = @(A,B) numel(intersect(A.tpr(1):A.tpr(2),B.tpr(1):B.tpr(2)))/numel(B.tpr(1):B.tpr(2));
syms r1 r2 d2;
t = @(r,R,D) ((r+R).^2-D).*(D-(R-r).^2);
Area = @(r,R,D,t) r^2*acos((r^2-R^2+D)/(2*(sqrt(D))*r))+R^2*acos((R^2-r^2+D)/(2*(sqrt(D))*R))-1/2*sqrt(t);
sptR(r1,r2,d2)=piecewise( t(r1,r2,d2)>= 0,(Area(r1,r2,d2,t(r1,r2,d2))/(pi*r1^2)),(sqrt(d2)>(r1+r2)), 0,(sqrt(d2)<(r1+r2)), 1);

TprTemp=zeros(size(H.I{chnum},1),Par);
SptTemp=zeros(size(H.I{chnum},1),Par);

for i=1:size(H.I{chnum},1)
    temp = WSNS(H.I{chnum}(i),H.J{chnum}(Itr,i,:));
    %%% SPT Part %%%
    stemp = [temp(:).spt];
    stemp = vertcat(stemp(1:end).p);
    stemp = [stemp(:).Latitude; stemp(:).Longitude];
    DIS = deg2km(distance(stemp(1,:),stemp(2,:),RQ.spt.p.Latitude,RQ.spt.p.Longitude))*1000;
    DIS = DIS.^2;
    SptTemp(i,:) = double(sptR(WSNS(H.I{chnum}(i),H.J{chnum}(Itr,i,1)).spt.r,RQ.spt.r,DIS));
    %%% TPR Part %%%
    ttemp = [temp(:).tpr];
    ttemp = reshape(ttemp,2,Par);
    for t=1:size(ttemp,2)
      TprTemp(i,t)=  numel(intersect(ttemp(1,t):ttemp(2,t),RQ.tpr(1):RQ.tpr(2)))/numel(RQ.tpr(1):RQ.tpr(2));
    end
%     SptTemp(i,:)=STemp;
end
    
    spt=zeros(1,size(SptTemp,2));
    tpr=zeros(1,size(SptTemp,2));
    nzero = find(min([SptTemp(:,1:end)]));
    tnzero = find(min([TprTemp(:,1:end)]));
    nnz = intersect(tnzero,nzero);
    spt(nnz) = mean(SptTemp(:,nnz));
    tpr(nnz) = mean(TprTemp(:,nnz));
    zz = setdiff([1:size(SptTemp,2)],nnz);
    spt(zz) = mean(SptTemp(:,zz))/100;
    tpr(zz) = mean(TprTemp(:,zz))/100;
% for i=1:size(H.I{chnum},1)
% TprTemp(i) = tprR(WSNS(H.I{chnum}(i),H.J{chnum}(Itr,i,Par)),RQ);
% SptTemp(i) = double(sptR(WSNS(H.I{chnum}(i),H.J{chnum}(Itr,i,Par)).spt.r,RQ.spt.r,(Dis(WSNS(H.I{chnum}(i),H.J{chnum}(Itr,i,Par)),RQ))^2));
% if(TprTemp(i) == 0 || SptTemp(i) == 0)
% Valid =false;
% end
% end
% if(Valid == true)
% y.spt = mean(SptTemp);
% y.tpr = mean(TprTemp);
% else
%  y.spt =  mean(SptTemp)/100;%0;%
% y.tpr =  mean(TprTemp)/100;%0;%
% end
y.spt = spt;
y.tpr = tpr;
end