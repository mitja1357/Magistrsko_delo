clear
n = 8192;
h = 1.5;
theta = linspace(0,360-360/(n),n);
eks={'xs','ys','xd','yd'};

complex_H1=1.5;
complex_H2=1.5.*1j;
xy{1} = zeros(835584,3);
xy{2} = zeros(835584,3);
xy{3} = zeros(835584,3);
xy{4} = zeros(835584,3);
xy{5} = zeros(835584,3);
array_pozicij=[];

for i=1:4
% for i = 3 % za meritve xd kjer je magnet zarotiran
    ekcentric=eks{i};
    xs=0.0;
    ys=0.0;
    xd=0.0;
    yd=0.0;
%     eval(strcat('displace=meritev_',ekcentric,'.displacement.*1e-3 -0.5e-3;'))
    displace=0:1e-2:0.5;
    Hall1=[real(complex_H1);imag(complex_H1)]; 
    Hall2=[real(complex_H2);imag(complex_H2)];
    st = 1;
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
            xy{i}(st, :) = [Hall1_k(1), Hall1_k(2), h];
            xy{i}(st+1, :) = [Hall2_k(1), Hall2_k(2), h];
            st = st +2;
        end
     
        clear k rot_mat H1x H1y H2x H2y Hall1_k Hall2_k H1x2 H1y2 ...
            H2x2 H2y2 Hall1_k2 Hall2_k2   
    end

    clear i RM44_real Sin Cos Hall1 Hall2

    clear theta1

end

    xs=0.0;
    ys=0.0;
    xd=0.0;
    yd=0.0;
    displace=0:1e-2:0.5;
    Hall1=[real(complex_H1);imag(complex_H1)]; 
    Hall2=[real(complex_H2);imag(complex_H2)];
    theta1=[];
    st = 1;
    for j=1:length(displace)
        di=displace(j);
        eval(strcat(ekcentric,'=di;'))
        yd = -sind(32.4)*xd; xd = cosd(32.4)*xd; % meritve so bile          
        for k=1:length(theta)
            rot_mat=[ cosd(theta(k)), sind(theta(k)) ...
                    ;-sind(theta(k)), cosd(theta(k))];

            Hall1_k=rot_mat*(Hall1+[xs;ys])-[xd;yd];           
            Hall2_k=rot_mat*(Hall2+[xs;ys])-[xd;yd]; 
            xy{5}(st, :) = [Hall1_k(1), Hall1_k(2), h];
            xy{5}(st+1, :) = [Hall2_k(1), Hall2_k(2), h];
            st = st +2;
        end

        
        clear k rot_mat H1x H1y H2x H2y Hall1_k Hall2_k H1x2 H1y2 ...
            H2x2 H2y2 Hall1_k2 Hall2_k2   
    end



clear cos1 cos2 sin1 sin2 di complex_H1 complex_H2
clear j L T Fs n dim Y P2 P1 tmp X_tmp Y_tmp Zmesh ekcentric RM44_real_all 
clear protocol_real_all fft_real_all Sin_all Cos_all displace xd xs yd ys 
clear theta r0 eks ans r0 Ref_all n



