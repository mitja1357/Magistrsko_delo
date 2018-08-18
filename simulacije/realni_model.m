% clear
n = 8192;
theta = linspace(0,360-360/(n),n);
eks={'xs','ys','xd','yd'};
%load('Rezultati_meritve');
load('X_tmp.mat');
load('Y_tmp.mat');
load('Zmesh.mat');

%% postavi koordinatni sistem

x=X_tmp;
y=Y_tmp;

X_tmp=x;
Y_tmp=y;
clear x y
complex_H1=2.4;
complex_H2=2.4.*1j;
kot=0;
complex_H1=complex_H1.*exp(1j.*kot.*pi/180);
complex_H2=complex_H2.*exp(1j.*kot.*pi/180);

array_pozicij=[];

for i=1:4
% for i = 3 % za meritve xd kjer je magnet zarotiran
    ekcentric=eks{i};

    r0=2.4;
    xs=0.0;
    ys=0.0;
    xd=0.0;
    yd=0.0;
%     eval(strcat('displace=meritev_',ekcentric,'.displacement.*1e-3 -0.5e-3;'))
    displace=0:1e-2:0.5;
      
    
    RM44_real_all=[];
    Sin_all=[];
    Cos_all=[];
    Ref_all=[];
    
    Hall1=[real(complex_H1);imag(complex_H1)]; 
    Hall2=[real(complex_H2);imag(complex_H2)];
    theta1=[];
    for j=1:length(displace)
        di=displace(j);
        eval(strcat(ekcentric,'=di;'))
%             yd = -sind(32.4)*xd; xd = cosd(32.4)*xd; % meritve so bile
%             narejene pri 32.4 stopinjah zamaknjenem magnetu        
            
        for k=1:length(theta)
            rot_mat=[ cosd(theta(k)), sind(theta(k)) ...
                    ;-sind(theta(k)), cosd(theta(k))];

            Hall1_k=rot_mat*(Hall1+[xs;ys])-[xd;yd];           
            Hall2_k=rot_mat*(Hall2+[xs;ys])-[xd;yd]; 

            H1x=round(50*(min(abs(Hall1_k(1)-X_tmp))+Hall1_k(1)))/50;
            H1y=round(50*(min(abs(Hall1_k(2)-Y_tmp))+Hall1_k(2)))/50;
            
            H2x=round(50*(min(abs(Hall2_k(1)-X_tmp))+Hall2_k(1)))/50;
            H2y=round(50*(min(abs(Hall2_k(2)-Y_tmp))+Hall2_k(2)))/50;
            
                        
            Hall1_k2=rot_mat*(-Hall1+[xs;ys])-[xd;yd];           
            Hall2_k2=rot_mat*(-Hall2+[xs;ys])-[xd;yd]; 

            H1x2=round(50*(min(abs(Hall1_k2(1)-X_tmp))+Hall1_k2(1)))/50;
            H1y2=round(50*(min(abs(Hall1_k2(2)-Y_tmp))+Hall1_k2(2)))/50;
            
            H2x2=round(50*(min(abs(Hall2_k2(1)-X_tmp))+Hall2_k2(1)))/50;
            H2y2=round(50*(min(abs(Hall2_k2(2)-Y_tmp))+Hall2_k2(2)))/50;
            
            sin1=find(abs(Y_tmp-H2y)<1e-6);
            sin2=find(abs(X_tmp-H2x)<1e-6);
            cos1=find(abs(Y_tmp-H1y)<1e-6);
            cos2=find(abs(X_tmp-H1x)<1e-6);
            Sin(k)=Zmesh(sin1,sin2)...
                ;%-Zmesh(find(abs(Y_tmp-H2y2)<1e-6),find(abs(X_tmp-H2x2)<1e-6));      
            Cos(k)=Zmesh(cos1,cos2)...
                ;%-Zmesh(find(abs(Y_tmp-H1y2)<1e-6),find(abs(X_tmp-H1x2)<1e-6));
            array_pozicij(k,j,1,i) = sin1;
            array_pozicij(k,j,2,i) = sin2;
            array_pozicij(k,j,3,i) = cos1;
            array_pozicij(k,j,4,i) = cos2;

        end
        Sin_all=[Sin_all;Sin];
        Cos_all=[Cos_all;Cos];
        
        
        clear k rot_mat H1x H1y H2x H2y Hall1_k Hall2_k H1x2 H1y2 ...
            H2x2 H2y2 Hall1_k2 Hall2_k2 
        
        theta1=[theta1;theta];

        RM44_real=atan2d(Sin,Cos);
        RM44_real((find(diff(RM44_real)<-90)+1):end)=...
            RM44_real((find(diff(RM44_real)<-90)+1):end)+360;
        RM44_real_all=[RM44_real_all;RM44_real];
        Ref_all=[Ref_all; theta];
    end

    clear i RM44_real Sin Cos Hall1 Hall2
    
    
    protocol_real_all=RM44_real_all-theta1;
    clear theta1
%     L=length(theta);
%     T=1/L;      %imam eno periodo
%     Fs=1/T;
%     n = 2^nextpow2(L);
%     dim = 2;
%     Y=fft(protocol_real_all,n,dim);
%     P2 = abs(Y/n);
%     P1 = P2(:,1:n/2+1);
%     P1(:,2:end-1) = 2*P1(:,2:end-1);
%     fft_real_all=P1;
%     fft_real_all(:,1)=mean(protocol_real_all,2);
    
    tmp=struct;
    tmp.protocol=protocol_real_all;
    tmp.sin=Sin_all;
    tmp.cos=Cos_all;
    tmp.displacement=displace';
    tmp.ref=Ref_all;
    
    eval(strcat('real_',ekcentric,'=tmp;'));

end
clear cos1 cos2 sin1 sin2 di complex_H1 complex_H2
clear j L T Fs n dim Y P2 P1 tmp X_tmp Y_tmp Zmesh ekcentric RM44_real_all 
clear protocol_real_all fft_real_all Sin_all Cos_all displace xd xs yd ys 
clear theta r0 eks ans r0 Ref_all n



