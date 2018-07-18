%clear
theta=linspace(0,360,500);
load('X_tmp.mat')
load('Y_tmp.mat')
load('Zmesh.mat')

    r0=2.4;
    xs=0.1;
    ys=0.3;
    xd=0;
    yd=0;
    
    Hall1=[r0;0];  
    Hall2=[0;r0];
    
    Hall1_dist=[];
    Hall2_dist=[];
    Sindist=[];
    Cosdist=[];
    Sin=[];
    Cos=[];
    st=1;
    ekcentric='xd';
    
    displace=0:50e-3:1000e-3;
    for i=displace
        eval(strcat(ekcentric,'=i;'))
        
        for k=1:length(theta)
            rot_mat=[ cosd(theta(k)), sind(theta(k)) ...
                    ;-sind(theta(k)), cosd(theta(k))];
            
            Hall1_k=rot_mat*(Hall1+[xs;ys])-[xd;yd];           
            Hall2_k=rot_mat*(Hall2+[xs;ys])-[xd;yd]; 
            
            H1x=round(50*(min(abs(Hall1_k(1)-X_tmp))+Hall1_k(1)))/50;
            H1y=round(50*(min(abs(Hall1_k(2)-Y_tmp))+Hall1_k(2)))/50;
            
            H2x=round(50*(min(abs(Hall2_k(1)-X_tmp))+Hall2_k(1)))/50;
            H2y=round(50*(min(abs(Hall2_k(2)-Y_tmp))+Hall2_k(2)))/50;
            
            Sin(k,st)=Zmesh(find(abs(Y_tmp-H2y)<1e-6),find(abs(X_tmp-H2x)<1e-6));      
            Cos(k,st)=Zmesh(find(abs(Y_tmp-H1y)<1e-6),find(abs(X_tmp-H1x)<1e-6));
            
            
            
            Hall1_distx(k,st)=Hall1_k(1);
            Hall1_disty(k,st)=Hall1_k(2);
            Hall2_distx(k,st)=Hall2_k(1);
            Hall2_disty(k,st)=Hall2_k(2);
            
            
          
        end
        st=st+1;   
        
        
        
    end
%    
% figure
%plot(Sin)
%grid on
%grid minor
%    figure
%    mesh(Hall1_distx,Hall1_disty,Cos)
    
    tmpfft=mojfft(Sin');
    ampssin=tmpfft{1};
    tmpfft=mojfft(Cos');
    ampscos=tmpfft{1};
    figure
    plot(ampssin(:,2))
    hold on
    plot(ampscos(:,2))


    