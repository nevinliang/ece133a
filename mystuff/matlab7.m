% 10.1a

N = 30;

A = [1 1; 0 0.95];
b = [0; 0.1];

C = zeros(2, N);

bi = b;
for i = N:-1:1
	C(:,i) = bi;
	bi = A * bi;
end

d = [10; 0];

[Q, R] = qr(C', 0);
x = Q * (R' \ d)