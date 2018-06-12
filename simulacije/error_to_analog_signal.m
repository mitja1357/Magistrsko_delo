
theta=linspace(0, 360, 8192);
ampError = 0: 0.01: 1;
for i = 1: length(ampError)
    err = ampError(i)*sind(2*theta);
    kot(i,:) = theta + err;
end
    Sin = sind(kot);
    Cos = cosd(kot);

    fftSin = mojfft(Sin);
    fftCos = mojfft(Cos);
    ampSin = fftSin{1}(:,2);
    ampCos = fftCos{1}(:,2);
        
    offSin = fftSin{1}(:,1);
    offCos = fftCos{1}(:,1);

    fazaSin = fftSin{2}(:,2);
    fazaCos = fftCos{2}(:,2);

    
    
figure(1)
plot(ampError, ampSin, ampError, ampCos)
legend('Sin','Cos')

%%
ampKvocient = (ampSin./ampCos);
ampRazlika = (ampSin -ampCos)*2*pi/360;

clear Sin Cos err i kot


    
    
    