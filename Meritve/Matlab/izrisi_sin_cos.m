function  izrisi_sin_cos(filename,h,slike)

[sinus,cosinus]=uvoz_podatkov(filename);

t=linspace(0,360,size(sinus,1));
t=t';




[c0_sin,~,~,c_sin,fi_sin1]=fourier(t,sinus,h,0);
[c0_cos,~,~,c_cos,fi_cos1]=fourier(t,cosinus,h,0);




if slike
    figure
    plot(sinus)
    hold on
    plot(cosinus,'-r')
    
    
    figure
    bar(0:h,[c0_sin,c_sin;c0_cos,c_cos]');
    legend('sin','cos');
    

    
end



amplitude_sin=[c0_sin,c_sin];
fi_sin=[0,fi_sin1];


amplitude_cos=[c0_cos,c_cos];
fi_cos=[0,fi_cos1];




% amplitude_sin(1)=0;
% amplitude_cos(1)=0;
% amplitude_sin(2)=amplitude_cos(2);

nov_sin=zeros(1000,1);


for i=0:h
    
nov_sin=nov_sin+amplitude_sin(i+1).*sin(i*t/360*2*pi+fi_cos(i+1));

end

%{
figure
plot(nov_sin)
hold on
plot(cosinus,'-r')
%}



kot_novi=atan2(nov_sin,cosinus);
ref=linspace(0,2*pi,1000);
[kot_novi]= poprava_kota(kot_novi,ref);
figure
plot((kot_novi-kot_novi(1)-ref')/2/pi);

end

