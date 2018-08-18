function tex_izpis_potekov_sincos(meritev)
load Rezultati_simulacij.mat
load Rezultati_meritve.mat

%%
eval(strcat('podatki=',meritev,';'))
tx = ['\Delta ',meritev(end-1),'_',meritev(end)];
if strfind(meritev,'merit')
    fftSin = createFit(podatki.ref, podatki.sin);
    fftCos = createFit(podatki.ref, podatki.cos);
else
    fftSin = mojfft(podatki.sin);
    fftCos = mojfft(podatki.cos);
end
yOff = [fftSin{1}(:,1).* cosd(fftSin{2}(:,1)), ...
    fftCos{1}(:,1).* cosd(fftCos{2}(:,1))];

y1st =[fftSin{1}(:,2), fftCos{1}(:,2)];
y1stPh =[fftSin{2}(:,2)+90, fftCos{2}(:,2)];

x = podatki.displacement;


fitSinOff=polyfit(x,yOff(:,1),3);
fitCosOff=polyfit(x,yOff(:,2),3);

fitSinAmp=polyfit(x,y1st(:,1),3);
fitCosAmp=polyfit(x,y1st(:,2),3);

fitSinF=polyfit(x,y1stPh(:,1),3);
fitCosF=polyfit(x,y1stPh(:,2),3);

vsi_koef= [fitSinAmp; fitSinOff; fitSinF; fitCosAmp; fitCosOff; fitCosF];

potence = floor(log10(abs(vsi_koef)));
pop_k = vsi_koef.*10.^-potence;
imesprem = {'&A_{sin} = ', '&Off_{sin} = ','&\delta_{sin} = ', '&A_{cos} = ', '&Off_{cos} = ','&\delta_{cos} = '};
for i = 1:6
    test{i}= imesprem{i};
    for j = 1:4
    test{i}= [test{i},num2str(pop_k(i,j),'%+.2f'),'\cdot 10^{',num2str(potence(i,j),'%1.0f'),'}',tx,'^',num2str(4-j)];
    end
    test{i}= [test{i},'\\'];
    test{i}(strfind(test{i},'.')) = ',';
    test{i}(strfind(test{i},strcat(tx,'^0')):...
        (strfind(test{i},strcat(tx,'^0'))+11)) = '            ';
    if strfind(test{i},'\cdot 10^{0}')
    test{i}(strfind(test{i},'\cdot 10^{0}'):...
        (strfind(test{i},'\cdot 10^{0}')+11)) = '            ';
    end
    if strfind(test{i},'^{1}')
    test{i}(strfind(test{i},'^{1}'):strfind(test{i},'^{1}')+3) = '    ';
    end
end



strvcat(test{1},test{2},test{3},test{4},test{5},test{6})
%%
end