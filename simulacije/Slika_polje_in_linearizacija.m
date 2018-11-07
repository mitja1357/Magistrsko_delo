close all
load('razno\X_tmp_stari.mat');
load('razno\Y_tmp_stari.mat');
load('razno\Zmesh_stari.mat');
ravnina = 1;
gif = 0;
n= 30;
X = X_tmp(1+n:(1001-n));
Y = Y_tmp(1+n:(1001-n));
Z = Zmesh(1+n:(1001-n),1+n:(1001-n));
% reduciraj sliko
vsako = 20;
Xn = [];
Yn = [];
Zij = zeros(size(Z));
for i = 1 : length(X)
    for j = 1 : length(X)
        if (mod(i,vsako)== 0 && mod(j,vsako)== 0)
            Zij(i,j) = 1;
        end
    end
end
for i = 1 : length(X)
    if mod(i,vsako)==0
        Xn =[Xn, X(i)];
        Yn =[Yn, Y(i)];
        
    end
end
Znx= Z(Zij==1);
Zn =[];
for i = 0:length(Yn)-1
   Zn(i+1,:) = Znx(1+i*length(Yn):(1+i)*length(Yn))'; 
end
n = 20;
X = Xn(1+n:(length(Xn)-n));
n = 10;
Y = Yn(1+n:(length(Xn)-n));
Zravn = 26.*X'*ones(size(Y));
% krog
r = 4;
t =  linspace(-130,-50,1000000);
[Xc,Yc,Zc] = cylinder(r,100);

%%
h = figure('Color',[1 1 1],'Position',[50,100,800,4000]);
barva = linspace(0,1,128);
red= 	[zeros(32,1);		zeros(32,1);		linspace(0,1,32)';	ones(32,1)];
green= 	[linspace(0,1,32)';	ones(32,1);		ones(32,1);		linspace(1,0,32)'];
blue= 	[ones(32,1);		linspace(1,0,32)';	zeros(32,1);		zeros(32,1)];
 
cmap = [[red, green, blue];[zeros(128,1),zeros(128,1),zeros(128,1)+barva(:)]];
colormap(cmap)
filename = 'polje_brez_ravnino.gif';
clf
% Create axes
axes1 = axes('Visible','off','Parent',h);
view(axes1,[80 8]);
hold(axes1,'all');
if ravnina
    filename = 'polje_z_ravnino.gif';
     barvapolje_rav1 = 160+127*(Zravn-min(Zravn(:)))/(max(Zravn(:))-min(Zravn(:)));
    surf(Y,X,Zravn,'Parent',axes1,'cdata',...
     round(barvapolje_rav1),'cdatamapping','direct');
end
barvapolje = 1+127*(Zn-min(Zn(:)))/(max(Zn(:))-min(Zn(:)));

% Create polje
surf(Xn,Yn,Zn,'Parent',axes1,'cdatamode',...
    'auto','cdatamapping','scaled');

surf(Xc,Yc,4*Zc-50-4,'FaceColor',...
     [0.5686274766922 0.521568655967712 0.458823531866074],'EdgeColor','none');
% Create ravnina
%%

%%
theta = linspace(0, 2*pi, 100);

text(0,2,-49,'S','FontSize',8);
text(0,-2,-49,'N','FontSize',8);
H=findobj(gca,'Type','text');
 set(H,'Rotation',0); % tilt

% Create magnet
% plot3(r.*cos(100000.*t),r.*sin(100000.*t),t,...
%     'Color',[0.5686274766922 0.521568655967712 0.458823531866074]);
% 
 fill3(cos(theta).*r, sin(theta).*r,-50*ones(size(theta)),...
     [0.5686274766922 0.521568655967712 0.458823531866074]);
% Create crta
plot3([-r,r], [0,0],[-50.01,-50.01],'LineWidth',1,...
    'Color',[0,0,0]);

% Create krog
xx = (t-min(t))/(max(t)-min(t))*360;


xr = r*cosd(xx);
yr = r*sind(xx);
plot3(xr,yr,-50+0.*t,'LineWidth',1,'Color',[0 0 0]);
% axis([-10 10 -10 10 -140 60])

view([75*cosd(-35),75*sind(-35),15])
axis vis3d
%% gif
if gif
    for i = 0:360

        set(h, 'Position',[50,100,800,4000])
        view([75*cosd(i),75*sind(i),20])
        pause(0.1)

    % Capture the plot as an image 

        frame = getframe(h); 
        im = frame2im(frame); 
        [imind,cm] = rgb2ind(im,65536); 
         % this ensures that getframe() returns a consistent size

        %Write to the GIF File 
            if i == 0
                imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
            else
                imwrite(imind,cm,filename,'gif','WriteMode','append');
            end 
    end
end
