
currentFolder = pwd;
path = [currentFolder(1:end-10),'simulacije\mat_datoteke\2018_07_20\vse_v_izhodiscu'];
list=dir(path);
st = 1;
for j=1:length(list)
    
    ime=list(j).name;
    if list(j).isdir == 0
    filename=strcat(path,'\',ime);
    matrika=csvread(filename,1,0);
    
    kot_ref=matrika(:,2);
    kot_ref(find(diff(kot_ref)<-0.5)+1:end)= ...
        kot_ref(find(diff(kot_ref)<-0.5)+1:end)+1;

            
            
    sinus=matrika(:,8);     %+0.0062 -0.004429770894629;        
    cosinus=matrika(:,10);  %+0.0091 -0.012764921998902;
    cosinus=cosinus(length(cosinus):-1:1);
    sinus=sinus(length(sinus):-1:1);
    
    frst_ref=kot_ref(1);
    last_ref=kot_ref(end);
    referr=kot_ref-linspace(frst_ref,last_ref,length(kot_ref))';
    ref=referr(1000:-1:1)+linspace(frst_ref,last_ref,length(kot_ref))';
    ref=ref.*360;
    
    Sin(st,:) = sinus;
    Cos(st,:) = cosinus;
    Ref(st,:) = ref;
    st = st +1;
    end

end
%%
clear currentFolder path list ime filename matrika kot_ref sinus...
    cosinus frst_ref last_ref referr ref j st
%%
fftC = mojfft(Cos);
fftS = mojfft(Sin);
fftC{1}=fftC{1};
fftS{1}=fftS{1};
meanS0 = mean(fftS{1}(:,1));
meanC0 = mean(fftC{1}(:,1));
meanS1 = mean(fftS{1}(:,2));
meanC1 = mean(fftC{1}(:,2));

stdvS0 = sqrt(sum((fftS{1}(:,1)-meanS0).^2)/100);
stdvC0 = sqrt(sum((fftC{1}(:,1)-meanC0).^2)/100);
stdvS1 = sqrt(sum((fftS{1}(:,2)-meanS1).^2)/100);
stdvC1 = sqrt(sum((fftC{1}(:,2)-meanC1).^2)/100);

%%

scrsz = get(0,'ScreenSize');

figure('Name', 'Offset','Position', ...
       [10 scrsz(4)-10-80-600 800 600]);
subplot(1,2,1)
hist(fftS{1}(:,1))
grid on
xlabel('Enosmerna komponenta sin')
ylabel('Število meritev')
subplot(1,2,2)
hist(fftC{1}(:,1))
grid on
xlabel('Enosmerna komponenta cos')
ylabel('Število meritev')



figure('Name', 'Amp','Position', ...
       [910 scrsz(4)-10-80-600 800 600]);
subplot(1,2,1)
hist(fftC{1}(:,2))
grid on
xlabel('Amplituda osnovnega harmonika sin')
ylabel('Število meritev')

subplot(1,2,2)
hist(fftS{1}(:,2))
grid on
xlabel('Amplituda osnovnega harmonika cos')
ylabel('Število meritev')

%%
display(strvcat('          S0       C0       S1       C1',...
    ['mean | ', num2str([meanS0,meanC0, meanC1, meanS1],' %.2e')],...
    ['stdv | ', num2str([stdvS0,stdvC0, stdvC1, stdvS1],' %.2e')]))


