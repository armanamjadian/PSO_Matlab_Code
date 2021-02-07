function y = PSO_Ini(MaxItr,Scc,WSNS,Par)

dist = 2*WSNS(1,1).spt.r;

CHN = zeros(1,(size(Scc,1)));
J = cell(1,size(Scc,1));
X = cell(Par,size(Scc,1));
FitVal = cell(1,size(Scc,1));
V = cell(Par,size(Scc,1));
I = cell(1,size(Scc,1));
pbest = cell(1,size(Scc,1));
Y = struct('Latitude',0.0,'Longitude',0.0);
D = struct('Latitude',0.0,'Longitude',0.0,'I',0,'J',0);
gbest = cell(1,size(Scc,1));%repmat(D,1,size(Scc,2));
%%%%%******* spt Calculation ******%%%%%
Dis = @(A,B) deg2km(distance(A.spt.p.Latitude,A.spt.p.Longitude,B.spt.p.Latitude,B.spt.p.Longitude))*1000;

for i=1:size(Scc,1)
        pbest{i} = repmat(D,Par,numel(nonzeros(Scc(i,:))));
        gbest{i} = repmat(D,1,numel(nonzeros(Scc(i,:))));
        CHN(i) = numel(nonzeros(Scc(i,:)));
        J{i} = zeros(MaxItr,CHN(i),Par);
        FitVal{i} = ones(MaxItr,Par);
        Y2 = repmat(Y,MaxItr,CHN(i));
        I{i} = nonzeros(Scc(i,:));
%         X{i} = Y2;
%         V{i} = Y2;    
        temp2=1000;
        minmin=0;
        temp =200;
        candid=0;
     for j=1:Par
                 X{j,i} = Y2;
                 V{j,i} = Y2; 
            J{i}(1,1,j) = randi([1,size(WSNS,2)]);
            for k=2:CHN(i)
%         v{i}(1,k).Latitude = rand();
%         v{i}(1,k).Longitude = rand();
% candid = 1;

                while(temp > dist && candid < size(WSNS,2)-1)
%                  candid = randi([1,size(WSNS,2)]);
%                     candid = 1;
                    candid= candid+1;
                    if (candid==J{i}(1,k-1,j) && candid < size(WSNS,2))
                        candid= candid+1;
                    end
%         index{i}(1,k)
                 temp =Dis(WSNS(Scc(i,k-1),J{i}(1,k-1,j)),WSNS(Scc(i,k),candid));
                 if(temp<temp2)
                     minmin=candid;
                     temp2=temp;
                 end
                end
             J{i}(1,k,j) = minmin;
        temp2=1000;
        minmin=0;
        temp =200;
        candid=0;
            end
            
            for k=1:CHN(i)

             X{j,i}(1,k).Latitude = WSNS(Scc(i,k),J{i}(1,k,j)).spt.p.Latitude;
             X{j,i}(1,k).Longitude = WSNS(Scc(i,k),J{i}(1,k,j)).spt.p.Longitude;
        
            end
     end

     
end

y.Chn = CHN;
y.I = I;
y.J = J;
y.X = X;
y.V = V;
y.FitVal = FitVal;
y.Pbest = pbest;
y.Gbest = gbest;
end