function  varargout=izrisi_sin_cos(filename,h,slike)

[sinus,cosinus]=uvoz_podatkov(filename);

t=linspace(0,360,size(sinus,1));
t=t';




[~,~,~,c_sin,fi_sin]=fourier(t,sinus,h,0);
[~,~,~,c_cos,fi_cos]=fourier(t,cosinus,h,0);




if slike
    figure
    plot(sinus)
    hold on
    plot(cosinus,'-r')
    
    
    figure
    bar(1:h,[c_sin;c_cos]');
    legend('sin','cos');
    

    
end






amplituda_prvega=(c_sin(1)+c_cos(1))/2;
c_sin(1)=amplituda_prvega;
c_cos(1)=amplituda_prvega;
nov_sin=zeros(1000,1);
nov_cos=zeros(1000,1);
for i=1:h

nov_sin=nov_sin+c_sin(i).*cosd((1*t)+fi_sin(i));
nov_cos=nov_cos+c_cos(i).*cosd((i*t)+fi_cos(i));
end


% figure
% plot(nov_sin)
% hold on
% plot(sinus,'-r')




kot_novi=atan2(nov_sin,nov_cos);
ref=linspace(0,2*pi,1000);
[kot_novi]= poprava_kota(kot_novi,ref);

kot_merjeni=atan2(sinus,cosinus);
[kot_merjeni]= poprava_kota(kot_merjeni,ref);
figure
plot((kot_merjeni-kot_merjeni(1)-ref')/2/pi);
hold on
plot((kot_novi-kot_novi(1)-ref')/2/pi,'r');
fazni_zamik=fi_cos(1)-fi_sin(1)



varargout=cell(1,2);

varargout{1}=sinus;
varargout{2}=cosinus;


end

