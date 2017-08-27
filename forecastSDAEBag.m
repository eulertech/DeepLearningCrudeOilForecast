function Yfit = forecastSDAEBag( trainX,trainY,testX, numBag )
% generate a set of (N) training samples using bootstrapping
[~,bootsam] = bootstrp(numBag, [], trainX, trainY);
[aX,bX]=size(trainX);
[aY,bY]=size(trainY);
trainXAll=zeros(aX,bX,numBag);
trainYAll=zeros(aY,bY,numBag);
for jj=1:numBag
    trainXAll(:,:,jj)=trainX(bootsam(:,jj), :);
    trainYAll(:,:,jj)=trainY(bootsam(:,jj), :);
end

% generate N predictions and aggregate
YfitBag=zeros(  size(testX,1), numBag);
for ii=1:numBag
    sprintf('The %d th bag SDAE',ii)
    YfitBag(:,ii) = forecastSDAE(...
        trainXAll(:,:,ii), trainYAll(:,:,ii), testX);
end
Yfit=mean(YfitBag, 2);
end