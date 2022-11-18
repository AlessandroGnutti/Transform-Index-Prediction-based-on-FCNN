clear
clc
close all

load('In/X_N=8.mat'); % Load X
load('In/U8.mat') % Load U
load('In/predictionModes.mat') % Load predictionModes_vector

num_transforms = size(U,3);
N = sqrt(size(U,1));

QP = 40; 
Qstep = (2^(1/6)).^(QP-4);

Xq = zeros(size(X,3),64);
y = zeros(size(X,3),1);
predModes = zeros(size(X,3),1);
counter = 0;
for k = 1:size(X,3)
    disp(k)
    B = X(:,:,k);
    my_mse = zeros(1,num_transforms);
    for g = 1:num_transforms
        T = U(:,:,g)'*B(:);
        Tq = Qstep*round(T/Qstep);
        my_mse(g) = immse(T,Tq);
        if Tq(1)~=0 && isempty(find(T(2:end)~=0, 1))
            my_mse(g) = -my_mse(g); % Tengo traccia delle trasformate che portano al solo dc coef
        end
    end
    if length(find(my_mse<0))==num_transforms % Tutte le trasformate portano al solo dc coef
        % Non fare niente
    else
        my_mse = abs(my_mse);
        [~,idx_winner] = min(my_mse);
        T_winner = U(:,:,idx_winner)'*B(:);
        Tq_winner = round(T_winner/Qstep);
        if isempty(find(Tq_winner~=0, 1))
            % Nothing
        else
            counter = counter + 1;
            Xq(counter,:) = Tq_winner';
            y(counter) = idx_winner;
            predModes(counter) = predictionMode_vector(k);
        end
    end
end
% save(strcat('Dataset/Xq_QP',num2str(QP),'.mat'),'Xq')
% save(strcat('Dataset/y_QP',num2str(QP),'.mat'),'y')
% save(strcat('Dataset/predModes_QP',num2str(QP),'.mat'),'predModes')