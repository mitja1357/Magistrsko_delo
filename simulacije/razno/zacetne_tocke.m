
load('X_tmp.mat');
load('Y_tmp.mat');
load('Zmesh.mat');

X_tmp=-X_tmp;
Y_tmp=-Y_tmp;


r0=2.4;
tocke={[r0;0],[0;r0],[-r0;0],[0;-r0]}
%% izhodisce
xs=0;
ys=0;
xd=0;
yd=0;

eks=[0,0.1,0.2,0.3,0.5];


for j=1:5
    
    xd=eks(j);
    

for i=1:4;
    
    Hall1=tocke{i};
    Hall1_k=((Hall1+[xs;ys])-[xd;yd]);
    H1x=round(50*(min(abs(Hall1_k(1)-X_tmp))+Hall1_k(1)))/50;
    H1y=round(50*(min(abs(Hall1_k(2)-Y_tmp))+Hall1_k(2)))/50;

    sin1=find(abs(Y_tmp-H1y)<1e-6);
    sin2=find(abs(X_tmp-H1x)<1e-6);
    Z(j,i)=Zmesh(sin1,sin2);
    
end

end
%%
[X,Y]=meshgrid(X_tmp);

figure
contour(X,Y,Zmesh)