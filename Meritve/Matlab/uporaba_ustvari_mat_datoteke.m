
eks=['xs';'ys';'xd';'yd'];

for i=1:4
    ekscentricnost=eks(i,:);    % doloci ekscentricnost
    
    for velikost=0:0.025:0.5    % po katerih velikostih
        ustvari_mat_datoteko(ekscentricnost, velikost);
    end
        

end
