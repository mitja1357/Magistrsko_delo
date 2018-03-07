theta=linspace(0,360,1000);
dodatek=0.1;

Sin=2.4*sind(theta)+dodatek;
Cos=(2.4)*cosd(theta)+dodatek;

kot=atan2d(Sin,Cos);
kot((find(diff(kot)<-90)+1):end)=kot((find(diff(kot)<-90)+1):end)+360;
protokol=kot-theta;
figure
plot(theta,protokol)
disp(strvcat({'meritve napake','mean          peak2peak',...
              num2str([mean(protokol) max(protokol)-min(protokol)])}))
