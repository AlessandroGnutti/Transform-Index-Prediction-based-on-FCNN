% For each block, the best transform from the set in MTS is selected.

clear
close all
clc

% Folders and files
temp = load('In/X_N=8.mat');
X = temp.X;
random_ind = randsample(size(X,3), round(size(X,3)/10));
X = X(:,:,random_ind);

fld_in = 'In/';
str_U8 = 'U8.mat';

% Parameters
N = 8;
numb_tr = 5; % Num. transforms

% Quantization
QP = 25:5:45;
Qstep = (2^(1/6)).^(QP-4);
lambda_vec = [0 10000 20000 50000 100000];
L_q = length(QP);

% Outputs
my_psnr_MTS = zeros(length(QP),length(lambda_vec));
my_bpp_transform_index = zeros(length(QP),length(lambda_vec));
my_bpp_MTS = zeros(length(QP),length(lambda_vec));

for q = 1:L_q % Quantization step iteration
    for lambda_ind = 1:length(lambda_vec) % lambda iteration
        fprintf('Quantizzazione %d di %d\n',q,L_q)
        fprintf('Lambda %d di %d\n',lambda_ind,length(lambda_vec))

        lambda = lambda_vec(lambda_ind);
        bit_MTS = zeros(1,size(X,3));
        T = zeros(size(X));
        Tq = zeros(size(X));
        Tdeq = zeros(size(X));
        for ii = 1:size(X,3)
            B = X(:,:,ii);
            [T(:,:,ii),Tdeq(:,:,ii),g] = chooseBestMTS(B,Qstep(q),lambda);
            bit_MTS(ii) = g;
        end

        my_psnr_MTS(q,lambda_ind) = 20*log10(255/sqrt(sum((T(:)-Tdeq(:)).^2)/numel(X)));
        code_MTS = my_arith_enco(Tdeq/Qstep(q));
        my_bpp_MTS(q,lambda_ind) = length(code_MTS)/numel(X);
        my_bpp_transform_index(q,lambda_ind) = sum(bit_MTS)/numel(X);
    end
end
save('ResultsResiduals8x8_MTS.mat','my_psnr_MTS','my_bpp_MTS','my_bpp_transform_index','QP','lambda_vec')
