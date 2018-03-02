theta=linspace(0,360,1000);
eks={'xs','ys','xd','yd'};

load('X_tmp.mat');
load('Y_tmp.mat');
load('Zmesh.mat');

for j=1:4
    ekcentric=eks{j};

    r0=2.4;
    xs=0;
    ys=0;
    xd=0;
    yd=0;

    displace=0:25e-3:500e-3;
    RM44_real_all=[];
    Sin_all=[];
    Cos_all=[];
    
    
    Hall1=[r0;0];  
    Hall2=[0;r0];

    for i=displace
        eval(strcat(ekcentric,'=i;'))
        
        for k=1:length(theta)
            rot_mat=[cosd(theta(k)),-sind(theta(k)) ;sind(theta(k)),cosd(theta(k))];
            
            Hall1_k=rot_mat*(Hall1+[xs;ys])-[xd;yd];           
            Hall2_k=rot_mat*(Hall2+[xs;ys])-[xd;yd]; 
            
            H1x=round(50*(min(abs(Hall1_k(1)-X_tmp))+Hall1_k(1)))/50;
            H1y=round(50*(min(abs(Hall1_k(2)-Y_tmp))+Hall1_k(2)))/50;

            H2x=round(50*(min(abs(Hall2_k(1)-X_tmp))+Hall2_k(1)))/50;
            H2y=round(50*(min(abs(Hall2_k(2)-Y_tmp))+Hall2_k(2)))/50;

            Sin(k)=Zmesh(find(abs(X_tmp-H1x)<1e-6),find(abs(Y_tmp-H1y)<1e-6));      
            Cos(k)=Zmesh(find(abs(X_tmp-H2x)<1e-6),find(abs(Y_tmp-H2y)<1e-6));
            
        end
        Sin_all=[Sin_all;Sin];
        Cos_all=[Cos_all;Cos];
        clear k rot_mat H1x H1y H2x H2y Hall1_k Hall2_k
        
        

        RM44_real=atan2d(Sin,Cos);
        RM44_real((find(diff(RM44_real)<-90)+1):end)=RM44_real((find(diff(RM44_real)<-90)+1):end)+360;
        RM44_real_all=[RM44_real_all;RM44_real];
    end
    clear i RM44_real Sin Cos Hall1 Hall2

    protocol_real_all=RM44_real_all-theta;

    L=length(theta);
    T=1/L;      %imam eno periodo
    Fs=1/T;
    n = 2^nextpow2(L);
    dim = 2;
    Y=fft(protocol_real_all,n,dim);
    P2 = abs(Y/n);
    P1 = P2(:,1:n/2+1);
    P1(:,2:end-1) = 2*P1(:,2:end-1);
    fft_real_all=P1;
    fft_real_all(:,1)=mean(protocol_real_all,2);
    tmp=struct;
    tmp.protocol=protocol_real_all;
    tmp.fft_protocola=fft_real_all;
    tmp.sin=Sin_all;
    tmp.cos=Cos_all;
    tmp.displacement=displace;

    eval(strcat('real_',ekcentric,'=tmp;'));

end

clear j L T Fs n dim Y P2 P1 tmp X_tmp Y_tmp Zmesh ekcentric RM44_real_all 
clear protocol_real_all fft_real_all Sin_all Cos_all displace xd xs yd ys theta r0 eks ans r0



