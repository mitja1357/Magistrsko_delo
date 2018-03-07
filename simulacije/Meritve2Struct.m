list=dir('Z:\Home\Magistrsko_delo\simulacije\Simulacije_ekstra\Meritve');

eks={'xs','ys','xd','zs'};


for i=1:4
    ekcentric='xs'%eks{i};
    Sin_all=[];
    Cos_all=[];
    protocol_all=[];
    displace_all=[];
    Ref_all=[];
    RM44_1_all=[];
    RM44_2_all=[];
    ref_all1=[];
    Rm44_all1=[];
    kot_RM44_nem_all=[];
    for j=1:length(list)
        ime=list(j).name;
        if strfind(ime,ekcentric)
            %% read csv
            filename=strcat('Z:\Home\Magistrsko_delo\simulacije\Simulacije_ekstra\Meritve\',ime);
            matrika=csvread(filename,1,0);
            kot_ref=matrika(:,2);
            kot_RM44=matrika(:,4);
            kot_RM44_nem_all=[kot_RM44_nem_all,kot_RM44];
            protocol_nemec=(kot_RM44-kot_ref).*360;
            protocol_nemec(protocol_nemec>90)=protocol_nemec( protocol_nemec>90)-360;
            protocol_nemec(protocol_nemec<-90)=protocol_nemec( protocol_nemec<-90)+360;
            
            
            ref_all1=[ref_all1,kot_ref];
            Rm44_all1=[Rm44_all1,kot_RM44];
            napaka=matrika(:,6);
            sinus=matrika(:,8)*80;
            cosinus=matrika(:,10)*80;
            cosinus1=cosinus(length(cosinus):-1:1);
            sinus1=sinus(length(sinus):-1:1);
            ele=find(sinus1==min(abs(sinus1))|sinus1==-min(abs(sinus1)))
%             sinus1=sinus1([ele:length(sinus1),1:(ele-1)]);
%             cosinus1=cosinus1([ele:length(sinus1),1:(ele-1)]);
           

            kot_RM44_1=atan2d(sinus1,cosinus1);
            kot_RM44_1((find(diff(kot_RM44_1)<-90)+1):end)= kot_RM44_1((find(diff(kot_RM44_1)<-90)+1):end)+360;
    
            
            referr=kot_ref-linspace(0,1,1000)';
            ref1=referr(1000:-1:1)+linspace(0,1,1000)';
            ref1=ref1.*360;
            
            displace=str2num(filename(end-7:end-5))*1e-3;
            
            Sin=sinus1;
            Cos=cosinus1;
            protocol=kot_RM44_1-ref1;
            
            protocol(protocol>180)= protocol(protocol>180)-360;
            protocol(protocol<-180)= protocol(protocol<-180)+360;
            ref1(ref1<-180)=ref1(ref1<-180)+360;
            clear matrika kot_ref kot_RM44 napaka sinus cosinus cosinus1 sinus1
            clear filename referr
            
            Ref_all=[Ref_all;ref1'];
            Sin_all=[Sin_all;Sin'];
            Cos_all=[Cos_all;Cos'];
            protocol_all=[protocol_all;protocol'];
            displace_all=[displace_all;displace];
            RM44_1_all=[RM44_1_all , kot_RM44_1];
            RM44_2_all=[RM44_2_all , protocol_nemec];
            clear Sin Cos protocol displace
            
        end
        clear ime
    end
    clear j
    
    
    [~,SortedIndex]=sort(displace_all);
    
    displace_all(SortedIndex);
    Sin_all(SortedIndex,:);
    Cos_all(SortedIndex,:);
    protocol_all(SortedIndex,:);
    %% fft protocola
    L=length(protocol_all);
    T=1/L;      %imam eno periodo
    Fs=1/T;
    n = 2^nextpow2(L);
    dim = 2;
    Y=fft(protocol_all,n,dim);
    P2 = abs(Y/n);
    P1 = P2(:,1:n/2+1);
    P1(:,2:end-1) = 2*P1(:,2:end-1);
    fft_lin_all=P1;
    fft_lin_all(:,1)=mean(protocol_all,2);
    
    %% save to struct
    tmp=struct;
    tmp.protocol=protocol_all;
    tmp.fft_protocola=fft_lin_all;
    tmp.sin=Sin_all;
    tmp.cos=Cos_all;
    tmp.displacement=displace_all;
    tmp.ref=Ref_all;

    eval(strcat('meritev_',ekcentric,'=tmp;'));
    clear j L T Fs n dim Y P2 P1 tmp  ekcentric SortedIndex SortedArray ref1
    clear protocol_all fft_all Sin_all Cos_all displace_all ans Ref_all fft_lin_all
    
end

clear i list eks