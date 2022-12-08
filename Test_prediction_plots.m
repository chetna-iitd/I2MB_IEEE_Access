close all;
user_inder=1;
program_index=1;
xx=0.05:0.1:0.95;
rmse_yaw_frac=zeros(9,size(xx,2));
rmse_pitch_frac=zeros(9,size(xx,2));
k=1;
for user_index=1:1:3
    for program_index=1:1:3
j=1;
for frac=xx
    close all;
    [rmse_pitch_frac(k,j),rmse_yaw_frac(k,j)]=I2MB_lstm_pitch_angle(user_index,program_index,frac,50);
    j=j+1;
end
k=k+1;
    end
end


xx=10:10:100;
rmse_yaw_iter=zeros(9,size(xx,2));
rmse_pitch_iter=zeros(9,size(xx,2));
k=1;
for user_index=1:1:3
    for program_index=1:1:3
j=1;
for iter=xx
    close all;
    [rmse_pitch_iter(k,j),rmse_yaw_iter(k,j)]=I2MB_lstm_pitch_angle(user_index,program_index,0.5,iter);
    j=j+1;
end
k=k+1;
    end
end
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

    