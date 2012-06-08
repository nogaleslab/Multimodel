function [iterC]=iter_norm_cut_fast(W,C,iterations)
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
      
   

[iterNwcut,D,iterCvol,iterCcut]=init_norm_cut(W,C);

numclust=size(unique(C),1);

%iterNwcut=eval_norm_cut(W,D,C);
iterC=C;

for iter=1:iterations
  iter
  counter=0;
 
  iterNwcut
  %make a change
  for i=1:size(C,1)
    for c=1:numclust
      if(iterC(i)==c)
	continue;
      end
      
      
      [newNwcut,newCvol,newCcut]=eval_norm_cut_change(W,D,iterC,iterCvol,iterCcut,i,c);

      
      if(newNwcut<iterNwcut)
	iterC(i)=c;
	iterNwcut=newNwcut;    
	iterCvol=newCvol;
	iterCcut=newCcut;
	counter=counter+1;
      end
    end
  end
  counter
  
  if (counter == 0)
    break;
  end
end

iterNwcut
