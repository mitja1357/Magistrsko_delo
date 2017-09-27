% 27.9.2017 Mitja Alic
% Datoteka ustvari csv file v katere bom nato shranil poddatke iz testne naprave
% dolocis ekscentricnost in v katero mapo naj shrani datoteke
% v for stavku dolocis od kje do kje naj steje in koliksen korak


eks='zs';
path='Y:\Alic_Mitja\Magistrsko_delo\Meritve\CSVfiles\2017_09_27\';
for i=500:50:1000
    if i<100
        stevilka=strcat('0',num2str(i));
    else
        stevilka=num2str(i);
    end
        
        
    filename=strcat(path,eks,'_',stevilka,'u.csv');
    
    csvwrite(filename,0);
end
    

a0=7.535;

A=zeros(i/25,1);

for j=1:i/25
    A(j,1)=a0+j*0.025;
end
A-7.5