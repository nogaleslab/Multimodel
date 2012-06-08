function [U]=norm_Ng_Jordan_Weiss_02(W,NumClusters)

D=zeros(size(W,1),size(W,1));

for i=1:size(D,1)
  r=W(i,1:size(W,1));
  D(i,i)=sum(r);
end


L=D-W; %un-normalized laplasian matrix
L=D^(-0.5)*L*D^(-0.5); %normalized (Ng-Jordan-Weiss 2002)

%compute eigenvectors/eigenvalues
[Evectors,Evalues]=eig(L);


%find largest/smallest eigenvalues
EvaluesD=diag(Evalues);

U=zeros(size(W,1),NumClusters);
for i=1:NumClusters
  [minv,mini]=min(EvaluesD);
  minv
 
  EvaluesD(mini)=99999; 
 
  U(:,i)=Evectors(:,mini);
end


%normalize for L=D^(-0.5)*L*D^(-0.5)
for i=1:size(U,1)
 U(i,:)=U(i,:)/norm(U(i,:));   
end
