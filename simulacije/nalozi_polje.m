for i=1:16
   
    A=num2str(i);
    name=strcat('/home/mitja/Namizje/Matlab/Polje/B_',A,'.mat');
    load(name);
    
end
clear A;
clear i;
clear name;