function y = EngPart(WSNS,H,chnum,Itr,Par,bits,distance)
y = struct('Ecomp',0,'lbf',0);

Eelec = 50e-9;
Eamp = 100e-12;
Einv = 50e-9;
n = 2;

Etx = @(k,d) (Eelec * k)+(Eamp*k*(d.^n));
Erx = @(k) (Eelec * k);
Ecst =@(k,d) Einv + Etx(k,d) + Erx(k);
Eavg =@() mean([WSNS(:,:).eng]);
Ecom = @(k,d,chn) (chn-1) * (Etx(k,d) + Erx(k));
Ecomp = @(k,d,chn) Einv + Ecom(k,d,chn);
constraint = @(i,k,d) round([(WSNS(H.I{chnum}(i),H.J{chnum}(Itr,i,:)).eng)]-Ecst(k,d),7);
lbf = @(i,k,d) round([(WSNS(H.I{chnum}(i),H.J{chnum}(Itr,i,:)).eng)] -Ecst(k,d)./Eavg(),8);
temp=0;
Valid = ones(1,Par);
for t=1:size(H.I{chnum},1)
    cons = constraint(t,bits,distance);
    Icons = find(cons(cons<0));
    Valid(Icons)=0;
%    if(constraint(t,bits,distance)<0)
%       Valid = false;
%    end
      temp = round((temp + cons./Eavg()),7);
end
temp = temp/size(H.I{chnum},1);
y.Valid =  Valid;
y.Ecomp = repmat(Ecomp(bits,distance,size(H.I{chnum},1)),1,Par);
y.lbf = round(double(temp),5);
end