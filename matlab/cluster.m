function cluster(fmatrix, nclust)
W = dlmread(fmatrix);

W=W+abs(min(min(W)));

for j=1:size(W,1)
  W(j,j)=0;
  for k=(j+1):size(W,1)
    W(j,k) = (W(j,k) + W(k,j))/2;
    W(k,j) = W(j,k);            
  end
end

clust = nclust - 1;

C=iter_spectral_clust(W,clust);
iterC=iter_norm_cut_fast(W,C,20);
iterC2=iter_norm_cut_fast_ktuples(W,iterC,20);
C=iterC2;

I=transpose(1:size(W,1));

for i=1:nclust
	out = I(C(:) == i);
	fout = strcat(fmatrix,'_cluster_',int2str(i),'.plt');
	dlmwrite(fout,out);
end
	


