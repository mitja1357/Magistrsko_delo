tic

load('X_tmp.mat');
load('Y_tmp.mat');
load('Zmesh.mat');
X_tmp=(round(X_tmp.*50)/50);
Y_tmp=(round(Y_tmp.*50)/50);


eks=['xs';'ys';'xd';'yd'];

for i=1:4
    ekscentricnost=eks(i,:);    % doloci ekscentricnost
    
    for velikost=0:0.025:0.5    % po katerih velikostih
        ustvari_mat_datoteko_real(ekscentricnost, velikost,X_tmp,Y_tmp, Zmesh);
    end
        

end


toc
