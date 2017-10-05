% function narisi_grafe_meritve(filename)

filename='Y:\Alic_Mitja\Magistrsko_delo\Meritve\Matlab\mat_datoteke\meritev_xd_000u.mat';

load(filename)

ime_structa=filename(end-18:end-4);

eval(strcat('tmp=',ime_structa,';'));

x=linspace(0,360,1000);

%Sin_cos

figure
plot(x,tmp.analog_sinus)
hold on
plot(x,tmp.analog_cosinus,'r')





%napaka


figure
plot(x,(tmp.napaka-tmp.fft_napake(1))*360)


%fft_napake

figure
bar(0:8,tmp.fft_napake*360)