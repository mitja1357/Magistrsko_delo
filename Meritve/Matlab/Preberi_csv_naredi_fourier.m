
brez_eks='brez_eks.csv';
xs_100u='xs_100u.csv';
xs_200u='xs_200u.csv';




ime='xs_180u.csv';

x=1:20;
aa=zeros(20,9);

for i=x
    
ime=strcat('xs_',num2str(i),'0u.csv');

[ref,kot,error]=uvoz_podatkov(ime);

error=error*360;

[c0,a,b,c,fi] = fourier(1:1000,error,8,0);
tmp= [c0,c];

aa(i,1:9)=tmp;

end




% 
% figure('Name', ime,'numbertitle','off')
% bar(0:8,[c0,c])
% grid on