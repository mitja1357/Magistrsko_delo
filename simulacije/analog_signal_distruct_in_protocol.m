theta=linspace(0,360,1000);

offset_sin=0;
offset_cos=0.1;
faza=-0;
amp_cos=0;

Sin=2.4*sind(theta+faza)+offset_sin;
Cos=(2.4+amp_cos)*cosd(theta)+offset_cos;

kot=atan2d(Sin,Cos);
kot((find(diff(kot)<-90)+1):end)=kot((find(diff(kot)<-90)+1):end)+360;
protokol=kot-theta;
figure
plot(theta,protokol)
grid on
disp(strvcat({'meritve napake','mean          peak2peak',...
              num2str([mean(protokol) max(protokol)-min(protokol)])}))
