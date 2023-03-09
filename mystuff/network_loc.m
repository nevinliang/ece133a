function pos_free = network_loc(N, E, pos_anchor, rho)
%function [pos_free, cost, lambdas] = network_loc(N, E, pos_anchor, rho)
    L = size(E,1);
    K = length(pos_anchor);
    beta1 = 0.8;
    beta2 = 2.0;
    x = rand(2 * N - 2 * K, 1);
    pos = [x(1:N-K) x(N-K+1:end); pos_anchor];
    lambdas = zeros(10000, 1);
    lambdas(1) = 0.1;
    cost = zeros(10000, 1);
    for i = 1:10000
        fxk = f(x, pos, L, N, K, E, rho);
        cost(i) = norm(fxk)^2;
        A = D(x, fxk, pos, L, N, K, E, rho);
        M = [A; sqrt(lambdas(i)) * eye(2 * N - 2 * K)];
        b = [fxk; zeros(2 * N - 2 * K, 1)];
        xhat = x - M \ b;
        fxk1 = f(xhat, pos, L, N, K, E, rho);
        if norm(fxk)^2 > norm(fxk1)^2
            x = xhat;
            lambdas(i + 1) = beta1 * lambdas(i);
        else
            lambdas(i + 1) = beta2 * lambdas(i);
        end
        if 2 * A' * fxk <= 1e-5
            break;
        end
    end
%     cost = cost(1:i);
%     lambdas = lambdas(1:i);
    pos_free = [x(1:N-K) x(N-K+1:end)];
end

function A = D(x, fxk, pos, L, N, K, E, rho)
    A = zeros(L, 2 * (N - K));
    pos(1:N-K, 1) = x(1:N-K);
    pos(1:N-K, 2) = x(N-K+1:end);
    for e = 1:L
        fac = 1 / (fxk(e) + rho(e));
        ik = E(e, 1);
        jk = E(e, 2);
        if ik <= N - K
            A(e, ik) = fac * (pos(ik, 1) - pos(jk, 1));
            A(e, ik + N - K) = fac * (pos(ik, 2) - pos(jk, 2));
        end
        if jk <= N - K
            A(e, jk) = fac * (pos(jk,1) - pos(ik,1));
            A(e, jk + N - K) = fac * (pos(jk,2) - pos(ik,2));
        end
    end
end

function out = f(x, pos, L, N, K, E, rho)    
    out = zeros(L, 1);
    pos(1:N-K, 1) = x(1:N-K);
    pos(1:N-K, 2) = x(N-K+1:end);
    for e = 1:L
        out(e) = norm(pos(E(e,1),:) - pos(E(e,2),:)) - rho(e);
    end
end