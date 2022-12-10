function [ rate_all,rate_qp,rate_tile,qual_all,qual_qp,qual_tile  ] = Plot_qual_Immersive_video_rate_qp( video_index,qp,tile)
%IMMERSIVE_VIDEO_RATE_QP Summary of this function goes here
v = evalin('base', 'video_bitrate_data');
rate_all=v{1,video_index};
rate_qp(1,:)=rate_all(qp,tile,:);
rate_tile(:,:)=rate_all(:,tile,:);
err1=0;
err2=0;
err3=0;
q = evalin('base', 'video_ymse_data');
qual_all=q{1,video_index};
qual_qp(1,:)=rate_all(qp,tile,:);
qual_tile(:,:)=rate_all(:,tile,:);
for i=1:7
    r(i,1)=625000*(5*i)^-2.10;
    r1(i,1)=57500*exp(-0.2*i*5);
    err1=err1+(r1(i,1)-(rate_all(i,40,100)/1000))^2;
end
for i=1:7
    d(i,1)=.000146*(5*i)^2.99;
    d1(8-i,1)=11.2*exp(-.12*5*i);
       err2=err2+(d1(i,1)-(qual_all(i,40,100)))^2;
    %q1(i,1)=10*log10(50/(.000146*((5*i)^2.09)));
end
for i=1:7
%analytical(8-i,1)=10*log10(15*exp(.7*(i)));
analytical(i,1)=10*log10(255/d1(i,1));
err3= err3+((10*log10(255./qual_all(i,40,100)))-analytical(i,1))^2
%analytical(8-i,1)=10*log10(32*exp(.66*(i-0.35)))-1;
%err=err+(q_35(i)-analytical(i))^2;
end

qp=[5 10 15 20 25 30 35];
figure;
subplot(1,3,1)
plot(qp,rate_all(:,10,100)/1000,'--rx');
hold all;
plot(qp,rate_all(:,15,100)/1000,'-go');
plot(qp,rate_all(:,40,100)/1000,':bd');
plot(qp,rate_all(:,60,100)/1000,'-.ks');
%plot(qp,r,'-k+');
plot(qp,r1,'-k+');
legend('Tile 10','Tile 15','Tile 40','Tile 60','R(q): a=57500, b=-0.2');
xlabel('QP');
ylabel('Datarate (kbps)')

subplot(1,3,2)
plot(qp,qual_all(:,10,100),'--rx');
hold all;
plot(qp,qual_all(:,15,100),'-go');
plot(qp,qual_all(:,40,100),':bd');
plot(qp,qual_all(:,60,100),'-.ks');
plot(qp,d1,'-k+');
legend('Tile 10','Tile 15','Tile 40','Tile 60', 'D(q): c=11.2, d=-.12' );
xlabel('QP');
ylabel('Y-MSE, Distortion metric')

subplot(1,3,3)
plot(qp,(10*log10(255./qual_all(:,10,100))),'--rx');
hold all;
plot(qp,(10*log10(255./qual_all(:,15,100))),'-go');
plot(qp,(10*log10(255./qual_all(:,40,100))),':bd');
plot(qp,(10*log10(255./qual_all(:,60,100))),'-.ks');
plot(qp,analytical,'-k+')
legend('Tile 10','Tile 15','Tile 40','Tile 60', 'Q(q)');
xlabel('QP');
ylabel('Quality, Y-PSNR (in dB)')
err1/7
err2/7
err3/7
end

