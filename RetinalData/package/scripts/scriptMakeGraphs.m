close all
clear;

gtpath = fullfile('..', 'annotation_source');
rtpath = fullfile('..', 'results');
tldrtpath = fullfile('..', '..', 'separate');

[M_Acc1 M_Thr1 Hist1] =  computeAccuracySigmaCurve(fullfile(rtpath, 'exp_test1.txt'), ...
                 fullfile(gtpath, 'test1.txt'),...
                 -1,...
                 -1);
             
             
figure;
plot(M_Thr1,M_Acc1,'-bd','LineWidth',1.5); 

hold on ;
% [TLD_Acc1 TLD_Thr1 TLD_Hist1] =  computeAccuracySigmaCurve(fullfile(tldrtpath, 'seq1_tld_test_tldex_ori.txt'), ...
[TLD_Acc1 TLD_Thr1 TLD_Hist1] =  computeAccuracySigmaCurve(fullfile(tldrtpath, 'seq1_tld_test_best.txt'), ...
                 fullfile(gtpath, 'test1.txt'),...
                 -1,...
                 -1);
             
plot(TLD_Thr1,TLD_Acc1,'-rv','LineWidth',1.5); 

[TLD_Acc2 TLD_Thr2 TLD_Hist2] =  computeAccuracySigmaCurve(fullfile(tldrtpath, 'seq1_tld_test_tldex.txt'), ...
                 fullfile(gtpath, 'test1.txt'),...
                 -1,...
                 -1);
             
plot(TLD_Thr2,TLD_Acc2,'-g<','LineWidth',1.5); 

% hold on ;
% [TLD_Acc1 TLD_Thr1 TLD_Hist1_mf] =  computeAccuracySigmaCurve(fullfile(tldrtpath, 'seq1_tld_test_mf.txt'), ...
%                  fullfile(rtpath, 'test1.txt'),...
%                  -1,...
%                  -1);
%              
% plot(TLD_Thr1,TLD_Acc1,'-b<','LineWidth',1.5); 
%              
hold on;
load 'SCV_TEST1_tracker';
SCV_Acc1 = Acc;
SCV_Thr1 = Thr;
plot(SCV_Thr1,SCV_Acc1,'--bo','LineWidth',1.5);

hold on;
load 'MI_TEST1_tracker';
MI_Acc1 = Acc;
MI_Thr1 = Thr;
plot(MI_Thr1,MI_Acc1,'-.kx','LineWidth',1.5);

hold on;
load 'SSD_TEST1_tracker';
SSD_Acc1 = Acc;
SSD_Thr1 = Thr;
plot(SSD_Thr1,SSD_Acc1,'-.gs','LineWidth',1.5);

xlim([15 40])
ylim([0 1])
xlabel(' Accuracy Threshold ','fontsize',20,'fontweight','b') 
ylabel(' Percent Detected   ','fontsize',20,'fontweight','b') 
set(gca,'YTick',[0 0.2 0.4 0.6 0.8 1])
set(gcf,'Position',[1 1 595 250]);

grid;
legend({'DDVT', 'Proposed', 'TLD grad' 'SCV [11]','MI [6]','SSD'},'fontsize',14,'location','SouthEast');
set(gca,'fontsize',16) 

title('  Exp 2a  ','fontsize',20,'fontweight','b');

print('exp2a.tiff','-dtiffn');


F = 1:1000;%

load MI_TEST1_tracker_b
MI_List_1 = HIST;
load MI_TEST2_tracker_b
MI_List_2 = HIST;
load MI_TEST3_tracker_b
MI_List_3 = HIST;
MI_List_1 = MI_List_1(length(MI_List_1)-402:end);
MI_List_2 = MI_List_2(length(MI_List_2)-229:end);
MI_List_3 = MI_List_3(length(MI_List_3)-557:end);
% MI_vec = computeContTracking(MI_List_1);
% MI_vec = MI_vec/ (MI_vec*F');

Hist1{2} = Hist1{2} /(Hist1{2}*F');
TLD_Hist1{2} = TLD_Hist1{2} /(TLD_Hist1{2}*F');
TLD_Hist2{2} = TLD_Hist2{2} /(TLD_Hist2{2}*F');
% TLD_Hist1_mf{2} = TLD_Hist1_mf{2} /(TLD_Hist1_mf{2}*F');

figure;
% bar([Hist1{2}(1:10);TLD_Hist1{2}(1:10);TLD_Hist1_mf{2}(1:10); MI_vec(1:10)]');
bar([Hist1{2}(1:10);TLD_Hist1{2}(1:10);TLD_Hist2{2}(1:10)]');
title('  Exp 2a  ','fontsize',20,'fontweight','b');

xlim([0 10])
% ylim([0 .7])
xlabel(' Number of Consecutive Tracking Frames ','fontsize',20,'fontweight','b') 
ylabel(' Proportion of Frames   ','fontsize',20,'fontweight','b') 
set(gca,'YTick',[0.1 0.3 0.5 0.7])
set(gcf,'Position',[15 15 500 500 ]);

legend({'DDVT','Proposed','TLD grad', 'MI'},'fontsize',14,'location','NorthEast');
set(gca,'fontsize',16) 
% print('hist1_cons.tiff','-dtiffn');

return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%             
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[M_Acc2 M_Thr2 Hist1] =  computeAccuracySigmaCurve(fullfile(rtpath, 'exp_test2.txt'), ...
                 fullfile(rtpath, 'test2.txt'),...
                 -1,...
                 -1);
             
figure;
plot(M_Thr2,M_Acc2,'-bd','LineWidth',1.5);                                  

[TLD_Acc1 TLD_Thr1 TLD_Hist1] =  computeAccuracySigmaCurve(fullfile(tldrtpath, 'seq2_tld_test_best.txt'), ...
                 fullfile(rtpath, 'test2.txt'),...
                 -1,...
                 -1);
             
hold on;             
plot(TLD_Thr1,TLD_Acc1,'-rv','LineWidth',1.5); 
             
% [TLD_Acc1 TLD_Thr1 TLD_Hist1_mf] =  computeAccuracySigmaCurve(fullfile(tldrtpath, 'seq2_tld_test_mf.txt'), ...
%                  fullfile(rtpath, 'test2.txt',...
%                  -1,...
%                  -1);
%              
hold on;             
plot(TLD_Thr1,TLD_Acc1,'-b<','LineWidth',1.5); 

hold on;
load 'SCV_TEST2_tracker';
SCV_Acc2 = Acc;
SCV_Thr2 = Thr;
plot(SCV_Thr2,SCV_Acc2,'--bo','LineWidth',1.5);

hold on;
load 'MI_TEST2_tracker';
MI_Acc2 = Acc;
MI_Thr2 = Thr;
plot(MI_Thr2,MI_Acc2,'-.kx','LineWidth',1.5);

hold on;
load 'SSD_TEST2_tracker';
SSD_Acc2 = Acc;
SSD_Thr2 = Thr;
plot(SSD_Thr2,SSD_Acc2,'-.gs','LineWidth',1.5);

xlim([15 40])
ylim([0.2 1])
xlabel(' Accuracy Threshold ','fontsize',20,'fontweight','b') 
ylabel(' Percent Detected   ','fontsize',20,'fontweight','b') 
set(gca,'YTick',[0.2 0.4 0.6 0.8 1])
set(gcf,'Position',[1 1 595 250]);


grid;
legend({'DDVT', 'Proposed', 'TLD mf' 'SCV [11]','MI [6]','SSD'},'fontsize',14,'location','SouthEast');
set(gca,'fontsize',16) 

title('  Exp 2b  ','fontsize',20,'fontweight','b');

print('exp2b.tiff','-dtiffn');


F = 1:1000;%
MI_vec = computeContTracking(MI_List_2);
MI_vec = MI_vec/ (MI_vec*F');
Hist1{2} = Hist1{2} /(Hist1{2}*F');
TLD_Hist1{2} = TLD_Hist1{2} /(TLD_Hist1{2}*F');
% TLD_Hist1_mf{2} = TLD_Hist1_mf{2} /(TLD_Hist1_mf{2}*F');

figure;
% bar([Hist1{2}(1:10);TLD_Hist1{2}(1:10);TLD_Hist1_mf{2}(1:10); MI_vec(1:10)]');
bar([Hist1{2}(1:10);TLD_Hist1{2}(1:10)]');
title('  Exp 2b  ','fontsize',20,'fontweight','b');

xlim([0 10])
ylim([0 .7])
xlabel(' Number of Consecutive Tracking Frames ','fontsize',20,'fontweight','b') 
ylabel(' Proportion of Frames   ','fontsize',20,'fontweight','b') 
set(gca,'YTick',[0.1 0.3 0.5 0.7])
set(gcf,'Position',[15 15 500 500 ]);

legend({'DDVT','Porposed','TLD mf', 'MI'},'fontsize',14,'location','NorthEast');
set(gca,'fontsize',16) 
% print('hist1_cons2.tiff','-dtiffn');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%             
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             
[M_Acc3 M_Thr3 Hist1] =  computeAccuracySigmaCurve(fullfile(rtpath, 'exp_test3.txt'), ...
                 fullfile(rtpath, 'test3.txt'),...
                 -1,...
                 -1);
             
figure;
plot(M_Thr3,M_Acc3,'-bd','LineWidth',1.5);   

[TLD_Acc1 TLD_Thr1 TLD_Hist1] =  computeAccuracySigmaCurve(fullfile(tldrtpath, 'seq3_tld_test_best.txt'), ...
                 fullfile(rtpath, 'test3.txt'),...
                 -1,...
                 -1);
             
hold on;
plot(TLD_Thr1,TLD_Acc1,'-rv','LineWidth',1.5); 
             
[TLD_Acc1 TLD_Thr1 TLD_Hist1_mf] =  computeAccuracySigmaCurve(fullfile(tldrtpath, 'seq3_tld_test_mf.txt'), ...
                 fullfile(rtpath, 'test3.txt'),...
                 -1,...
                 -1);
             
hold on;
plot(TLD_Thr1,TLD_Acc1,'-b>','LineWidth',1.5); 

hold on;
load 'SCV_TEST3_tracker';
SCV_Acc3 = Acc;
SCV_Thr3 = Thr;
plot(SCV_Thr3,SCV_Acc3,'--bo','LineWidth',1.5);

hold on;
load 'MI_TEST3_tracker';
MI_Acc3 = Acc;
MI_Thr3 = Thr;
plot(MI_Thr3,MI_Acc3,'-.kx','LineWidth',1.5);

hold on;
load 'SSD_TEST1_tracker';
SSD_Acc3 = Acc;
SSD_Thr3 = Thr;
plot(SSD_Thr3,SSD_Acc3,'-.gs','LineWidth',1.5);

xlim([15 40])
ylim([0.2 1])
xlabel(' Accuracy Threshold ','fontsize',20,'fontweight','b') 
ylabel(' Percent Detected   ','fontsize',20,'fontweight','b') 
set(gca,'YTick',[0.2 0.4 0.6 0.8 1])
set(gcf,'Position',[1 1 595 250]);

grid;
legend({'DDVT','Proposed', 'TLD mf', 'SCV [11]','MI [6]','SSD'},'fontsize',14,'location','SouthEast');
set(gca,'fontsize',16) 

title('  Exp 2c  ','fontsize',20,'fontweight','b');

print('exp2c.tiff','-dtiffn');

F = 1:1000;%
MI_vec = computeContTracking(MI_List_3);
MI_vec = MI_vec/ (MI_vec*F');
Hist1{2} = Hist1{2} /(Hist1{2}*F');
TLD_Hist1{2} = TLD_Hist1{2} /(TLD_Hist1{2}*F');
% TLD_Hist1_mf{2} = TLD_Hist1_mf{2} /(TLD_Hist1_mf{2}*F');

figure;
% bar([Hist1{2}(1:10);TLD_Hist1{2}(1:10);TLD_Hist1_mf{2}(1:10); MI_vec(1:10)]');
bar([Hist1{2}(1:10);TLD_Hist1{2}(1:10)]');

xlim([0 10])
ylim([0 .7])
xlabel(' Number of Consecutive Tracking Frames ','fontsize',20,'fontweight','b') 
ylabel(' Proportion of Frames   ','fontsize',20,'fontweight','b') 
set(gca,'YTick',[0.1 0.3 0.5 0.7])
set(gcf,'Position',[15 15 500 500 ]);


title('  Exp 2c  ','fontsize',20,'fontweight','b');

legend({'DDVT','Proposed','TLD mf', 'MI'},'fontsize',14,'location','NorthEast');
set(gca,'fontsize',16) 
% print('hist1_cons3.tiff','-dtiffn');

             
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%             
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             
[M_Acc123 M_Thr123 Hist123 dist] = computeAccuracySigmaCurve(fullfile(rtpath, 'exp_test9.txt'), ...
                              fullfile(rtpath, 'test_all.txt'),...
                              -1,...
                              -1);
             
             
figure;
plot(M_Thr123,M_Acc123,'-rd','LineWidth',1.5);                                  
             
hold on;
load 'SCV_TEST123_tracker';
SCV_Acc123 = Acc;
SCV_Thr123 = Thr;
plot(SCV_Thr123,SCV_Acc123,'--bo','LineWidth',1.5);

hold on;
load 'MI_TEST123_tracker';
MI_Acc123 = Acc;
MI_Thr123 = Thr;
plot(MI_Thr123,MI_Acc123,'-.kx','LineWidth',1.5);

hold on;
load 'SSD_TEST123_tracker';
SSD_Acc123 = Acc;
SSD_Thr123 = Thr;
plot(SSD_Thr123,SSD_Acc123,'-.gs','LineWidth',1.5);

xlim([15 40])
ylim([0.2 1])
xlabel(' Accuracy Threshold ','fontsize',20,'fontweight','b') 
ylabel(' Percent Detected   ','fontsize',20,'fontweight','b') 
set(gca,'YTick',[0.2 0.4 0.6 0.8 1])
set(gcf,'Position',[1 1 500 500]);
grid;

legend({'Our Method','SCV [11]','MI [6]','SSD'},'fontsize',14,'location','SouthEast');
set(gca,'fontsize',16) 

%title('  Full Dataset  ','fontsize',20,'fontweight','b');

print('exp1.tiff','-dtiffn');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%             
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
plot(M_Thr3,M_Acc3,'-rd','LineWidth',1.5,'MarkerSize',15);                                        
hold on;
plot(SCV_Thr3,SCV_Acc3,'-bd','LineWidth',1.5,'MarkerSize',15);
hold on;
plot(MI_Thr3,MI_Acc3,'-kd','LineWidth',1.5,'MarkerSize',15);
hold on;
plot(M_Thr2,M_Acc2,'-ro','LineWidth',1.5,'MarkerSize',15);                                         
hold on;
plot(SCV_Thr2,SCV_Acc2,'-bo','LineWidth',1.5,'MarkerSize',15);
hold on;
plot(MI_Thr2,MI_Acc2,'-ko','LineWidth',1.5,'MarkerSize',15);
hold on;
plot(M_Thr1,M_Acc1,'-rx','LineWidth',1.5,'MarkerSize',15);                
hold on;
plot(SCV_Thr1,SCV_Acc1,'-bx','LineWidth',1.5,'MarkerSize',15);
hold on;
plot(MI_Thr1,MI_Acc1,'-kx','LineWidth',1.5,'MarkerSize',15);

xlim([15 40])
ylim([0.2 1])
xlabel(' Accuracy Threshold ','fontsize',20,'fontweight','b') 
ylabel(' Fraction Detected   ','fontsize',20,'fontweight','b') 
set(gca,'YTick',[0.2 0.4 0.6 0.8 1])
set(gcf,'Position',[1 1 500 500]);

grid;
legend({'Our Method','SCV [11]','MI [6]'},'fontsize',14,'location','SouthEast');
set(gca,'fontsize',16) 

%title('  Exp2a to c  ','fontsize',20,'fontweight','b');
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%             
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
%Histogram plot

load MI_TEST1_tracker_b
MI_List_1 = HIST;
load MI_TEST2_tracker_b
MI_List_2 = HIST;
load MI_TEST3_tracker_b
MI_List_3 = HIST;
MI_List_1 = MI_List_1(length(MI_List_1)-402:end);
MI_List_2 = MI_List_2(length(MI_List_2)-229:end);
MI_List_3 = MI_List_3(length(MI_List_3)-557:end);
MI_List = [ MI_List_1 MI_List_2 MI_List_3 ];
MI_vec = computeContTracking(MI_List);

load SCV_TEST1_tracker_b
SCV_List_1 = HIST;
load SCV_TEST2_tracker_b
SCV_List_2 = HIST;
load SCV_TEST3_tracker_b
SCV_List_3 = HIST;
SCV_List_1 = SCV_List_1(length(SCV_List_1)-402:end);
SCV_List_2 = SCV_List_2(length(SCV_List_2)-229:end);
SCV_List_3 = SCV_List_3(length(SCV_List_3)-557:end);
SCV_List = [ SCV_List_1 SCV_List_2 SCV_List_3 ];
SCV_vec = computeContTracking(SCV_List);

load SSD_TEST1_tracker_b
SSD_List_1 = HIST;
load SSD_TEST2_tracker_b
SSD_List_2 = HIST;
load SSD_TEST3_tracker_b
SSD_List_3 = HIST;
SSD_List_1 = SSD_List_1(length(SSD_List_1)-402:end);
SSD_List_2 = SSD_List_2(length(SSD_List_2)-229:end);
SSD_List_3 = SSD_List_3(length(SSD_List_3)-557:end);
SSD_List = [ SSD_List_1 SSD_List_2 SSD_List_3 ];
SSD_vec = computeContTracking(SSD_List);

SCV = [];
MI  = [];
SSD = [];
OUR = [];
for f=2:length(Hist123{2})
    OUR = [OUR f*ones(1,Hist123{2}(f))];
    SCV = [SCV f*ones(1,SCV_vec(f))];
    MI  = [MI f*ones(1,MI_vec(f))];
    SSD = [SSD f*ones(1,SSD_vec(f))];
end

F = 1:1000;%
MI_vec = MI_vec/ (MI_vec*F');
SCV_vec = SCV_vec/ (SCV_vec*F');
SSD_vec = SSD_vec/ (SSD_vec*F');
Hist123{2} = Hist123{2} /(Hist123{2}*F');

figure;
bar([Hist123{2}(1:10);SCV_vec(1:10);MI_vec(1:10);SSD_vec(1:10)]');

xlim([0 10])
ylim([0 .7])
xlabel(' Number of Consecutive Tracking Frames ','fontsize',20,'fontweight','b') 
ylabel(' Proportion of Frames   ','fontsize',20,'fontweight','b') 
set(gca,'YTick',[0.1 0.3 0.5 0.7])
set(gcf,'Position',[15 15 500 500 ]);

legend({'Our Method','SCV [11]','MI [6]','SSD'},'fontsize',14,'location','NorthEast');
set(gca,'fontsize',16) 
print('hist_cons.tiff','-dtiffn');
