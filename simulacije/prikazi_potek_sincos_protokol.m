function prikazi_potek_sincos_protokol(varargin)

if nargin<1
    error('rabis vsaj podatke')
end

if nargin==1
    eks=inputname(1);
    meritev=varargin{1};
    slika=1;
end
if nargin==2
    eks=inputname(1);
    meritev=varargin{1};
    slika=varargin{2};
end
    

%faza
fft_sin = mojfft(meritev.sin);
fft_cos = mojfft(meritev.cos);
tmp_mnk = polyfit(meritev.displacement, fft_sin{2}(:,2)-fft_cos{2}(:,2),1);
faza_m(1) = tmp_mnk(1);
%offset
tmp_mnk = polyfit(meritev.displacement, fft_sin{1}(:,1).*cosd(fft_sin{2}(:,1)),1);
off_m_s(1)=tmp_mnk(1);

tmp_mnk = polyfit(meritev.displacement, fft_cos{1}(:,1).*cosd(fft_cos{2}(:,1)),1);
off_m_c(1)=tmp_mnk(1);
%amplitude
tmp_mnk = polyfit(meritev.displacement, fft_sin{1}(:,2),1);
amp_m_s(1) = tmp_mnk(1);
tmp_mnk = polyfit(meritev.displacement, fft_cos{1}(:,2),1);
amp_m_c(1) = tmp_mnk(1);

f1=figure(slika);
set(f1,'Name',eks);

subplot(2,3,1)
plot(meritev.displacement, fft_sin{2}(:,2)-fft_cos{2}(:,2));
grid on
title('faza')

subplot(2,3,3)
plot(meritev.displacement,fft_sin{1}(:,2),meritev.displacement,fft_cos{1}(:,2) )
title('amps')
legend('sin','cos')
grid on

subplot(2,3,2)
plot(meritev.displacement, fft_sin{1}(:,1).*cosd(fft_sin{2}(:,1)),meritev.displacement, fft_cos{1}(:,1).*cosd(fft_cos{2}(:,1)))
title('sin cos offset')
legend('sin','cos')
hold off
grid on

fft_prot=mojfft(meritev.protocol);

subplot(2,3,4)
plot(meritev.displacement, fft_prot{1}(:,1).*cosd(fft_prot{2}(:,1)));
grid on
title('mean protocol')

subplot(2,3,5)
plot(meritev.displacement, fft_prot{1}(:,2));
grid on
title('1st harm aprotocol amp')

subplot(2,3,6)
plot(meritev.displacement, fft_prot{1}(:,3));
grid on
title('2nd harm aprotocol amp')

end
