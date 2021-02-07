%%%%%%%%%%%%%%%%% Initialize PSO Variables %%%%%%%%%%%%%%%%%
function y = PSO_Init(MaxItr,Scc,WSNS)
dist = 2*WSNS(1,1).spt.r;

CHN = zeros(1,(size(Scc,1)));
index = cell(1,size(Scc,1));
x = cell(1,size(Scc,1));
FitVal = cell(1,size(Scc,1));
v = cell(1,size(Scc,1));
Y = struct('Latitude',0.0,'Longitude',0.0);
D = struct('Latitude',0.0,'Longitude',0.0,'I',0,'J',0);
SCC = cell(1,size(Scc,1));
pbest = cell(1,size(Scc,1));

gbest = repmat(D,1,size(Scc,2));

%%%%%******* spt Calculation ******%%%%%
Dis = @(A,B) deg2km(distance(A.spt.p.Latitude,A.spt.p.Longitude,B.spt.p.Latitude,B.spt.p.Longitude))*1000;
% syms r1 r2 d2;
% t = @(r,R,D) ((r+R)^2-D)*(D-(R-r)^2);
% Area = @(r,R,D,t) r^2*acos((r^2-R^2+D)/(2*(sqrt(D))*r))+R^2*acos((R^2-r^2+D)/(2*(sqrt(D))*R))-1/2*sqrt(t);
% sptR(r1,r2,d2)=piecewise( t(r1,r2,d2)>= 0,(Area(r1,r2,d2,t(r1,r2,d2))/(pi*r1^2)),(sqrt(d2)>(r1+r2)), 0, 1);

for i=1:size(Scc,1)
    
    pbest{i} = repmat(D,1,numel(nonzeros(Scc(i,:))));
    CHN(i) = numel(nonzeros(Scc(i,:)));
    index{i} = zeros(MaxItr,CHN(i));
    FitVal{i} = ones(MaxItr,1);
    Y2 = repmat(Y,MaxItr,CHN(i));
    SCC{i} = nonzeros(Scc(i,:));
    x{i} = Y2;
    v{i} = Y2;
    temp =200;
%     tempspt=2*(WSNS(1,1).spt.r);
    candid=0;
    index{i}(1,1) = randi([1,size(WSNS,2)]);
%     v{i}(1,1).Latitude = rand();
%     v{i}(1,1).Longitude = rand();
    for k=2:CHN(i)
%         v{i}(1,k).Latitude = rand();
%         v{i}(1,k).Longitude = rand();
        while(temp > dist)
        candid = randi([1,size(WSNS,2)]);
%         index{i}(1,k)
        temp =Dis(WSNS(Scc(i,k-1),index{i}(1,k-1)),WSNS(Scc(i,k),candid));
        end
        index{i}(1,k) = candid;
        temp =200;
    end
%     for k=1:CHN(i)-1
%        tempspt = 0;% double(sptR(WSNS(Scc(i,k),index{i}(1,k)),WSNS(Scc(i,k+1),index{i}(1,k+1)),(Dis(WSNS(Scc(i,k),index{i}(1,k)),WSNS(Scc(i,k+1),index{i}(1,k+1))))^2));
%     end
%     while(tempspt>WSNS(1,1).spt.r)
%             index{i}(1,:) = randi([1,size(WSNS,2)],1,CHN(i));
%         for k=1:CHN(i)-1
%             [k             Dis(WSNS(Scc(i,k),index{i}(1,k)),WSNS(Scc(i,k+1),index{i}(1,k+1)))]
%         tempspt = (Dis(WSNS(Scc(i,k),index{i}(1,k)),WSNS(Scc(i,k+1),index{i}(1,k+1))));
%         if(tempspt> WSNS(Scc(i,k),index{i}(1,k)).spt.r)k=CHN(i);
%         end
%         end
%     end
% end
% for i=1:size(Scc,1)

    for j=1:CHN(i)

        x{i}(1,j).Latitude = WSNS(Scc(i,j),index{i}(1,j)).spt.p.Latitude;
        x{i}(1,j).Longitude = WSNS(Scc(i,j),index{i}(1,j)).spt.p.Longitude;
        
    end
end


y.Chn = CHN;
y.I = SCC;
y.J = index;
y.X = x;
y.V = v;
y.FitVal = FitVal;
y.Pbest = pbest;
y.Gbest = gbest;
end