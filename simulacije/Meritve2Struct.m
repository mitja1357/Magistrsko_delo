clear
datum='2018_03_20';
% xs = 8,915
% ys = 9,525
% z=min
% xr= 12,02
% yr=359
% zr=11,855 
currentFolder = pwd;
path = [currentFolder(1:end-10),'Meritve\CSVfiles\',datum,'\'];
if exist(path)==0    
    path = [currentFolder,'\mat_datoteke\',datum,'\'];
    if exist(path)==0 
        error('Vpisal si napa�en datum')
    end
end
list=dir(path);
clear currentFolder
eks={'xs','ys','xd','zs'};


for i=1:4
    ekcentric=eks{i};
    Sin_all=[];
    Cos_all=[];
    protocol_all=[];
    displace_all=[];
    Ref_all=[];
%     RM44_1_all=[];
%     RM44_2_all=[];
%     ref_all1=[];
%     Rm44_all1=[];
%     kot_RM44_nem_all=[];
    for j=1:length(list)
        ime=list(j).name;
        if strfind(ime,ekcentric)
            %% read csv
            filename=strcat(path,ime);
            matrika=csvread(filename,1,0);
            kot_ref=matrika(:,2);
            kot_RM44=matrika(:,4);
           kot_ref(find(diff(kot_ref)<-0.5)+1:end)= ...
               kot_ref(find(diff(kot_ref)<-0.5)+1:end)+1;
%             kot_RM44_nem_all=[kot_RM44_nem_all,kot_RM44];
%             protocol_nemec=(kot_RM44-kot_ref).*360;
%             protocol_nemec(protocol_nemec>90)=protocol_nemec( protocol_nemec>90)-360;
%             protocol_nemec(protocol_nemec<-90)=protocol_nemec( protocol_nemec<-90)+360;
%             
%             
%             ref_all1=[ref_all1,kot_ref];
%             Rm44_all1=[Rm44_all1,kot_RM44];
            napaka=matrika(:,6);
            sinus=matrika(:,8);     %+0.0062 -0.004429770894629;
            cosinus=matrika(:,10);  %+0.0091 -0.012764921998902;
            cosinus1=cosinus(length(cosinus):-1:1);
            sinus1=sinus(length(sinus):-1:1);
            
            
%             sinus1=sinus1([ele:length(sinus1),1:(ele-1)]);
%             cosinus1=cosinus1([ele:length(sinus1),1:(ele-1)]);
           

           kot_RM44_1=atan2d(sinus1,cosinus1);
           kot_RM44_1((find(diff(kot_RM44_1)<-90)+1):end)= kot_RM44_1((find(diff(kot_RM44_1)<-90)+1):end)+360;
            
            frst_ref=kot_ref(1);
            last_ref=kot_ref(end);
            
            referr=kot_ref-linspace(frst_ref,last_ref,length(kot_ref))';
            ref1=referr(1000:-1:1)+linspace(frst_ref,last_ref,length(kot_ref))';
            ref1=ref1.*360;
            
            displace=str2num(filename(end-7:end-5))*1e-3;
            clear frst_ref last_ref
            Sin=sinus1;
            Cos=cosinus1;
            
            ref1(ref1<-180)=ref1(ref1<-180)+360;
            clear matrika kot_ref kot_RM44 napaka sinus cosinus cosinus1 sinus1
            clear filename referr kot_RM44_1
            
            Ref_all=[Ref_all;ref1'];
            Sin_all=[Sin_all;Sin'];
            Cos_all=[Cos_all;Cos'];
            displace_all=[displace_all;displace];
%             RM44_1_all=[RM44_1_all , kot_RM44_1];
%             RM44_2_all=[RM44_2_all , protocol_nemec];
            clear Sin Cos protocol displace
            
        end
        clear ime
    end
    clear j
    
    
    [~,SortedIndex]=sort(displace_all);

    %% save to struct
    tmp=struct;
    
    tmp.sin=Sin_all(SortedIndex,:);
    tmp.cos=Cos_all(SortedIndex,:);
    tmp.displacement=displace_all(SortedIndex);
    tmp.ref=Ref_all(SortedIndex,:);
    if ~isempty(tmp.displacement)
        el1 = find(min(abs(tmp.displacement)) == abs(tmp.displacement));
            
%         tmp.sin= tmp.sin-mean(tmp.sin(1,:));
%         tmp.cos= tmp.cos-mean(tmp.cos(1,:));
%%
        pogoji = (tmp.cos(el1, :)>0).*([diff(tmp.sin(el1, :)),100]>0);
        pog(1)=0;
        a=0.2;
        for i = 2:(length(pogoji))
        pog(i) = (1/(1000*a+1))*pogoji(i-1) + (a/(a+0.001))*pog(i-1);
        end
        kateri=sign(pog-0.5)*1e10-1e10+1;        
        prvi_el = find(min(abs(tmp.sin(el1, :).*kateri))== ...
            abs(tmp.sin(el1, :).*kateri)...
            );
%%
        if (prvi_el-1)>1
            tmp.sin = tmp.sin(:, [prvi_el:1000,(1:prvi_el-1)]);
            tmp.cos = tmp.cos(:, [prvi_el:1000,(1:prvi_el-1)]);
            tmp.ref = tmp.ref(:, [prvi_el:1000,(1:prvi_el-1)]);
            tmp.ref = tmp.ref - tmp.ref(:, 1)*ones(1,length(tmp.ref));
            tmp.ref(tmp.ref<0) = tmp.ref(tmp.ref<0) +360; 
        else
            tmp.sin = tmp.sin;
            tmp.cos = tmp.cos;
            tmp.ref = tmp.ref;
        end
%         tmp.sin = tmp.sin -mean(tmp.sin(1,:));
%         tmp.cos = tmp.cos -mean(tmp.cos(1,:));
        
        tmp.protocol=atan2d(tmp.sin, tmp.cos)-tmp.ref;
        tmp.protocol(tmp.protocol>180)= tmp.protocol(tmp.protocol>180)-360;
        tmp.protocol(tmp.protocol<-180)= tmp.protocol(tmp.protocol<-180)+360;
        
        
        
        eval(strcat('meritev_',ekcentric,'=tmp;'));
    end
    clear j L T Fs n dim Y P2 P1 tmp  ekcentric SortedIndex SortedArray ref1 el1 prvi_el
    clear protocol_all fft_all Sin_all Cos_all displace_all ans Ref_all fft_lin_all
    
end

clear i list eks path datum a kateri pog pogoji