function autoenc = trainDAE(X, hiddenSize, varargin)
% the DAE is from the matlab neural network toolbox (autoencoder class)
varargin=varargin{1};
varargin=[hiddenSize,varargin];
paramsStruct  = DAE.parseInputArguments(varargin{:});
autonet = DAE.createNetwork(paramsStruct);
autoenc = DAE.train(X, autonet, paramsStruct.UseGPU, paramsStruct.DenoiseLevel);
end
