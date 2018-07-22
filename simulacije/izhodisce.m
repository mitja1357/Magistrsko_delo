clear
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

figure(1)

subplot(1,4,1)
hist(fftC{1}(1,:))

subplot(1,4,2)
hist(fftS{1}(1,:))

subplot(1,4,3)
hist(fftC{1}(2,:))

subplot(1,4,4)
hist(fftS{1}(2,:))

