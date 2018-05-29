%% meritev xs
%faza
fft_sin = mojfft(meritev_xs.sin);
fft_cos = mojfft(meritev_xs.cos);
tmp_mnk = polyfit(meritev_xs.displacement, fft_sin{2}(:,2)-fft_cos{2}(:,2),1);
faza_m(1) = tmp_mnk(1);
%offset
tmp_mnk = polyfit(meritev_xs.displacement, fft_sin{1}(:,1).*cosd(fft_sin{2}(:,1)),1);
off_m_s(1)=tmp_mnk(1);

tmp_mnk = polyfit(meritev_xs.displacement, fft_cos{1}(:,1).*cosd(fft_cos{2}(:,1)),1);
off_m_c(1)=tmp_mnk(1);
%amplitude
tmp_mnk = polyfit(meritev_xs.displacement, fft_sin{1}(:,2),1);
amp_m_s(1) = tmp_mnk(1);
tmp_mnk = polyfit(meritev_xs.displacement, fft_cos{1}(:,2),1);
amp_m_c(1) = tmp_mnk(1);

f1=figure(1);
set(f1,'Name','xs');
subplot(2,2,1)
plot(meritev_xs.displacement, fft_sin{2}(:,2)-fft_cos{2}(:,2));
title('faza')
subplot(2,2,2)
plot(meritev_xs.displacement,fft_sin{1}(:,2),meritev_xs.displacement,fft_cos{1}(:,2) )
title('amps')
subplot(2,2,3)
plot(meritev_xs.displacement, fft_sin{1}(:,1).*cosd(fft_sin{2}(:,1)))
title('sin offset')
subplot(2,2,4)
plot(meritev_xs.displacement, fft_cos{1}(:,1).*cosd(fft_cos{2}(:,1)))
title('cos offset')

%% meritev ys
%faza
fft_sin = mojfft(meritev_ys.sin);
fft_cos = mojfft(meritev_ys.cos);
tmp_mnk = polyfit(meritev_ys.displacement, fft_sin{2}(:,2)-fft_cos{2}(:,2),1);
faza_m(2) = tmp_mnk(1);
%offset
tmp_mnk = polyfit(meritev_ys.displacement, fft_sin{1}(:,1).*cosd(fft_sin{2}(:,1)),1);
off_m_s(2)=tmp_mnk(1);

tmp_mnk = polyfit(meritev_ys.displacement, fft_cos{1}(:,1).*cosd(fft_cos{2}(:,1)),1);
off_m_c(2)=tmp_mnk(1);
%amplitude
tmp_mnk = polyfit(meritev_ys.displacement, fft_sin{1}(:,2),1);
amp_m_s(2) = tmp_mnk(1);
tmp_mnk = polyfit(meritev_ys.displacement, fft_cos{1}(:,2),1);
amp_m_c(2) = tmp_mnk(1);

f1=figure(1);
set(f1,'Name','ys');
subplot(2,2,1)
plot(meritev_ys.displacement, fft_sin{2}(:,2)-fft_cos{2}(:,2));
title('faza')
subplot(2,2,2)
plot(meritev_ys.displacement,fft_sin{1}(:,2),meritev_ys.displacement,fft_cos{1}(:,2) )
title('amps')
subplot(2,2,3)
plot(meritev_ys.displacement, fft_sin{1}(:,1).*cosd(fft_sin{2}(:,1)))
title('sin offset')
subplot(2,2,4)
plot(meritev_ys.displacement, fft_cos{1}(:,1).*cosd(fft_cos{2}(:,1)))
title('cos offset')
%% meritev xd
% 
% %faza
% fft_sin = mojfft(meritev_xd.sin);
% fft_cos = mojfft(meritev_xd.cos);
% tmp_mnk = polyfit(meritev_xd.displacement, fft_sin{2}(:,2)-fft_cos{2}(:,2),1);
% faza_m(3) = tmp_mnk(1);
% %offset
% tmp_mnk = polyfit(meritev_xd.displacement, fft_sin{1}(:,1).*cosd(fft_sin{2}(:,1)),1);
% off_m_s(3)=tmp_mnk(1);
% 
% tmp_mnk = polyfit(meritev_xd.displacement, fft_cos{1}(:,1).*cosd(fft_cos{2}(:,1)),1);
% off_m_c(3)=tmp_mnk(1);
% %amplitude
% tmp_mnk = polyfit(meritev_xd.displacement, fft_sin{1}(:,2),1);
% amp_m_s(3) = tmp_mnk(1);
% tmp_mnk = polyfit(meritev_xd.displacement, fft_cos{1}(:,2),1);
% amp_m_c(3) = tmp_mnk(1);
% 
% f1=figure(1);
% set(f1,'Name','xd');
% subplot(2,2,1)
% plot(meritev_xd.displacement, fft_sin{2}(:,2)-fft_cos{2}(:,2));
% title('faza')
% subplot(2,2,2)
% plot(meritev_xd.displacement,fft_sin{1}(:,2),meritev_xd.displacement,fft_cos{1}(:,2) )
% title('amps')
% 
% subplot(2,2,3)
% plot(meritev_xd.displacement, fft_sin{1}(:,1).*cosd(fft_sin{2}(:,1)))
% title('sin offset')
% subplot(2,2,4)
% plot(meritev_xd.displacement, fft_cos{1}(:,1).*cosd(fft_cos{2}(:,1)))
% title('cos offset')


%% real xs
%faza
fft_sin = mojfft(real_xs.sin);
fft_cos = mojfft(real_xs.cos);
tmp_mnk = polyfit(real_xs.displacement, fft_sin{2}(:,2)-fft_cos{2}(:,2),1);
faza_m(1) = tmp_mnk(1);
%offset
tmp_mnk = polyfit(real_xs.displacement, fft_sin{1}(:,1).*cosd(fft_sin{2}(:,1)),1);
off_r_s(1)=tmp_mnk(1);

tmp_mnk = polyfit(real_xs.displacement, fft_cos{1}(:,1).*cosd(fft_cos{2}(:,1)),1);
off_r_c(1)=tmp_mnk(1);
%amplitude
tmp_mnk = polyfit(real_xs.displacement, fft_sin{1}(:,2),1);
amp_r_s(1) = tmp_mnk(1);
tmp_mnk = polyfit(real_xs.displacement, fft_cos{1}(:,2),1);
amp_r_c(1) = tmp_mnk(1);

f1=figure(1);
set(f1,'Name','xs');
subplot(2,2,1)
plot(real_xs.displacement, fft_sin{2}(:,2)-fft_cos{2}(:,2));
title('faza')
subplot(2,2,2)
plot(real_xs.displacement,fft_sin{1}(:,2),real_xs.displacement,fft_cos{1}(:,2) )
title('amps')
subplot(2,2,3)
plot(real_xs.displacement, fft_sin{1}(:,1).*cosd(fft_sin{2}(:,1)))
title('sin offset')
subplot(2,2,4)
plot(real_xs.displacement, fft_cos{1}(:,1).*cosd(fft_cos{2}(:,1)))
title('cos offset')

%% real ys
%faza
fft_sin = mojfft(real_ys.sin);
fft_cos = mojfft(real_ys.cos);
tmp_mnk = polyfit(real_ys.displacement, fft_sin{2}(:,2)-fft_cos{2}(:,2),1);
faza_m(2) = tmp_mnk(1);
%offset
tmp_mnk = polyfit(real_ys.displacement, fft_sin{1}(:,1).*cosd(fft_sin{2}(:,1)),1);
off_r_s(2)=tmp_mnk(1);

tmp_mnk = polyfit(real_ys.displacement, fft_cos{1}(:,1).*cosd(fft_cos{2}(:,1)),1);
off_r_c(2)=tmp_mnk(1);
%amplitude
tmp_mnk = polyfit(real_ys.displacement, fft_sin{1}(:,2),1);
amp_r_s(2) = tmp_mnk(1);
tmp_mnk = polyfit(real_ys.displacement, fft_cos{1}(:,2),1);
amp_r_c(2) = tmp_mnk(1);

f1=figure(1);
set(f1,'Name','ys');
subplot(2,2,1)
plot(real_ys.displacement, fft_sin{2}(:,2)-fft_cos{2}(:,2));
title('faza')
subplot(2,2,2)
plot(real_ys.displacement,fft_sin{1}(:,2),real_ys.displacement,fft_cos{1}(:,2) )
title('amps')
subplot(2,2,3)
plot(real_ys.displacement, fft_sin{1}(:,1).*cosd(fft_sin{2}(:,1)))
title('sin offset')
subplot(2,2,4)
plot(real_ys.displacement, fft_cos{1}(:,1).*cosd(fft_cos{2}(:,1)))
title('cos offset')
%% real xd

%faza
fft_sin = mojfft(real_xd.sin);
fft_cos = mojfft(real_xd.cos);
tmp_mnk = polyfit(real_xd.displacement, fft_sin{2}(:,2)-fft_cos{2}(:,2),1);
faza_m(3) = tmp_mnk(1);
%offset
tmp_mnk = polyfit(real_xd.displacement, fft_sin{1}(:,1).*cosd(fft_sin{2}(:,1)),1);
off_r_s(3)=tmp_mnk(1);

tmp_mnk = polyfit(real_xd.displacement, fft_cos{1}(:,1).*cosd(fft_cos{2}(:,1)),1);
off_r_c(3)=tmp_mnk(1);
%amplitude
tmp_mnk = polyfit(real_xd.displacement, fft_sin{1}(:,2),1);
amp_r_s(3) = tmp_mnk(1);
tmp_mnk = polyfit(real_xd.displacement, fft_cos{1}(:,2),1);
amp_r_c(3) = tmp_mnk(1);

f1=figure(1);
set(f1,'Name','xd');
subplot(2,2,1)
plot(real_xd.displacement, fft_sin{2}(:,2)-fft_cos{2}(:,2));
title('faza')
subplot(2,2,2)
plot(real_xd.displacement,fft_sin{1}(:,2),real_xd.displacement,fft_cos{1}(:,2) )
title('amps')

subplot(2,2,3)
plot(real_xd.displacement, fft_sin{1}(:,1).*cosd(fft_sin{2}(:,1)))
title('sin offset')
subplot(2,2,4)
plot(real_xd.displacement, fft_cos{1}(:,1).*cosd(fft_cos{2}(:,1)))
title('cos offset')

