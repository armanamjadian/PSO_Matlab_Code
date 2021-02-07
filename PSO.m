clc, clear, close all;
SP = geopoint(24.9998,34.9997);
EP = geopoint(25.0039,35.004);
p1 = geopoint(25,35);
p2 = geopoint(25.0036036,35.00397);
WSNS = Structure(30,0.5,p1,p2,50);
rq = Request(p1,p2,110);
bits = 50;
distance = 50;
scc = [4 1 3 6 10; 4 6 3 1 10;4 7 3 1 10; 4 7 3 10 0; 4 9 10 0 0];

%%%%%%%%%******** PSO Algorithm ********%%%%%%%%
max_itr = 50;
Particle = 20;
H = PSO_Ini(max_itr,scc,WSNS,Particle);
% inde = randi([1,30],max(chn));
% lbfComp =0;
FitInd = struct('CHNum',0,'Itr',0,'Par',0);
% TempZero = struct('Latitude',0.0,'Longitude',0.0,'I',0,'J',0);
% for i=1:size(H.I,2)
% TempZ{i}=repmat(TempZero,1,size(size(H.I,2),2));
% end
TempZ = H.Gbest ;
FitPb = ones(Particle,size(H.I,2));
FitPb(:) = 10;

FitGb = ones(1,size(H.I,2));
FitGb(:) = 10;
Ind = zeros(1,size(H.I,2));
Val = ones(1,size(H.I,2));
for i=1:max_itr
    for j=1:size(H.I,2)%Chain Number
                ST = STPart(WSNS,rq,H,j,i,Particle);
                ENG = EngPart(WSNS,H,j,i,Particle,bits,distance);
                H.FitVal{j}(i,:) = FitFunc(ENG,ST)*(1+((H.Chn(j)/max(H.Chn(:)))/10));
        for p = 1:Particle
        
        
        if(H.FitVal{j}(i,p)<FitPb(p,j))
            FitPb(p,j) = H.FitVal{j}(i,p);
            for k=1:size(H.I{j},1)
                H.Pbest{j}(p,k).Latitude = H.X{p,j}(i,k).Latitude;
                H.Pbest{j}(p,k).Longitude = H.X{p,j}(i,k).Longitude;
                H.Pbest{j}(p,k).I = H.I{j}(k);
                H.Pbest{j}(p,k).J = H.J{j}(i,k,p);
            end
        end
        if(H.FitVal{j}(i,p)<FitGb(j))
            FitGb(j) = H.FitVal{j}(i,p);
            if(FitGb(j)==min(FitGb(:)))
            FitInd.CHNum = j;
            FitInd.Itr = i;
            FitInd.Par = p;
            end
%             H.Gbest = TempZ;
            for k=1:size(H.I{j},1)
                H.Gbest{j}(k).Latitude = H.X{p,j}(i,k).Latitude;
                H.Gbest{j}(k).Longitude = H.X{p,j}(i,k).Longitude;
                H.Gbest{j}(k).I = H.I{j}(k);
                H.Gbest{j}(k).J = H.J{j}(i,k,p);
            end
        end
        if(i<max_itr)
%             j
            H = PSO_Alg(WSNS,H,i+1,p,j);
        end
        end
        [Valm(j),Indm(j)]=max(H.FitVal{j}(i,:));
        H = RandSelect(WSNS,H,scc,i+1,Indm(j),j);
    end
    for m = 1:size(H.I,2)
        [Val(m),Ind(m)]=min(H.FitVal{m}(i,:));
    end
%     [Valm;Indm]
    [Val;Ind]
    PSO_Plot(SP,EP,WSNS,rq,H,i,Ind);
end
FitInd
figure
PSO_Plot(SP,EP,WSNS,rq,H,FitInd.Itr,FitInd.Par,FitInd.CHNum);
% MFV = zeros(1,size(H.I,2));
% MFI = zeros(2,size(H.I,2));
% for i=1:size(H.I,2)
%     [MFV(i),MFI(:,i)] = min(min(H.FitVal{i}));
% end
% [FF,FI] = min(MFV);
% FF
% Chain =FI
% [Par,ITR] = MFI(:,FI)
% PSO_Plot(SP,EP,WSNS,rq,ITR,Chain);