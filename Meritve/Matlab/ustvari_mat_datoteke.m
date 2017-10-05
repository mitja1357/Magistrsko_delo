




cd 'Y:\Alic_Mitja\Magistrsko_delo\Meritve\CSVfiles';
list_datotek=dir('2017_10_02');
cd Y:\Alic_Mitja\Magistrsko_delo\Meritve\Matlab;
imena = struct2cell(list_datotek);
imena= imena(1,:);


for i=3:max(size(imena))
    ime=imena{i};
    
    filename=strcat('2017_10_02\',ime);
    
    [kot_ref,kot_RM44,napaka,sinus,cosinus]=uvoz_podatkov(filename);

    t=linspace(0,1,size(kot_ref,1));

    [c0,~,~,c,fi] = fourier(t,napaka,8,0);

    tmp=struct;

    tmp.analog_sinus=sinus;
    tmp.analog_cosinus=cosinus;
    tmp.napaka=napaka;
    tmp.fft_napake=[c0,c];
    tmp.fi=fi/360;
    tmp.oddaljenost=str2num(filename(end-7:end-5))*1e-3;% da je oddaljenost v mm

    
    ime_struct= strcat('meritev_',ime(1:7));
    eval(strcat(ime_struct,'=tmp;'));

    cd Y:\Alic_Mitja\Magistrsko_delo\Meritve\Matlab\mat_datoteke\;
    save(ime_struct,ime_struct);
    cd Y:\Alic_Mitja\Magistrsko_delo\Meritve\Matlab;
      
    
end



