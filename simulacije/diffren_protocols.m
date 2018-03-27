%% load data
% load('Rezultati_meritve.mat');
% load('Rezultati_simulacij.mat');

%% define ekscentric
tip='meritev';
eks='ys';



eval(strcat('sinus=mojfft(',tip,'_',eks,'.sin);'))
eval(strcat('cosinus=mojfft(',tip,'_',eks,'.cos);'))
eval(strcat('displace=',tip,'_',eks,'.displacement;'))

%% create protocol
podatki=[];



theta=linspace(0,360,1000);
koliko_harmonikov=500;
kateri=4;
figure
title([tip '  ' eks])
hold on
po_elementih=1:21;%[find(displace==0,1),find(displace>0.099,1),find(displace>0.299,1),find(displace>0.499,1)]+9;
for kateri=po_elementih
potek_sinus=zeros(1,1000);
potek_cosinus=zeros(1,1000);
for i=1:koliko_harmonikov+1
    
potek_sinus=potek_sinus+sinus{1}(kateri,i).*cosd((i-1).*theta+sinus{2}(kateri,i)-cosinus{2}(kateri,i));%+
potek_cosinus=potek_cosinus+cosinus{1}(kateri,i).*cosd((i-1).*theta);%
end

kot=atan2d(potek_sinus,potek_cosinus);
protocol=kot-theta;
protocol(protocol>180)= protocol(protocol>180)-360;
protocol(protocol<-180)= protocol(protocol<-180)+360;

plot(protocol)
grid on
grid minor
podatki=[podatki;mean(protocol) max(protocol,[],2)-min(protocol,[],2)];


end

disp(strvcat({[tip '  ' eks], 'mean    peak2peak' num2str([podatki, +sinus{2}(po_elementih,2)-cosinus{2}(po_elementih,2)])}))




