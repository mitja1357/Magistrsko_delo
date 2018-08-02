podatki = meritev_xs;

fftS = mojfft(podatki.sin);
fftC = mojfft(podatki.cos);

ref = podatki.ref;
nS  = ref.*0;
nC  = ref.*0;

har{1}= 1;
har{2}= [0 1];
har{3}= [1 2];
har{4}= [0 1 2];
har{5}= 0:500;
for j = 1: length(har)
    
    harmoniki = har{j};
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


f1 = figure(sum(harmoniki)+length(harmoniki));
set(f1,'Name',['Vsebuje: [',num2str(harmoniki),']'],'NumberTitle','off')

subplot(1,2,2)
plot(podatki.displacement, fftE{1}(:,1).*cosd(fftE{2}(:,1)),...
    podatki.displacement, fftE{1}(:,2),...
    podatki.displacement, fftE{1}(:,3),...
    podatki.displacement, fftE{1}(:,4),...
    podatki.displacement, fftE{1}(:,5))
legend('0','1','2','3','4')
grid on
axis([0,0.5,0,2*2])

subplot(1,2,1)
plot(ref', Err')
grid on
legend(num2str(podatki.displacement.*1000))
axis([0,360,-2*2, 2*4])



end
clear podatki fftS fftC ref nS nC harmoniki Err fftE dis i j har
   


    