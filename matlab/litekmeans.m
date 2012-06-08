function label = litekmeans(X, k)
n = size(X,2);
last = 0;
label = ceil(k*rand(1,n));  % random initialization
while any(label ~= last)
    E = sparse(1:n,label,1,n,k,n);  % transform label into indicator matrix
    center = X*(E*spdiags(1./sum(E)',0,k,k));    % compute center of each cluster
    last = label;
    [val,label] = max(bsxfun(@minus,center'*X,0.5*sum(center.^2)')); % assign samples to the nearest centers
end
