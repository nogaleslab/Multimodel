function [nwcut,newCvol,newCcut]=eval_norm_cut_change(W,D,C,Cvol,Ccut,i,iCnext)
%W - graph weight matrix
%C - clusters


if(iCnext == C(i))
  'error iCnext == C(i)'
  return;
end

I=(1:size(C,1));
I=transpose(I);


newCvol=Cvol;

%update volumes
newCvol( C(i) )=Cvol( C(i) )-D(i);
newCvol( iCnext )=Cvol( iCnext)+D(i);

%update cuts

newCcut=Ccut;

%compute current cut between i and iCnext
Acomp=I(C==iCnext);

cutJoint=0;
for k=1:size(Acomp,1)
  cutJoint=cutJoint+W(i,Acomp(k));
end

newCcut( iCnext ) = Ccut( iCnext )-cutJoint;


%compute current cut between i and others
Acomp=I(C~=C(i));

cut=0;
for k=1:size(Acomp,1)
  cut=cut+W(i,Acomp(k));
end

newCcut( C(i) ) = Ccut( C(i) )-cut;


%compute new cut between C(i) and i
A=I(C==C(i));

newcut=0;
for k=1:size(A,1)
  if(i == A(k))
    continue
  end
  newcut=newcut+W(i,A(k));
end

newCcut( C(i) ) = newCcut( C(i) )+ newcut;
newCcut( iCnext ) = newCcut( iCnext )+ D(i)-W(i,i)-cutJoint;

%compute new score
nwcut=0;

numclust=size(unique(C),1);  %!!!

for k=1:size(Cvol,2)
  %compute volume
  vol=newCvol(k);

  %compute cut
  cut=newCcut(k);
  
  nwcut=nwcut+cut/vol;
  %nwcut=nwcut+cut/(vol-cut); %in all experiments produces equally
                             %size clusters
  %nwcut=nwcut+cut/size(A,1); %produced unbalanced clusters
end

