%%%%%%%%%%%%%%%%% Compute Fitness Function %%%%%%%%%%%%%%%%%
function FitVal = FitFunc(EngPart,STPart)

Wmin = 0.5;
Wmax = 0.5;
phi = 0.6;
gamma = 0.2;
beta = 0.2;
FitVal = ones(1,size(EngPart.Valid,2));
% FitVal(:) = 100;
FitVal = (Wmin.*EngPart.Ecomp) - (Wmax.*( (phi.*EngPart.lbf) + (beta.*STPart.spt) + (gamma.*STPart.tpr)));
    IV = find(EngPart.Valid(EngPart.Valid<1));
    FitVal(IV) = 100;
    FitVal = round(double(FitVal),6);
%     if(EngPart.Valid == false)
%         FitVal = 100;
%     else
%         FitVal = (Wmin.*EngPart.Ecomp) - (Wmax.*( (phi.*EngPart.lbf) + (beta.*STPart.spt) + (gamma.*STPart.tpr)));
%     end
end