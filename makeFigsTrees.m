figure('Position', [100, 100, 600, 1200]);
ulesfontsize = 28;
subplot(2,1,1);
set(gca,'XTickLabel',n0_range)

set(0, 'DefaultTextFontSize', ulesfontsize);
set(0, 'DefaultUIControlFontSize', ulesfontsize);
set(0,'DefaultLineMarkerSize',ulesfontsize);
grid on;
plot(log2(n0_range),mean(errRP),'b*-');
hold on
plot(log2(n0_range),mean(errMT),'rs-');
plot(log2(n0_range),mean(errKD),'m^-');
plot(log2(n0_range),mean(errPA),'kp-');
axis([min(log2(n0_range)) max(log2(n0_range)) 0 1]);
set(gca,'XTickLabel',n0_range)

set(0, 'DefaultTextFontSize', ulesfontsize);
set(0, 'DefaultUIControlFontSize', ulesfontsize);
set(0,'DefaultLineMarkerSize',ulesfontsize);
grid on;
axis square;
% increase line width:
set(0,'DefaultLineLineWidth',1.5) %helpful to make them more visible in a paper
legend({'RP-Tree','Comp-Tree','KD-Tree','PA-Tree'},'Location','northeastoutside','fontsize',32);

% make matlab to save figure as it looks on the screen:
set(gcf, 'PaperPositionMode','auto')
xlabel('n_0: Max points in leaves');
ylabel('Empirical Probability of Error');
title(data_title);

%
subplot(2,1,2);
set(gca,'XTickLabel',n0_range)
legend({'RP-Tree','Metric-Tree','KD-Tree','PA-Tree'},'Location','northeastoutside','fontsize',32);

set(0, 'DefaultTextFontSize', ulesfontsize);
set(0, 'DefaultUIControlFontSize', ulesfontsize);
set(0,'DefaultLineMarkerSize',ulesfontsize);
grid on;
plot(log2(n0_range),mean(errDSRP),'b*-');
    hold on
    plot(log2(n0_range),mean(errDSMT),'rs-');
    plot(log2(n0_range),mean(errDSKD),'m^-');
    plot(log2(n0_range),mean(errDSPA),'kp-');
  set(gca,'XTickLabel',n0_range)
maxval = max([mean(errDSKD),mean(errDSRP),mean(errDSMT),mean(errDSPA)]);
axis([min(log2(n0_range)),max(log2(n0_range)),0,maxval]);
legend({'RP-Tree','Comp-Tree','KD-Tree','PA-Tree'},'Location','northeastoutside','fontsize',32);

set(0, 'DefaultAxesFontSize', ulesfontsize);
set(0, 'DefaultTextFontSize', ulesfontsize);
set(0, 'DefaultUIControlFontSize', ulesfontsize);
set(0,'DefaultLineMarkerSize',ulesfontsize);
grid on;
axis square;
% increase line width:
set(0,'DefaultLineLineWidth',1.5) %helpful to make them more visible in a paper

% make matlab to save figure as it looks on the screen:
  xlabel('n0: Max points in leaves');
    ylabel('Avg. Relative Distnace Error');
%     title(data_title);
    
set(gcf, 'PaperPositionMode','auto')
