close all;
figure('Position', [100, 100, 600, 600]);


ulesfontsize = 28;

set(gca,'XTickLabel',n0_range)

% set(0, 'DefaultAxesFontSize', ulesfontsize);
set(0, 'DefaultTextFontSize', ulesfontsize);
set(0, 'DefaultUIControlFontSize', ulesfontsize);
set(0,'DefaultLineMarkerSize',ulesfontsize);
grid on;
plot(log2(n0_range),mean(errRP),'b*-');%./n0_range.^(-0.5)


hold on
plot(log2(n0_range),mean(errMT),'rs-');%./n0_range.^(-0.5)
plot(log2(n0_range),mean(errKD),'m^-');%./n0_range.^(-0.5)
plot(log2(n0_range),mean(errPA),'kp-');%./n0_range.^(-0.5)
axis([min(log2(n0_range)) max(log2(n0_range)) 0 1]);
set(gca,'XTickLabel',n0_range)

% xlabh = get(gca,'XTickLabel');
% xlabh = get(gca,'XTickPosition');
% set(xlabh,'Position',get(xlabh,'Position') - [0 2 0])

set(0, 'DefaultAxesFontSize', ulesfontsize);
set(0, 'DefaultTextFontSize', ulesfontsize);
set(0, 'DefaultUIControlFontSize', ulesfontsize);
set(0,'DefaultLineMarkerSize',ulesfontsize);
grid on;
axis square;
% increase line width:
set(0,'DefaultLineLineWidth',1.5) %helpful to make them more visible in a paper
% legend({'RP-Tree','Comp-Tree','KD-Tree','PA-Tree'},'Location','northeastoutside','fontsize',32);

% make matlab to save figure as it looks on the screen:
set(gcf, 'PaperPositionMode','auto')
xlabel('n_0: Max points in leaves');
ylabel('Empirical Probability of Error');
title(data_title);
