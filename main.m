addpath(genpath('./drtoolbox/'))
t = cputime;

load data.mat
lag = 1;
horizon = 1;
numBag = 1;
data = horzcat(macroFinancial, stockFlow, price, WTI);
[trainX,trainY,testX,testY]=dataPartition(data,lag,horizon);

Yfit =forecastSDAEBag(trainX, trainY, testX, numBag);

e = cputime-t;
sprintf('Elapsed CPU time is %f (second)', e)

%%

fig1 = figure(1);
set(fig1,'units','inches');
ax(1)=subplot(211);
pos = get(gcf,'pos');
set(gcf,'pos',[pos(1) pos(2) 12 5]);

plot(Yfit,'r-*'); hold on;
plot(testY,'k-');
legend('Fit','WTI')
axis tight;
grid on;
title('Predicted Crude Price (Test) vs. Actual')
ax(2) = subplot(212);
plot(Yfit-testY,'g-o');
linkaxes(ax,'x');
grid on;
title('Yfit - testY (USD)')
print(fig1,'-dpng','-r200','Crude Price Comparison(Bag=1)')

