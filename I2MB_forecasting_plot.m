load('training_iter.mat');

xx=0.05:0.1:0.95;
for i=1:1:size(xx,2)
rpf(i,1)=sum(rmse_pitch_frac(:,i))/9;
end
for i=1:1:size(xx,2)
ryf(i,1)=sum(rmse_yaw_frac(:,i))/9;
end
figure
subplot(1,2,1)
plot(xx*30,rpf,'r-x');
hold all
subplot(1,2,1)
plot(xx*30,ryf,'b:O');
xlabel('Training user data duration (sec)')
ylabel('RMSE')
legend('Pitch','Yaw');
hold all
xx=10:10:100;
for i=1:1:size(xx,2)
rpi(i,1)=sum(rmse_pitch_iter(:,i))/9;
end
for i=1:1:size(xx,2)
ryi(i,1)=sum(rmse_yaw_iter(:,i))/9;
end


subplot(1,2,2)
plot(xx,rpi,'r-x');
hold all
subplot(1,2,2)
plot(xx,ryi,'b:O');
xlabel('Max training epochs (iterations)')
ylabel('RMSE')
legend('Pitch','Yaw');
