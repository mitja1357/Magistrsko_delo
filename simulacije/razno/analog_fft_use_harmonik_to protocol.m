vsi_prot=zeros(size(meritev_xd.protocol));
for i=1:length(meritev_xd.displacement)

sinus=meritev_xd.sin(i,:);
cosinus=meritev_xd.cos(i,:);

fft_sin=fft(sinus);
fft_cos=fft(cosinus);


nov_fft_sin=zeros(size(fft_sin));
nov_fft_cos=zeros(size(fft_cos));

nov_fft_sin(1)= fft_sin(1);
nov_fft_cos(1)= fft_cos(1);


k_har=[1,2 3];

nov_fft_sin([k_har+1,length(nov_fft_sin)+1-k_har])=fft_sin([k_har+1,length(nov_fft_sin)+1-k_har]);
nov_fft_cos([k_har+1,length(nov_fft_cos)+1-k_har])=fft_cos([k_har+1,length(nov_fft_cos)+1-k_har]);
popravi_fazo=1;
if k_har==1 & popravi_fazo==1
    kot_sin=angel(nov_fft_sin(2));
    kot_cos=angel(nov_fft_cos(2));
    
    nov_fft_sin(2)=abs(nov_fft_sin(2)).*exp(1j .*(kot_cos-kot_sin+pi/2));
    nov_fft_sin(end)=abs(nov_fft_sin(2)).*exp(1j .*(kot_cos-kot_sin+pi/2));
end

nov_sin=ifft(nov_fft_sin);
nov_cos=ifft(nov_fft_cos);

nov_kot=atan2d(nov_sin,nov_cos);
nov_prot=nov_kot-meritev_xd.ref(i,:);

nov_prot(nov_prot>180)= nov_prot(nov_prot>180)-360;
    nov_prot(nov_prot<-180)= nov_prot(nov_prot<-180)+360;



vsi_prot(i,:)=nov_prot;
end
figure
plot(vsi_prot','DisplayName','vsi_prot')

title(num2str(k_har))






