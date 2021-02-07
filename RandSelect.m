function y=RandSelect(WSNS,H,Scc,Itr,Par,CHNum)
dist = 2*WSNS(1,1).spt.r;

Dis = @(A,B) deg2km(distance(A.spt.p.Latitude,A.spt.p.Longitude,B.spt.p.Latitude,B.spt.p.Longitude))*1000;

        temp2=1000;
        minmin=0;
        temp =200;
        candid=0;

            H.J{CHNum}(Itr,1,Par) = randi([1,size(WSNS,2)]);
            for k=2:H.Chn(CHNum)
%         v{i}(1,k).Latitude = rand();
%         v{i}(1,k).Longitude = rand();
% candid = 1;

                while(temp > dist && candid < size(WSNS,2)-1)
%                  candid = randi([1,size(WSNS,2)]);
%                     candid = 1;
                    candid= candid+1;
                    if (candid==H.J{CHNum}(Itr,k-1,Par) && candid < size(WSNS,2))
                        candid= candid+1;
                    end
%         index{i}(1,k)
                 temp =Dis(WSNS(Scc(CHNum,k-1),H.J{CHNum}(Itr,k-1,Par)),WSNS(Scc(CHNum,k),candid));
                 if(temp<temp2)
                     minmin=candid;
                     temp2=temp;
                 end
                end
             H.J{CHNum}(Itr,k,Par) = minmin;
             candid = 0;
             end
y = H;
end