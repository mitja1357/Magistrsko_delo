eks='xd';
mer='meritev';

eval(strcat('mer_uporabljena=',mer,'_',eks,';'));
%%

vsi_prot=zeros(size(mer_uporabljena.protocol));

vsi_sin=vsi_prot;
vsi_cos=vsi_prot;
 scrsz = get(0,'ScreenSize');

figure('Position',[1930 scrsz(4)-30-80-710 800 710]);
for i=1:length(mer_uporabljena.displacement)
% i=1;
sinus=mer_uporabljena.sin(i,:);
cosinus=mer_uporabljena.cos(i,:);

fft_sin=fft(sinus);
fft_cos=fft(cosinus);


nov_fft_sin=zeros(size(fft_sin));
nov_fft_cos=zeros(size(fft_cos));

nov_fft_sin(1)= fft_sin(1);
nov_fft_cos(1)= fft_cos(1);


k_har=[1];

nov_fft_sin([k_har+1,length(nov_fft_sin)+1-k_har])=fft_sin([k_har+1,length(nov_fft_sin)+1-k_har]);
nov_fft_cos([k_har+1,length(nov_fft_cos)+1-k_har])=fft_cos([k_har+1,length(nov_fft_cos)+1-k_har]);
popravi_fazo=1;

%%
if sum(k_har==1) && popravi_fazo==1
    %%
    kot_cos=angle(nov_fft_cos(2));
    
    nov_fft_sin(2)=nov_fft_cos(2).*-1j;
    nov_fft_sin(end)= conj(nov_fft_sin(2));
    %%
end

nov_sin=ifft(nov_fft_sin);
nov_cos=ifft(nov_fft_cos);
%%

plot(nov_cos,nov_sin)
hold on
plot(nov_cos(1),nov_sin(1),'*r')
plot([0,nov_cos(1)],[0,nov_sin(1)],'-k')
grid on
grid minor
axis equal

if mod(i,20)==0
plot(nov_cos,nov_sin,'-m','LineWidth',2)
end
nov_kot=atan2d(nov_sin,nov_cos);
nov_prot=nov_kot-mer_uporabljena.ref(i,:);

nov_prot(nov_prot>180)= nov_prot(nov_prot>180)-360;
    nov_prot(nov_prot<-180)= nov_prot(nov_prot<-180)+360;


vsi_cos(i,:)=nov_cos;
vsi_sin(i,:)=nov_sin;
vsi_prot(i,:)=nov_prot(:)';


if i==1
    set_on_this_point=round((find(sinus==max(sinus),1,'first')+find(sinus==max(sinus),1,'last'))/2);
else

    new_max=round((find(sinus==max(sinus),1,'first')+find(sinus==max(sinus),1,'last'))/2);
    if new_max<set_on_this_point
        sinus=[sinus(end-set_on_this_point+new_max:end),sinus(1:end-set_on_this_point+new_max-1)];
        cosinus=[cosinus(end-set_on_this_point+new_max:end),cosinus(1:end-set_on_this_point+new_max-1)];
    else
        sinus=[sinus(1-set_on_this_point+new_max:end),sinus(1:-set_on_this_point+new_max)];
        cosinus=[cosinus(1-set_on_this_point+new_max:end),cosinus(1:-set_on_this_point+new_max)];
    end
end

test_prot(i,:)=atan2d(sinus,cosinus)-mer_uporabljena.ref(i,:);

    
    


%%
end
title(['Lissajous diagram ', mer, '  ', eks])
% figure
% plot(vsi_prot','DisplayName','vsi_prot')
% 
% title(['Protokoli z uporabljenimi analog harmoniki  ', num2str(k_har), mer, '  ', eks])
% 
% 
% 

%%
figure('Position',[810 scrsz(4)-30-80-710 800 710]);

plot(mer_uporabljena.protocol')
grid on
title(['Protokoli ', mer, '  ', eks])
hold on
plot(mer_uporabljena.protocol(5,:),'-k','LineWidth',3)
plot(mer_uporabljena.protocol(10,:),'-m','LineWidth',3)

figure('Position',[2800 scrsz(4)-30-80-710 800 710]);

plot(mer_uporabljena.cos',mer_uporabljena.sin')
grid on
title(['Original Lis ', mer, '  ', eks])
hold on
plot(mer_uporabljena.cos(5,:),mer_uporabljena.sin(5,:),'-k','LineWidth',3)
plot(mer_uporabljena.cos(10,:),mer_uporabljena.sin(10,:),'-m','LineWidth',3)

crtax=[zeros(1,size(mer_uporabljena.cos,1)); mer_uporabljena.cos(:,1)'];
crtax=crtax(:);

crtay=[zeros(1,size(mer_uporabljena.sin,1)); mer_uporabljena.sin(:,1)'];
crtay=crtay(:);

plot(crtax,crtay,'k');
plot(crtax,crtay,'*r');


%%



A=0
for i=1:size(vsi_sin,1)
    A(i)=find(vsi_sin(i,:)==max(vsi_sin(i,:)));
    B(i)=vsi_sin(i,A(i));
end
figure
plot(A,B,'*r')
hold on
plot(vsi_sin')
plot(vsi_cos')
A=0
for i=1:size(vsi_cos,1)
    A(i)=find(vsi_cos(i,:)==max(vsi_cos(i,:)));
    B(i)=vsi_cos(i,A(i));
end
plot(A,B,'*r')

figure
plot(vsi_prot')
grid on

figure
plot(vsi_sin')
hold on
plot(vsi_cos')
grid on
grid minor




