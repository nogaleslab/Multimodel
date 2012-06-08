function [OutC]=iter_spectral_clust(W,Iterations)
%W - graph weight matrix
%C - clusters

%iterative clustering
%3 clusters -> 2 iterations

OutC=transpose([1:size(W,1)]);
OutC(:)=0;



PrevMapping=[1:size(W,1)];

for clust=1:Iterations,

 %U=unormalized_SpectralClust(W,2);
 U=norm_Ng_Jordan_Weiss_02(W,2);
 %U=norm_Shi_Malik_00(W,2);

 x=U(1:size(U,1),1);
 y=U(1:size(U,1),2);

 C=(litekmeans(U',2))';

 if (Count(C,'==1') < Count(C,'==2'))
  smallest=1;
 else
  smallest=2;
 end

 NewIndices=[];
 Mapping=[];

 for i=1:size(C),
  if(C(i)==smallest)
   OutC( PrevMapping(i) )=clust;
  else
   if(clust== Iterations)
    OutC( PrevMapping(i) )=clust+1;
   end
   NewIndices=[NewIndices,i];
   Mapping=[Mapping, PrevMapping(i)];
  end
 end

 %NewIndices
 %Mapping
 W=W(NewIndices,NewIndices);

 PrevMapping=Mapping;
end


%for i=1:size(BW,1)*size(BW,2)
%  if(BW(i)==1)

