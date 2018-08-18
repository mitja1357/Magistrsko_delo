clear
currentFolder= pwd;
path = [currentFolder(1:end-10),'simulacije\mat_datoteke\2018_07_19\'];

list=dir(path);
clear currentFolder

rezultati= struct;
for i = 1: length(list)
    if length(strfind(list(i).name,'velik_vijak'))
            %% read csv
            filename=strcat(path,list(i).name);
            matrika=csvread(filename,1,0);
            sinus=matrika(:,8);     %+0.0062 -0.004429770894629;
            cosinus=matrika(:,10);
            kot = atan2d(sinus,cosinus);
            eval(strcat('rezultati.',list(i).name(13:end-4),'.Cos=cosinus;'))
            eval(strcat('rezultati.',list(i).name(13:end-4),'.Sin=sinus;'))
            eval(strcat('rezultati.',list(i).name(13:end-4),'.kot=kot;'))
    end
end

figure(1)
subplot(2,2,1)
plot(rezultati.gor.kot)
title(['GOR ' num2str(mean(rezultati.gor.kot))])
subplot(2,2,2)
plot(rezultati.desno.kot)
title(['DESNO ' num2str(mean(rezultati.desno.kot))])
subplot(2,2,3)
plot(rezultati.levo.kot)
title(['LEVO ' num2str(mean(rezultati.levo.kot))])
subplot(2,2,4)
plot(rezultati.dol.kot)
title(['DOL ' num2str(mean(rezultati.dol.kot))])

