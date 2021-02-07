function S = indeces(Scc,Index)

S = struct('I',0,'J',0);
S=repmat(S,size(nonzeros(Scc),1),1);
S(:)=S(1);
for i=1:size(nonzeros(Scc),1)
    S(i).I = Scc(i);
    S(i).J = Index(i);
end
end