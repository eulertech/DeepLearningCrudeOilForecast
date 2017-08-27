function [trainX,trainY,testX,testY]=dataPartition(data,lag,horizon)
% partition the data into training and testing sets
trainRate=0.8;
index=1;
n = size(data,1);
data_rand = data(randperm(n),:); % permutation??

endPoint=floor( trainRate*n );
trainSize=endPoint-(lag+horizon-1);

trainX=zeros(size(data,2),trainSize);
trainY=zeros(1,trainSize);
for k=1:trainSize
    x=data(index:index+lag -1,1:end);
    trainX(:,k)=x(:);
    trainY(k)=data(index+(lag+horizon-1),end);
    index=index+1;
end

startTest=endPoint+1-(lag+horizon-1);
index=startTest;
%testSize=size(data,1)-startTest+1-(lag+horizon-1);
testSize = size(data,1) - endPoint;

testX = zeros(size(data,2),testSize);
testY=zeros(1,testSize);
for k=1:testSize
    x=data(index:index+lag -1,1:end);
    testX(:,k)=x(:);
    testY(k)=data(index + (lag+horizon-1),end);
    index=index+1;
end
trainX=trainX';
trainY=trainY';
testX=testX';
testY=testY';
end

