ulesfontsize = 20;
figure('Position', [100, 100, 600, 1200]);

subplot(2,1,1)
xlabel('Avg #triplets in query phase');
ylabel('Avg. Relative Distance Error');
set(0, 'DefaultAxesFontSize', ulesfontsize);
set(0, 'DefaultTextFontSize', ulesfontsize);
set(0, 'DefaultUIControlFontSize', ulesfontsize);
set(0,'DefaultLineMarkerSize',ulesfontsize);
grid on;
plot(queryTripletsRCT,RDERCT,'r-*');
hold on;
plot(querytripletsCT,RDECT,'b-+');

legend({'RCT','Comp-Tree'},'location','northeastoutside','FontSize',32);
xlabel('Avg #triplets in query phase');
ylabel('Avg. Relative Distance Error');
title(data_title);

set(0, 'DefaultAxesFontSize', ulesfontsize);
set(0, 'DefaultTextFontSize', ulesfontsize);
set(0, 'DefaultUIControlFontSize', ulesfontsize);
set(0,'DefaultLineMarkerSize',ulesfontsize);
grid on;
axis square;
% increase line width:
set(0,'DefaultLineLineWidth',1.5) %helpful to make them more visible in a paper

% make matlab to save figure as it looks on the screen:
set(gcf, 'PaperPositionMode','auto')
% subplot(3,1,2)
% xlabel('Avg #triplets in query phase');
% ylabel('Avg. Relative Distance Error');
% plot(queryTripletsRCT,ERRRCT,'r-*');
% hold on;
% plot(querytripletsMT,ERRMT,'b-+');
% 
% % legend({'RCT','Comp-Tree'},'location','northeastoutside','FontSize',32);
% xlabel('Avg #triplets in query phase');
% ylabel('Error Probability');
% 
% set(0, 'DefaultAxesFontSize', ulesfontsize);
% set(0, 'DefaultTextFontSize', ulesfontsize);
% set(0, 'DefaultUIControlFontSize', ulesfontsize);
% set(0,'DefaultLineMarkerSize',ulesfontsize);
% grid on;
% axis square;
% % increase line width:
% set(0,'DefaultLineLineWidth',1.5) %helpful to make them more visible in a paper
% 
% % make matlab to save figure as it looks on the screen:
% set(gcf, 'PaperPositionMode','auto')
subplot(2,1,2)
xlabel('Avg #triplets in query phase');
ylabel('Avg. Relative Distance Error');
semilogy(queryTripletsRCT,treeTripletsRCT,'r-*');
hold on
semilogy(querytripletsCT,treeTripletsCT,'b-+');

legend({'RCT','Comp-Tree'},'location','northeastoutside','FontSize',32);
xlabel('Avg #triplets in query phase');
ylabel('#triplets in construction phase');

set(0, 'DefaultAxesFontSize', ulesfontsize);
set(0, 'DefaultTextFontSize', ulesfontsize);
set(0, 'DefaultUIControlFontSize', ulesfontsize);
set(0,'DefaultLineMarkerSize',ulesfontsize);
grid on;
axis square;
% increase line width:
set(0,'DefaultLineLineWidth',1.5) %helpful to make them more visible in a paper

% make matlab to save figure as it looks on the screen:
set(gcf, 'PaperPositionMode','auto')

