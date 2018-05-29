theta=linspace(0,360,1000);
protocol=[];
displace=-0.15:0.01:0.15;
for i= displace 
    
    sine=sind(theta)+i/100;
    cosine=cosd(theta+i.*3/0.15)+i/100;
    
    
    kot=atan2d(sine,cosine);
    
    err=kot-theta;
    err(err>180)= err(err>180)-360;
    err(err<-180)= err(err<-180)+360;
    
    protocol=[protocol;err(:)'];
end


fft_protocol=mojfft(protocol);

%%
figure('Name', 'Ustvarjeni analogni signali')

subplot(2,2,1)
plot(theta, protocol)
title('protokol')
grid on
grid minor
subplot(2,2,2)
plot(displace, fft_protocol{1}(:,1))
title('offset') 
grid on
grid minor
subplot(2,2,3)
plot(displace, fft_protocol{1}(:,2))
title('amp err')
grid on
grid minor
subplot(2,2,4)
plot(displace, fft_protocol{1}(:,3))
title('2nd err')
grid on
grid minor

%%

tmp=zeros(size(fft_p));
element=1;%[1,2];
for i=element
    tmp(i)=fft_p(i);
    tmp(end-i)=fft_p(end-i);
end

filtriran=real(ifft(tmp));

plot(filtriran)

%%
test1=fft_p;
k_harm=10;
test1(1+k_harm:end-k_harm+1)=0;

katere_harmonike=[0,1,5];

test_k=zeros(size(fft_p));
test_k=([katere_harmonike,end+1-katere_harmonike])=fft_p([katere_harmonike,end+1-katere_harmonike]);



test2=ifft(test1);
plot(test2)
hold on
    