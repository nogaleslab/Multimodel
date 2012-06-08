function [D]=compute_D(W)

D=zeros(size(W,1),1);

for i=1:size(D,1)
  r=W(i,1:size(W,1));
  D(i)=sum(r);
end
