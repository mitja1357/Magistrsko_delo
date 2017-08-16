%close all

[sin,cos,ref]=uvoz_podatkov('2017_08_14\sin_cos1.csv');
ref=ref*360;
plot(ref(1:end-1),sin(1:end-1))
hold on
plot(ref(1:end-1),cos(1:end-1),'r')
grid on
legend('B_{H1}','B_{H2}','Location','southeast')
if ref(end)<180
    ref=ref(1:end-1);
	sin=sin(1:end-1);
    cos=cos(1:end-1);
end
st_harmonikov=40;

[sin_c0,sin_a,sin_b,sin_c]=fourier(ref,sin,st_harmonikov,0);
sinus=[sin_c0,sin_c]

[cos_c0,cos_a,cos_b,cos_c]=fourier(ref,cos,st_harmonikov,0);
cosinus=[cos_c0,cos_c]
figure
bar(0:st_harmonikov,[sin_c0,sin_c])

figure
bar(0:st_harmonikov,[cos_c0,cos_c])

theta=ref*pi/180;
kot_merjeni=atan2(cos,sin);
kot_merjeni=poprava_kota(kot_merjeni,theta);

kot=kot_merjeni*180/pi;
error=kot-ref;

[err_c0,err_a,err_b,err_c]=fourier(ref,error,st_harmonikov,0);
figure
plot(error)

real_error=max(error)-min(error)

figure
bar(err_c)



% visokofrekvencni del pomerjenega magnetnega polja
koto=linspace(0,360,1000);
vis_frek_sin=0;
vis_frek_cos=0;
for i=2:(st_harmonikov)
    vis_frek_sin=vis_frek_sin+sin_b(i).*sind(i.*koto)+sin_a(i).*cosd(i.*koto);    
    vis_frek_cos=vis_frek_cos+cos_b(i).*sind(i.*koto)+cos_a(i).*cosd(i.*koto);
    
end

figure
plot(koto,vis_frek_cos)
figure
plot(koto,vis_frek_sin)






% pretvoori polja samo na prvi harmonik in offst

sinosnovni=sin_c0+sin_a(1)*cosd(koto)+sin_b(1)*sind(koto);
cososnovni=cos_c0+cos_a(1)*cosd(koto)+cos_b(1)*sind(koto);
figure
plot(sinosnovni)
hold on
plot(cososnovni)

kot_osnovni=atan2(cososnovni,sinosnovni);

kot_osnovni=poprava_kota(kot_osnovni,koto*pi/180);
kot_osnovni=kot_osnovni*180/pi;
[err_c0,err_a,err_b,err_c]=fourier(koto,kot_osnovni-koto,st_harmonikov,0);
err_c
figure
bar(err_c)
figure
plot(kot_osnovni-koto)

osnovni_error=max(kot_osnovni-koto)-min(kot_osnovni-koto)