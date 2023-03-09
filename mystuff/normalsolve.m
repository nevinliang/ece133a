function [x] = normalsolve(B, Y, lambda)
%NORMALSOLVE Summary of this function goes here
%   Detailed explanation goes here
y = Y(:);
n = sqrt(length(y));
b = B(:);
Wy = reshape(fft2(reshape(y, n, n)), n^2, 1);
Wb = reshape(fft2(reshape(b, n, n)), n^2, 1);
E = zeros(n);
E(1,1) = 1;
E(n,1) = -1;
e = E(:);
ET = E';
eh = ET(:);
We = reshape(fft2(reshape(e, n, n)), n^2, 1);
Weh = reshape(fft2(reshape(eh, n, n)), n^2, 1);

D = conj(Wb) .* Wb + lambda * (conj(We) .* We) + lambda * (conj(Weh) .* Weh);

x = reshape(ifft2(reshape((1./D) .* conj(Wb) .* Wy, n, n)), n^2, 1);
end

