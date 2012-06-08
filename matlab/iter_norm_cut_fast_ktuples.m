function [iterC]=iter_norm_cut_fast_ktuples(W,C,iterations)
%W - graph weight matrix
%C - clusters

for j=1:size(W,1)
  for k=1:size(W,1)
    if(W(j,k) ~= W(k,j))
      'error'
      W(j,k)
      W(k,j)
      
      %return;
    end
  end
end
      
   

numclust=size(unique(C),1);

D=compute_D(W);
iterNwcut=eval_norm_cut(W,D,C);
iterC=C;

for iter=1:iterations
  iter
  counter=0;
 
  iterNwcut
  %make a change
  for i=1:numclust:size(C,1)
    
    
    %test if all indices are unique in iterC(i:i+numclust-1)
    %ktuple=1:numclust;
    ktuple=iterC(i:i+numclust-1);
    sizetest=size(unique(ktuple),1);
    
    if(sizetest ~= numclust)
      'error: ktuple is not in diff clusters.'
      sizetest
      continue;
    end
      

    mper=perms([1:numclust]);

    minindex=-1;
    min=iterNwcut;

    for j=1:size(mper,1)
      tmp_C=iterC;
            
      tmp_C(i:i+numclust-1)=transpose(mper(j,:));
      newNwcut=eval_norm_cut(W,D,tmp_C);
      
      if(newNwcut<min)
	minindex=j;
	min=newNwcut;
      end
    end
    
    if(minindex ~= -1)
      iterC(i:i+numclust-1)=transpose(mper(minindex,:));
      iterNwcut=min;
      counter=counter+1;
    end
  end
  counter
  
  if (counter == 0)
    break;
  end
end

iterNwcut
