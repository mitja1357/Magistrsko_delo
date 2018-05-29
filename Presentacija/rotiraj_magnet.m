close all
clear


figure



C = [1,0, 0] ;   % center of circle 
R = 2. ;    % Radius of circle 
teta=0:0.01:2*pi ;
x=C(1)+R*cos(teta);
y=C(2)+R*sin(teta) ;
z = C(3)+zeros(size(x)) ;

figure
view(10,30)

for i=0:360
    hold off
    plot3([2*cosd(i),-2*cosd(i)],[2*sind(i),-2*sind(i)],[0,0],'-k','LineWidth',1.3)
    hold on
    text(1.8.*sind(i),-1.8.*cosd(i),0,'S','Rotation',i+45)
    text(-1.8.*sind(i),1.8*cosd(i),0,'N','Rotation',i+30)
patch('YData',y,'XData',x,'ZData',z,'FaceColor',[0.76 0.76 0.76]);

% Create surf
[xc,yc,zc] = cylinder(2,100);
zc(2, :) = -4;
surf(xc,yc,zc,'FaceLighting','none','MarkerFaceColor',[0.76 0.76 0.76],...
    'MarkerEdgeColor',[0.76 0.76 0.76],'LineStyle','none','FaceColor',...
    [0.76 0.76 0.76],'EdgeColor',[0.76 0.76 0.76]);

    text(1.8.*sind(i),-1.8.*cosd(i),0,'S','Rotation',i+45)
    text(-1.8.*sind(i),1.8*cosd(i),0,'N','Rotation',i+30)
    axis equal
    drawnow
    end
    %%

    
    
    