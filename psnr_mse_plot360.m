[data_Bell, vid_rate_360, qual_360, mse_360]=tile_rate_psnr_ber();
close all;
plot(qual_360(1,:),'--xr');
hold all;
plot(qual_360(17,:),':og');
plot(qual_360(35,:),':db');
plot(qual_360(50,:),'-.sk');
q_35=qual_360(35,:);
err=0;
for i=1:9
analytical(i,1)=10*log10(550*exp(.52*i));
err=err+(q_35(i)-analytical(i))^2;
end
q_35
analytical
(err/9)^0.5
plot(analytical,'-*');
legend('Tile=1','Tile=17','Tile=35','Tile=50','Analytical: \Gamma=550,\gamma=0.52');
xlabel('QP level (q)');
ylabel('Quality, Q(q)');

figure;
plot(vid_rate_360(1,:),'--xr');
hold all;
plot(vid_rate_360(17,:),':og');
plot(vid_rate_360(35,:),'-db');
plot(vid_rate_360(50,:),'-.sk');
legend('Tile=1','Tile=17','Tile=35','Tile=50');
xlabel('QP level');
ylabel('Data rate (kbps)');