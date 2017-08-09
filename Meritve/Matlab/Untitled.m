% Mitja ALic 7.8.2017
% funkcija poisce v doloceni mapi csv datoteke s doloceno ekscentricnostjo ki je definirana v imenu csv file
% naredi F vrsto errorja in vpise v array
% izhodni array je sestavljen iz posameznih harmonikov pri razlicnih ekscentricnostih
% Primer:
% folder='2017_08_07';
% eksc='xs';
% st_harmonikov=5;
% [amplitude,ekscentricnost]=izpis_amplitud_posameznih_harmonikov_ekscentricnost(folder,eksc,st_harmonikov);
% ven dobis amplitude kar je 2d array v stolpcih so glede na harmonik
% ekscentricnost pa je meritev pri kateri je bila opravljena meritev ce zelis naredit odvistnost amplitude harmonika od ekscentricnosti napises
% plot(ekscentricnost, amplitude(1,:)) in dobis potek enosmerne komponente

function [amplitude,ekscentricnost]=izpis_amplitud_posameznih_harmonikov_ekscentricnost(folder,eksc,st_harmonikov)

path='Y:\Alic_Mitja\Magistrsko_delo\Meritve\CSVfiles\';


list=dir(strcat(path,folder));

stevec=1;
for i=1:max(size(list))
   ime=list(i).name;
   
  
  
   
   if sum(isletter(ime))
     
      if sum(strfind(ime,eksc)) 
          
         meritve(stevec)=str2num(ime(4:6));
          stevec=stevec+1;  
      end

   end

end

clear i list;

for i=1:stevec-1;
ime=strcat(folder,'\',eksc,'_',num2str(meritve(i),'%03d'),'u.csv');
amps= izpis_harmonikov(ime, st_harmonikov,0);
amplitude(i,:)=amps;
ekscentricnost(i)=meritve(i)*1e-6;
end