function [nwcut]=eval_norm_cut(W,D,C)
%W - graph weight matrix
%D - total vertex weights
%C - clusters

nwcut=0;

numclust=size(unique(C),1);

I=(1:size(C,1));
I=transpose(I);

for i=1:numclust
  A=I(C==i);
  Acomp=I(C~=i);
  
  %compute volume
  vol=0;
  for j=1:size(A,1)
    vol=vol+D(A(j));
  end
  %vol
  
  %compute cut
  cut=0;
  for j=1:size(A,1)
    for k=1:size(Acomp,1)
      cut=cut+W(A(j),Acomp(k));
    end
  end
  
  nwcut=nwcut+cut/vol;
  %nwcut=nwcut+cut/(vol-cut); %in all experiments produces equally
                             %size clusters
  %nwcut=nwcut+cut/size(A,1); %produced unbalanced clusters
end
