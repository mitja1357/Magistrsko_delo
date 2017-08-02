function varargout=uvoz_podatkov(ime)
% Mitja Alic 2.8.2017
% funkcija prebere csv file iz mape CSVfiles za magistrsko mitje alica
% in vsako spremenljivko shrani v posamezen array
% ce imas shranjene v csv referencni kot, kot RM44 in pogresek jih dobis v
% vrstnem redu [error, kotRM44, ref]
% ce imas v file-u sin in cos podatke dobis v vrstnem redu [sin cos] 



Path='Y:\Alic_Mitja\Magistrsko_delo\Meritve\CSVfiles\';


filename=strcat(Path,ime);




matrika=csvread(filename,1,0);


stevilo_stolpcev=size(matrika,2);
st_izhodov=round(stevilo_stolpcev/2);


varargout = cell(1,st_izhodov);



i=2;
stevec=1;

while i<stevilo_stolpcev
    varargout{stevec}=matrika(:,i);
    i=i+2;
    stevec=stevec+1;
end
    