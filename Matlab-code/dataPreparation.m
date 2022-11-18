clear
close all
clc

load('In/VideoDatasetBS8.mat')
N = 8;
n = 0;
for k = 1:length(I_cols)
    n = n + size(I_cols{k},2);
end

X = zeros(N,N,n);
count = 0;
for k = 1:length(I_cols)
    residuals = I_cols{k};
    for i = 1:size(residuals,2)
        count = count + 1;
        X(:,:,count) = reshape(residuals(:,i),N,N);
    end
end
% save('In/X_N=8.mat','X')