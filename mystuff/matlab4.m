n = 500;
a = randn(n, 1);
b = randn(n, 1);
A = toeplitz(a, [a(1), flipud(a(2:n))']);

t = 100;
time = zeros(1, t);
for i = 1:t
	tic;
	x = ifft(fft(b) ./ fft(a));
	time(i) = toc;
end
sum(time)

time = zeros(1, t);
for i = 1:t
	tic;
	x = A \ b;
	time(i) = toc;
end
sum(time)
