rng('default');
N = 50;
R = 0.4;
s = 0.1;
[E, pos, K] = network_loc_data(N, R);

% plot original points
clf;
figure(1);
axis([-0.1 1.1 -0.1 1.1]);

hold on;
scatter(pos(N-K+1:end,1), pos(N-K+1:end,2), 'red', 'square', 'filled');
scatter(pos(1:N-K,1), pos(1:N-K,2), 'blue', 'filled');

% set up parameters for pos_free function
pos_anchor = pos(N-K+1:N, :);
L = size(E,1);
d = sqrt(sum((pos(E(:,1),:) - pos(E(:,2),:)).^2, 2));
rho = (1 + s*randn(L,1)) .* d;
%[pos_free, cost, lambdas] = network_loc(N, E, pos_anchor, rho);
pos_free = network_loc(N, E, pos_anchor, rho);

scatter(pos_free(:,1), pos_free(:,2), 'blue');

for i = 1:N-K 
    plot([pos_free(i,1),pos(i,1)],[pos_free(i,2),pos(i,2)],'k-');
end
legend('anchor points', 'actual positions', 'free points');
% figure(2);
% plot(1:length(cost), cost, '-o', 'MarkerIndices', 1:length(cost));
% xlabel('k');
% ylabel('||f(x^{(k)}||^2');
% title('cost function');
% figure(3);
% plot(1:length(lambdas), lambdas, '-o', 'MarkerIndices', 1:length(lambdas));
% xlabel('k');
% ylabel('\lambda^{(k)}');
% title('regularization param');