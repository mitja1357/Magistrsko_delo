function izdelava_signalov_s_poznanimi_fazami(varargin)

if nargin == 1
    if ~isstruct(varargin{1})
        error('rabis podatke');
    end
elseif nargin == 0
    error('rabis podatke');   
end
mer = varargin{1};


%% podatki 

sin_fft = mojfft(mer.sin);
cos_fft = mojfft(mer.cos);

faza=[-90.*ones(length(mer.displacement),1),zeros(length(mer.displacement),1)];
amp=ones(length(mer.displacement),2);
off=zeros(length(mer.displacement),2);

if nargin == 1
    faza = [sin_fft{2}(:,2),cos_fft{2}(:,2)];
    amp = [sin_fft{1}(:,2),cos_fft{1}(:,2)];
    off = [sin_fft{1}(:,1),cos_fft{1}(:,1)];
else

    for i=1:nargin
        if isstr(varargin{i})
            if strcmp(varargin{i},'faza')
                faza = [sin_fft{2}(:,2),cos_fft{2}(:,2)];
            elseif strcmp(varargin{i},'amp')
                amp = [sin_fft{1}(:,2),cos_fft{1}(:,2)];        
            elseif strcmp(varargin{i},'off')
                off = [sin_fft{1}(:,1),cos_fft{1}(:,1)]./max(max([sin_fft{1}(:,2),cos_fft{1}(:,2)]));
            end
        elseif isnumeric(varargin{i})
            if varargin{i}-1
                samo1slika=0;
            else
                samo1slika=1;
            end
            
        end
    end
end

nicla = find(mer.displacement==0);
if isnumeric(nicla)
    nula = nicla;
else
    nula = 1;
end

theta = linspace(0,360,1000);
sinus = zeros(length(mer.displacement),length(theta));
cosinus = zeros(length(mer.displacement),length(theta));
kot = zeros(length(mer.displacement),length(theta));
ref = zeros(length(mer.displacement),length(theta));
protokol = zeros(length(mer.displacement),length(theta));

for i = 1:length(faza)
sinus(i,:) = amp(i,1).*cosd(theta+faza(i,1))+off(i,1);
cosinus(i,:) = amp(i,2).*cosd(theta+faza(i,2))+off(i,2);
kot(i,:) = atan2d(sinus(i,:),cosinus(i,:));
ref(i,:)=theta;
prot = kot(i,:)-theta;
prot(prot>180) = prot(prot>180)-360;
prot(prot<-180) = prot(prot<-180)+360;
protokol(i,:)=prot;
end


sin_fft=mojfft(sinus);
cos_fft=mojfft(cosinus);
%% slike 

risi1=1;
while (ishandle(risi1) && strcmp(get(risi1, 'type'), 'figure'))
    risi1 = 1+risi1;
end
figure(risi1)
set(risi1,'WindowStyle','docked')



set(risi1,'Name',['sincos ',inputname(1)],'NumberTitle','off')



figure(risi1)
subplot(3,2,3)
plot(mer.displacement,sin_fft{2}(:,2)-cos_fft{2}(:,2))
title('faza')
grid on
subplot(3,2,5)
plot(mer.displacement,mean(protokol')-mean(protokol(nula,:)))
title('mean prot')
grid on

subplot(3,2,1)
plot(mer.displacement,sin_fft{2}(:,2)-sin_fft{2}(1,2)-90)
hold on
plot(mer.displacement,cos_fft{2}(:,2)-cos_fft{2}(1,2),'-r')
hold off
legend('sin','cos')
title('sprememba sin cos faze')
grid on


subplot(3,2,2)
plot(ref',sinus')
title('sinus')
grid on
subplot(3,2,4)
plot(ref',cosinus')
title('cosinus')
grid on
subplot(3,2,6)
plot(ref([1,round(end/2),end],:)',protokol([1,round(end/2),end],:)')
legend('1','mid','end')
grid on


%% fft protokola
if ~samo1slika 
fft_prot = mojfft(protokol);
fft_prot{1}(:,1) = mean(protokol');


fft_prot{1}(:,1) = fft_prot{1}(:,1) - fft_prot{1}(nula,1);

risi2=1;
while (ishandle(risi2) && strcmp(get(risi2, 'type'), 'figure'))
    risi2 = 1+risi2;
end
figure(risi2)
set(risi2,'WindowStyle','docked')
set(risi2,'Name',['protokol ',inputname(1)],'NumberTitle','off')

arr = [1,2,3,4,5,9];
plot(mer.displacement,fft_prot{1}(:,arr))
grid on
legend(num2str(arr'-1))

end
end























