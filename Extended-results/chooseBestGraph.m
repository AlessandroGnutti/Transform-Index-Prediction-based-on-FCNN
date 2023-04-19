function [T,Tdeq,ind_graph,J] = chooseBestGraph(B,U,Q,lambda)

J = -1; % In case that only the DC coeff survives

numb_graphs = size(U,3);
my_mse = zeros(1,numb_graphs);
my_rate = zeros(1,numb_graphs);
N = size(B,1);
for g = 1:numb_graphs
    % SBGFT
    T = reshape(U(:,:,g)'*B(:), [N, N]); Tq = round(T/Q); Tdeq = Tq*Q;
    % MSE computation
    my_mse(g) = sum(sum((T(:)-Tdeq(:)).^2));
    % Entropy computation
    my_rate(g) = my_entropy(zeros(1,2),Tq(:));
    % Check if just the DC coeff. survives or if there are just 0 coeff.
    if (Tq(1)~=0 && isempty(find(Tq(2:end)~=0, 1)))|| isempty(find(Tq(:)~=0, 1))
        my_mse(g) = -my_mse(g);
    end
end

%%%%%%%%%%%%%%%%% Start of RDO %%%%%%%%%%%%%%%%%
if length(find(my_mse<0))==numb_graphs % All the transforms lead to the DC coeff.
    ind_graph = 0; % No need to send the graph index
    % I can use the last computed T and Tdeq as output of the function
else
    my_mse = abs(my_mse);
    [J,idx_rd] = min(my_mse+lambda*my_rate);
    T = reshape(U(:,:,idx_rd)'*B(:), [N, N]); Tq = round(T/Q); Tdeq = Tq*Q;
    if isempty(Tq~=0) % All the coeff. are zero
        ind_graph = 0; % No need to send the graph index
    else
        ind_graph = idx_rd;
    end
end
%%%%%%%%%%%%%%%%% End of RDO %%%%%%%%%%%%%%%%%