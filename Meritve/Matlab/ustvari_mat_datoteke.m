




cd 'C:\Users\alic\Documents\Magistrsko_delo\Meritve\CSVFiles';
list_datotek=dir('2017_10_02');
cd C:\Users\alic\Documents\Magistrsko_delo\Meritve\Matlab;
imena = struct2cell(list_datotek);
imena= imena(1,:);


for i=3:max(size(imena))
    ime=imena{i};
    
    filename=strcat('C:\Users\alic\Documents\Magistrsko_delo\Meritve\CSVFiles\2017_10_02\',ime);
    
    [kot_ref,kot_RM44,napaka,sinus,cosinus]=uvoz_podatkov(filename);

    t=linspace(0,1,size(kot_ref,1));
    
    cosinus1=cosinus(length(cosinus):-1:1);
    sinus1=sinus(length(sinus):-1:1);
    kot_RM44_1=atan2d(sinus1,cosinus1);
    kot_RM44_1=kot_RM44_1-kot_RM44_1(1);
    kot_RM44_1(kot_RM44_1<0)=kot_RM44_1(kot_RM44_1<0)+360;
    
    ref1=-kot_ref(length(kot_ref):-1:1);
    ref1=ref1-ref1(1);
    ref1=ref1*360;
    ref1(ref1<0)=ref1(ref1<0)+360;
    
    nova_napaka=ref1-kot_RM44_1;
    
    
    [c0,~,~,c,fi] = fourier(t,nova_napaka,8,0);
    
   

    tmp=struct;

    tmp.analog_sinus=sinus1;
    tmp.analog_cosinus=cosinus1;
    tmp.napaka=nova_napaka;
    tmp.fft_napake=[c0,c]/360;
    tmp.fi=fi/360;
    tmp.oddaljenost=str2num(filename(end-7:end-5))*1e-3;% da je oddaljenost v mm

    
    ime_struct= strcat('meritev_',ime(1:7));
    eval(strcat(ime_struct,'=tmp;'));

    save(strcat('C:\Users\alic\Documents\Magistrsko_delo\New folder\',ime_struct),ime_struct);
      
    
end



