clear
close all
clc
hold on

load('ResultsResiduals8x8_SBGFT.mat')
% With entropy coding
x = my_bpp_gft(:)+my_bpp_graph_index(:); y = my_psnr_gft(:);
ch = convhull(x,y);
plot(x(ch(1:end-1)),y(ch(1:end-1)),'b','LineWidth',1.5)
hold on
% With MLP
my_bpp_graph_index_estimated = [2.7/64 3.08/64 3.32/64 3.53/64 3.53/64]';
x = my_bpp_gft+my_bpp_graph_index_estimated; x = x(:); y = my_psnr_gft(:);
ch = convhull(x,y);
plot(x(ch(1:end-2)),y(ch(1:end-2)),'b--','LineWidth',1.5)
% With MLP and prediction mode
my_bpp_graph_index_estimated = [2.5/64 2.8/64 3/64 3.3/64 3.3/64]';
x = my_bpp_gft+my_bpp_graph_index_estimated; x = x(:); y = my_psnr_gft(:);
ch = convhull(x,y);
plot(x(ch(1:end-1)),y(ch(1:end-1)),'b-.','LineWidth',1.5)

% MTS - VVC
load('ResultsResiduals8x8_MTS.mat')
x = my_bpp_MTS(:)+my_bpp_transform_index(:); y = my_psnr_MTS(:);
ch = convhull(x,y);
plot(x(ch(1:end-1)),y(ch(1:end-1)),'r','LineWidth',1.5)
grid on, xlim([0.3,1.2]), ylim([32 39])
xlabel('bpp'), ylabel('PSNR')
xticks(0.3:0.1:1.2),yticks(32:39)
legend('SBGFT','SBGFT with MLP','SBGFT with MP and PM','MTS','Location','southeast')