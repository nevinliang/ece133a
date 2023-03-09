mooreslaw
n = length(T);
A = [ones(n, 1) T(:,1)-1970];
y = log(T(:,2))/log(10);

% trying to minimize
w = A \ y;


