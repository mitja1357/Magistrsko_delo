close all
load('X_tmp.mat');
load('Y_tmp.mat');
load('Zmesh.mat');

%%
Xn = X_tmp;
Yn = Y_tmp;
Zn = Zmesh;

h = figure('Color',[1 1 1],'Position',[50,100,800,4000]);
contour(Xn,Yn,Zn,14, 'Linewidth',1.3)
axis off