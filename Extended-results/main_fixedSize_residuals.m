% For each bloc, the best transform from the set of SBGFTs is selected

clear
close all
clc

% Folders and files
temp = load('X_N=8.mat');
X = temp.X;
random_ind = randsample(size(X,3), round(size(X,3)/10));
X = X(:,:,random_ind);

% Parameters
load('U8.mat') % Load U
U = changeU(U);
N = sqrt(size(U, 1));
numb_graphs = size(U,3); % Numero grafie

% Quantization
QP = 25:5:45;
Qstep = (2^(1/6)).^(QP-4);
lambda_vec = [0 10000 20000 50000 100000];
L_q = length(QP);

% Outputs
my_psnr_gft = zeros(length(QP),length(lambda_vec));
my_psnr_dct = zeros(length(QP),length(lambda_vec));
my_bpp_gft = zeros(length(QP),length(lambda_vec));
my_bpp_graph_index = zeros(length(QP),length(lambda_vec));
my_bpp_dct = zeros(length(QP),length(lambda_vec));

for q = 1:L_q % Quantization step iteration
    for lambda_ind = 1:length(lambda_vec) % lambda iteration
        fprintf('Quantizzazione %d di %d\n',q,L_q)
        fprintf('Lambda %d di %d\n',lambda_ind,length(lambda_vec))

        lambda = lambda_vec(lambda_ind);
        T = zeros(size(X));
        Tdeq = zeros(size(X));
        ind_graph8 = zeros(1,size(X,3));
        Tdct = zeros(size(X));
        Tdctq = zeros(size(X));
        Tdctdeq = zeros(size(X));
        for ii = 1:size(X,3)
            B = X(:,:,ii);
            [T(:,:,ii),Tdeq(:,:,ii),g] = chooseBestGraph(B,U,Qstep(q),lambda);
            ind_graph8(ii) = g;
            Tdct(:,:,ii) = dct2(B);
            Tdctq(:,:,ii) = round(Tdct(:,:,ii)/Qstep(q));
            Tdctdeq(:,:,ii) = Tdctq(:,:,ii)*Qstep(q); 
        end

        ind_graph8(ind_graph8==0) = [];

        my_psnr_gft(q,lambda_ind) = 20*log10(255/sqrt(sum((T(:)-Tdeq(:)).^2)/numel(X)));
        code_gft = my_arith_enco(Tdeq/Qstep(q));
        my_bpp_gft(q,lambda_ind) = length(code_gft)/numel(X);
        if isempty(ind_graph8)
            code_graph8 = [];
        else
            code_graph8 = my_arith_enco(ind_graph8);
        end
        my_bpp_graph_index(q,lambda_ind) = length(code_graph8)/numel(X);

        % DCT
        my_psnr_dct(q,lambda_ind) = 20*log10(255/sqrt(sum((Tdct(:)-Tdctdeq(:)).^2)/numel(X)));
        code_dct = my_arith_enco(Tdctq);
        my_bpp_dct(q,lambda_ind) = length(code_dct)/numel(X);
    end
end
save('ResultsResiduals8x8_SBGFT.mat','my_psnr_gft','my_bpp_gft','my_bpp_graph_index','QP','lambda_vec')
