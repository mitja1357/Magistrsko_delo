podatki = meritev_xs;

fftS = mojfft(podatki.sin);
fftC = mojfft(podatki.cos);

ref = podatki.ref;
nS  = ref.*0;
nC  = ref.*0;

harmoniki = [0:500];


for dis = 1 : length(podatki.displacement)
    
    for i = unique(harmoniki)
        nS(dis,:) = nS(dis,:) + fftS{1}(dis,i+1).*cosd(i.* ref(dis,:)+fftS{2}(dis,i+1));
        nC(dis,:) = nC(dis,:) + fftC{1}(dis,i+1).*cosd(i.* ref(dis,:)+fftC{2}(dis,i+1));
    end
end
Err = atan2d(nS, nC) -ref;
Err(Err>180) = Err(Err>180) -360;
Err(Err<-180) = Err(Err<-180) +360;

fftE = mojfft(Err);


figure(2)
subplot(1,2,2)
plot(podatki.displacement, fftE{1}(:,1),...
    podatki.displacement, fftE{1}(:,2),...
    podatki.displacement, fftE{1}(:,3),...
    podatki.displacement, fftE{1}(:,4),...
    podatki.displacement, fftE{1}(:,5))
legend('0','1','2','3','4')
grid on

subplot(1,2,1)
plot(ref', Err')
grid on
legend(num2str(podatki.displacement.*1000))

clear podatki fftS fftC ref nS nC harmoniki Err fftE dis i
   


    