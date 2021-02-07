%%%%%%%%%%%%%%%%% Update PSO Variables %%%%%%%%%%%%%%%%%
function y=PSO_Alg(WSNS,H,Itr,Par,CHNUM)
%     max_itr = 50;
    w = 0.5;
    c1 =2;
    c2=2;
    Vtplus = @(i,t,d) (w * ([H.V{Par,i}(t,d).Latitude;H.V{Par,i}(t,d).Longitude]) ) + (c1 * ((randi([1 10]))/10)* ([H.Pbest{i}(Par,d).Latitude;H.Pbest{i}(Par,d).Longitude]-[H.X{Par,i}(t,d).Latitude;H.X{Par,i}(t,d).Longitude])) + (c2 * ((randi([1 10]))/10)* ([H.Gbest{i}(d).Latitude;H.Gbest{i}(d).Longitude]-[H.X{Par,i}(t,d).Latitude;H.X{Par,i}(t,d).Longitude]));
    VtplusG0 = @(i,t,d) (w * ([H.V{Par,i}(t,d).Latitude;H.V{Par,i}(t,d).Longitude]) ) + (c1 *((randi([1 10]))/10)* ([H.Pbest{i}(Par,d).Latitude;H.Pbest{i}(Par,d).Longitude]-[H.X{Par,i}(t,d).Latitude;H.X{Par,i}(t,d).Longitude])) ;
%     Vtplus = @(i,t,d) (w * ([H.V{Par,i}(t,d).Latitude;H.V{Par,i}(t,d).Longitude]) ) + (c1 * ([H.Pbest{i}(Par,d).Latitude;H.Pbest{i}(Par,d).Longitude]-[H.X{Par,i}(t,d).Latitude;H.X{Par,i}(t,d).Longitude])) + (c2 * ([H.Gbest{i}(d).Latitude;H.Gbest{i}(d).Longitude]-[H.X{Par,i}(t,d).Latitude;H.X{Par,i}(t,d).Longitude]));
%     VtplusG0 = @(i,t,d) (w * ([H.V{Par,i}(t,d).Latitude;H.V{Par,i}(t,d).Longitude]) ) + (c1 * ([H.Pbest{i}(Par,d).Latitude;H.Pbest{i}(Par,d).Longitude]-[H.X{Par,i}(t,d).Latitude;H.X{Par,i}(t,d).Longitude])) ;

    Dis = @(A,B) deg2km(distance(A.Latitude,A.Longitude,B.Latitude,B.Longitude))*1000;

% [H.V{Par,i}(t,d).Latitude;H.V{Par,i}(t,d).Longitude]
% abs([H.Pbest{i}(Par,d).Latitude;H.Pbest{i}(Par,d).Longitude]-[H.X{i}(t,d).Latitude;H.X{i}(t,d).Longitude])
% abs([H.Gbest{i}(d).Latitude;H.Gbest{i}(d).Longitude]-[H.X{i}(t,d).Latitude;H.X{i}(t,d).Longitude])
%     Vtplus = @(i,t,d) (w *[(H.V{Par,i}(t,d).Latitude);(H.V{Par,i}(t,d).Longitude)])+ (c1 * rand() * (abs(double([(H.Pbest{i}(Par,d).Latitude);(H.Pbest{i}(Par,d).Longitude)]) - double([(H.X{i}(d,t).Latitude); (H.X{i}(d,t).Longitude)])))) + (c2 * rand() * abs(double([H.Gbest{i}(d).Latitude;H.Gbest{i}(d).Longitude]) - double([(H.X{i}(d,:,t).Latitude) ; (H.X{i}(d,:,t).Longitude)])));
% for i=1:size(H.X,2)
% if(CHN >= 1)
%     CHNUM = CHN-1;
% else
%         CHNUM = CHN;
% end
    for j=1:size(H.X{Par,CHNUM},2)
        if(H.Gbest{CHNUM}(j).Latitude == 0 && H.Gbest{CHNUM}(j).Longitude == 0)
        HVP = VtplusG0(CHNUM,(Itr-1),j);
        else
        HVP = Vtplus(CHNUM,(Itr-1),j);
        end
%         HVP =HVP/1000;
    H.V{Par,CHNUM}(Itr,j).Latitude = HVP(1);
    H.V{Par,CHNUM}(Itr,j).Longitude = HVP(2);
    H.X{Par,CHNUM}(Itr,j).Latitude = mod(((H.X{Par,CHNUM}(Itr-1,j).Latitude + HVP(1))-25),0.0036036)+25;
    H.X{Par,CHNUM}(Itr,j).Longitude =mod(((H.X{Par,CHNUM}(Itr-1,j).Longitude + HVP(2))-35),0.00397)+35;
%         if((H.X{i}(Itr,j).Latitude + HVP(1))>25.0036036)
%             H.X{i}(Itr,j).Latitude = 25.0036036;
%     else
%     H.X{i}(Itr,j).Latitude = (H.X{i}(Itr,j).Latitude + HVP(1));
%     end
%     if(((H.X{i}(Itr,j).Longitude + HVP(2))>35.00397))
%         H.X{i}(Itr,j).Longitude =35.00397;
%     else
%     H.X{i}(Itr,j).Longitude = (H.X{i}(Itr,j).Longitude + HVP(2));
%     end
%     Xtplus = @(i,t,d) H.X{i}(d,:,t) + Vtplus(i,t,d);
    Imin = 1;       
    Dmin = Dis(WSNS(H.I{CHNUM}(j),1).spt.p,H.X{Par,CHNUM}(Itr,j));
        for k=2:size(WSNS,2)
            dis = Dis(WSNS(H.I{CHNUM}(j),k).spt.p,H.X{Par,CHNUM}(Itr,j));
            if(dis<Dmin)% && k~=H.J{i}(Itr-1,j))
            Dmin = dis;
            Imin = k;
            end
        end
    H.J{CHNUM}(Itr,j,Par)=Imin;
    H.X{Par,CHNUM}(Itr,j).Latitude=WSNS(H.I{CHNUM}(j),Imin).spt.p.Latitude;
    H.X{Par,CHNUM}(Itr,j).Longitude=WSNS(H.I{CHNUM}(j),Imin).spt.p.Longitude;
    end
%             H.V{Par,i}(Itr,:).Latitude
%                 H.V{Par,i}(Itr,:).Longitude
%     [H.X{i}(Itr,1).Latitude:H.X{i}(Itr,end).Latitude]
%         [H.X{i}(Itr,1).Longitude:H.X{i}(Itr,end).Longitude]
% end
y=H;
end