clear
n = 1024;
theta = linspace(0,360-360/(n),n);
eks={'xs','ys'};
%load('Rezultati_meritve');
load('X_tmp.mat');
load('Y_tmp.mat');
load('Zmesh.mat');

% postavi koordinatni sistem

complex_H1=2.4;
complex_H2=2.4.*1j;

for kk = 0:10:180


kot=kk;
complex_H1=complex_H1.*exp(1j.*kot.*pi/180);
complex_H2=complex_H2.*exp(1j.*kot.*pi/180);

figure(kk+1)
for i=1:length(eks)
    ekcentric=eks{i};

    r0=2.4;
    xs=0.0;
    ys=0.0;
    xd=0.0;
    yd=0.0;

    displace=-0.5:1e-1:0.5;

    Sin_all=[];
    Cos_all=[];
    Ref_all=[];
    
    Hall1=[real(complex_H1);imag(complex_H1)]; 
    Hall2=[real(complex_H2);imag(complex_H2)];
   
    for j=1:length(displace)
        di=displace(j);
        eval(strcat(ekcentric,'=di;'))
        
            
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
            
            sin1=find(abs(Y_tmp-H2y)<1e-6);
            sin2=find(abs(X_tmp-H2x)<1e-6);
            cos1=find(abs(Y_tmp-H1y)<1e-6);
            cos2=find(abs(X_tmp-H1x)<1e-6);
            Sin(k)=Zmesh(sin1,sin2)...
                ;%-Zmesh(find(abs(Y_tmp-H2y2)<1e-6),find(abs(X_tmp-H2x2)<1e-6));      
            Cos(k)=Zmesh(cos1,cos2)...
                ;%-Zmesh(find(abs(Y_tmp-H1y2)<1e-6),find(abs(X_tmp-H1x2)<1e-6));
        end
        fftSin = mojfft(Sin);
        fftCos = mojfft(Cos);
        
         
        cosA0(j) = fftCos{1}(1);
        cosA1(j)= fftCos{1}(2);
        cosf1(j)= fftCos{2}(2);
%         cosA2(j)= fftCos{1}(3);
%         cosf2(j)= fftCos{2}(3);
%         cosA3(j)= fftCos{1}(4);
%         cosf3(j)= fftCos{2}(4);
        sinA0(j)= fftSin{1}(1);
        sinA1(j)= fftSin{1}(2);
        sinf1(j)= fftSin{2}(2);
%         sinA2(j)= fftSin{1}(3);
%         sinf2(j)= fftSin{2}(3);
%         sinA3(j)= fftSin{1}(4);
%         sinf3(j)= fftSin{2}(4);
        
        clear k rot_mat H1x H1y H2x H2y Hall1_k Hall2_k H1x2 H1y2 ...
            H2x2 H2y2 Hall1_k2 Hall2_k2 

    end
    cosf1(cosf1 > 180) = cosf1(cosf1 > 180) -360;
    cosf1(cosf1 < -180) = cosf1(cosf1 < -180) +360;
    sinf1(sinf1 > 180) = sinf1(sinf1 > 180) -360;
    sinf1(sinf1 < -180) = sinf1(sinf1 < -180) +360;
    if i ==1
        
        subplot(3,2,1)
        plot(displace, cosA0, displace, sinA0)
        grid on
        title('Offset')

        subplot(3,2,3)
        plot(displace, cosA1, displace, sinA1)
        grid on
        title('amp 1st')


        subplot(3,2,5)
        plot(displace, cosf1, displace, sinf1+90)
        grid on
        title('f 1st')
    else

        subplot(3,2,2)
        plot(displace, cosA0, displace, sinA0)
        grid on
        title('Offset')

        subplot(3,2,4)
        plot(displace, cosA1, displace, sinA1)
        grid on
        title('amp 1st')


        subplot(3,2,6)
        plot(displace, cosf1, displace, sinf1+90)
        grid on
        title('f 1st')
    end
    
    clear i RM44_real Sin Cos Hall1 Hall2

end

end