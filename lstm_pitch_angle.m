%Time Series Forecasting Using Deep Learning
%forecast time series data using a long short-term memory (LSTM) network.
%To forecast the values of future time steps of a sequence, you can train a sequence-to-sequence regression LSTM network, where the responses are the training sequences with values shifted by one time step. That is, at each time step of the input sequence, the LSTM network learns to predict the value of the next time step.
%To forecast the values of multiple time steps in the future, use the predictAndUpdateState function to predict time steps one at a time and update the network state at each prediction.

Mm=HMD_data{1,1};
M1=Mm(:,2)'*pi/180;%pitch angle
M2=Mm(:,1)'*pi/180;%yaw angle
M=Mm(:,4)';%time stamp

datax=[M(1,1:size(M1,2))];
data=M1;
figure
plot(datax,data)
xlabel("Time instance (sec)")
ylabel("Pitch angle (rad)")
numTimeStepsTrain = floor(0.5*numel(data));

dataTrain = data(1:numTimeStepsTrain+1);
dataTest = data(numTimeStepsTrain+1:end);
mu = mean(dataTrain);
sig = std(dataTrain);

dataTrainStandardized = (dataTrain - mu) / sig;
XTrain = dataTrainStandardized(1:end-1);
YTrain = dataTrainStandardized(2:end);
numFeatures = 1;
numResponses = 1;
numHiddenUnits = 200;

layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits)
    fullyConnectedLayer(numResponses)
    regressionLayer];
options = trainingOptions('adam', ...
    'MaxEpochs',50, ...
    'GradientThreshold',1, ...
    'InitialLearnRate',0.005, ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropPeriod',25, ...
    'LearnRateDropFactor',0.2, ...
    'Verbose',0, ...
    'Plots','training-progress');
net = trainNetwork(XTrain,YTrain,layers,options);
dataTestStandardized = (dataTest - mu) / sig;
XTest = dataTestStandardized(1:end-1);
net = predictAndUpdateState(net,XTrain);
[net,YPred] = predictAndUpdateState(net,YTrain(end));

numTimeStepsTest = numel(XTest);
for i = 2:numTimeStepsTest
    [net,YPred(:,i)] = predictAndUpdateState(net,YPred(:,i-1),'ExecutionEnvironment','cpu');
end
YPred = sig*YPred + mu;
YTest = dataTest(2:end);
%rmse = sqrt(mean((YPred-YTest).^2))



%%Update Network State with Observed Values
net = resetState(net);
net = predictAndUpdateState(net,XTrain);
YPred = [];
numTimeStepsTest = numel(XTest);
for i = 1:numTimeStepsTest
    [net,YPred(:,i)] = predictAndUpdateState(net,XTest(:,i),'ExecutionEnvironment','cpu');
end
YPred = sig*YPred + mu;
rmse = sqrt(mean((YPred-YTest).^2))
figure
subplot(2,1,1)
plot(YTest)
hold on
plot(YPred,'.-')
hold off
legend(["Observed" "Predicted"])
ylabel("Pitch angle (rad)")
title("Forecast with Updates")

subplot(2,1,2)
stem(YPred - YTest)
xlabel("Time instance (sec)")
ylabel("Error")
title("RMSE = " + rmse)

figure
plot(datax(1:size(dataTrain,2)-1),dataTrain(1:end-1))
hold on
idx = numTimeStepsTrain/10:(numTimeStepsTrain+numTimeStepsTest/10);
scale1=datax(1,0.5*(size(datax,2)):end-1);%floor(size(dataTrain,2)/10):0.1:size([data(numTimeStepsTrain) YPred],2)-0.1;
plot(scale1,[data(numTimeStepsTrain) YPred],'.-');
hold off
xlabel("Time instance (sec)")
ylabel("Pitch angle (rad)")
title("Forecast")
legend(["Observed" "Forecast"])



%%%Yaw angle prediction
data=M2;
figure
plot(datax,data)
xlabel("Time instance (sec)")
ylabel("Yaw angle (rad)")
numTimeStepsTrain = floor(0.5*numel(data));

dataTrain = data(1:numTimeStepsTrain+1);
dataTest = data(numTimeStepsTrain+1:end);
mu = mean(dataTrain);
sig = std(dataTrain);

dataTrainStandardized = (dataTrain - mu) / sig;
XTrain = dataTrainStandardized(1:end-1);
YTrain = dataTrainStandardized(2:end);
numFeatures = 1;
numResponses = 1;
numHiddenUnits = 200;

layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits)
    fullyConnectedLayer(numResponses)
    regressionLayer];
options = trainingOptions('adam', ...
    'MaxEpochs',50, ...
    'GradientThreshold',1, ...
    'InitialLearnRate',0.005, ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropPeriod',25, ...
    'LearnRateDropFactor',0.2, ...
    'Verbose',0, ...
    'Plots','training-progress');
net = trainNetwork(XTrain,YTrain,layers,options);
dataTestStandardized = (dataTest - mu) / sig;
XTest = dataTestStandardized(1:end-1);
net = predictAndUpdateState(net,XTrain);
[net,YPred] = predictAndUpdateState(net,YTrain(end));

numTimeStepsTest = numel(XTest);
for i = 2:numTimeStepsTest
    [net,YPred(:,i)] = predictAndUpdateState(net,YPred(:,i-1),'ExecutionEnvironment','cpu');
end
YPred = sig*YPred + mu;
YTest = dataTest(2:end);
%rmse = sqrt(mean((YPred-YTest).^2))



%%Update Network State with Observed Values
net = resetState(net);
net = predictAndUpdateState(net,XTrain);
YPred = [];
numTimeStepsTest = numel(XTest);
for i = 1:numTimeStepsTest
    [net,YPred(:,i)] = predictAndUpdateState(net,XTest(:,i),'ExecutionEnvironment','cpu');
end
YPred = sig*YPred + mu;
rmse = sqrt(mean((YPred-YTest).^2))
figure
subplot(2,1,1)
plot(YTest)
hold on
plot(YPred,'.-')
hold off
legend(["Observed" "Predicted"])
ylabel("Yaw angle (rad)")
title("Forecast with Updates")

subplot(2,1,2)
stem(YPred - YTest)
xlabel("Time instance (sec)")
ylabel("Error")
title("RMSE = " + rmse)

figure
plot(datax(1:size(dataTrain,2)-1),dataTrain(1:end-1))
hold on
idx = numTimeStepsTrain/10:(numTimeStepsTrain+numTimeStepsTest/10);
scale1=datax(1,0.5*(size(datax,2)):end-1);%floor(size(dataTrain,2)/10):0.1:size([data(numTimeStepsTrain) YPred],2)-0.1;
plot(scale1,[data(numTimeStepsTrain) YPred],'.-');
hold off
xlabel("Time instance (sec)")
ylabel("Yaw angle (rad)")
title("Forecast")
legend(["Observed" "Forecast"])