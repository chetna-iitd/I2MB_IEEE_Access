function [rmse_pitch, rmse_yaw] = I2MB_lstm_pitch_angle(user,program, fraction_train,iter,plot_)
%Time Series Forecasting Using Deep Learning
%forecast time series data using a long short-term memory (LSTM) network.
%To forecast the values of future time steps of a sequence, you can train a sequence-to-sequence regression LSTM network, where the responses are the training sequences with values shifted by one time step. That is, at each time step of the input sequence, the LSTM network learns to predict the value of the next time step.
%To forecast the values of multiple time steps in the future, use the predictAndUpdateState function to predict time steps one at a time and update the network state at each prediction.
%%Execute function as follows:
%[rmse_pitch,rmse_yaw]=I2MB_lstm_pitch_angle(2,1,0.3,50,1)

load('hn.mat');
%value = getenv( HMD_data )
Mm=HMD_data{user,program};
M1=Mm(:,2)'*pi/180;%pitch angle
M2=Mm(:,1)'*pi/180;%yaw angle
M=Mm(:,4)';%time stamp

datax=[M(1,1:size(M1,2))];
data=M1;

%%%%%Plot condition
%if (iter==100 && fraction_train==0.95)
if(plot_==1)
fh0=figure
subplot(1,2,1)
plot(datax,data)
hold all;
xlabel("Time instance (sec)")
ylabel("Pitch angle (rad)")
end
%fraction_train=0.3;
numTimeStepsTrain = floor(fraction_train*numel(data));

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
    'MaxEpochs',iter, ...
    'GradientThreshold',1, ...
    'InitialLearnRate',0.005, ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropPeriod',int16(iter/2), ...
    'LearnRateDropFactor',0.2);% ...);
    %'Verbose',0, ...
    %'Plots','training-progress');
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
rmse_pitch = sqrt(mean((YPred-YTest).^2));

%%%%%%Plot condition
if (plot_==1)
fh1=figure
subplot(3,2,1)
plot(datax(1:size(dataTrain,2)-1),dataTrain(1:end-1))
hold on
idx = numTimeStepsTrain/10:(numTimeStepsTrain+numTimeStepsTest/10);
scale1=datax(1,fraction_train*(size(datax,2)):end-1);%floor(size(dataTrain,2)/10):0.1:size([data(numTimeStepsTrain) YPred],2)-0.1;
plot(scale1,[data(numTimeStepsTrain) YPred],'.-');
%hold off
xlabel("Time instance (sec)")
ylabel("Pitch angle (rad)")
title("(a) User data and Forecast")
legend(["Observed" "Forecast"])

%fh1=figure
subplot(3,2,3)
plot(scale1(1,2:size(YTest,2)+1),YTest)
hold on
plot(scale1(1,2:size(YTest,2)+1),YPred,'.-')
hold off
legend(["Observed" "Predicted"])
xlabel("Time instance (sec)")
ylabel("Pitch angle (rad)")
title("(b) Forecast Prediction")

subplot(3,2,5)
stem(scale1(1,2:size(YTest,2)+1),YPred - YTest)
xlabel("Time instance (sec)")
ylabel("Error")
title("(c) RMSE = " + rmse_pitch)




end



%%%Yaw angle prediction
data=M2;
%%%plot condition
%if (iter==100 && fraction_train==0.95)
if (plot_==1)
figure(fh0)
subplot(1,2,2)
plot(datax,data)
xlabel("Time instance (sec)")
ylabel("Yaw angle (rad)")
end
numTimeStepsTrain = floor(fraction_train*numel(data));

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
    'MaxEpochs',iter, ...
    'GradientThreshold',1, ...
    'InitialLearnRate',0.005, ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropPeriod',int16(iter/2), ...
    'LearnRateDropFactor',0.2);% ...
    %'Verbose',0, ...
    %'Plots','training-progress');
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
YTest = dataTest(1:end-1);
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
%YTest(1)=YPred(1);
size(YTest)
size(YPred)
rmse_yaw = sqrt(mean((YPred-YTest).^2));

%%%plot condition
%if (iter==100 && fraction_train==0.95)
if (plot_==1)


figure(fh1)
subplot(3,2,2)
plot(datax(1:size(dataTrain,2)-1),dataTrain(1:end-1))
hold on
scale1=datax(1,fraction_train*(size(datax,2)):end-1);%floor(size(dataTrain,2)/10):0.1:size([data(numTimeStepsTrain) YPred],2)-0.1;
plot(scale1,[data(numTimeStepsTrain) YPred],'.-');
%hold off
xlabel("Time instance (sec)")
ylabel("Yaw angle (rad)")
title("(d) User data and Forecast")
legend(["Observed" "Forecast"])

%figure(fh1)
subplot(3,2,4)
size(scale1)
size(YPred)
plot(scale1(1,2:size(YTest,2)+1),YTest)
hold on
plot(scale1(1,2:size(YPred,2)+1),YPred,'.-')
hold off
legend(["Observed" "Predicted"])
ylabel("Yaw angle (rad)")
xlabel("Time instance (sec)")
title("(e) Forecast Prediction")

subplot(3,2,6)
stem(scale1(1,2:size(YPred,2)+1),YPred - YTest)
xlabel("Time instance (sec)")
ylabel("Error")
title("(f) RMSE = " + rmse_yaw)
end