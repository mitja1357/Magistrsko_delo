% function narisi_grafe_potekov_ekscentricnosti(model,ekscentricnost)

model='meritev';
ekscentricnost='xs';


isci_string=strcat(model,'_',ekscentricnost);

list=dir('C:\Users\alic\Documents\Magistrsko_delo\Za_slike\mat_datoteke');
ime=cell(1);
for i=1:length(list)
    ime{i}=list(i).name;
end
ime=ime';
cell2mat(ime(3:end,1))


test=strfind(ime,isci_string)
test=list(:,1).name;
stevec=1;
clear amplitude oddaljenost
for i=1:max(size(list))
    
    
    
    
    ime=list(i).name;
   
  cd C:\Users\alic\Documents\Magistrsko_delo\Za_slike\mat_datoteke
  if size(ime,2)>6
   
   if ime(1:size(isci_string,2))==isci_string

       
      load(ime);
      
      %oddaljenost(stevec)=str2num(ime(end-7:end-5)).*1e-3;
      eval(strcat('amplitude(stevec,:)=',ime(1:end-3),'fft_napake;'))
       
      
      
      eval(strcat('oddaljenost(stevec)=',ime(1:end-3),'oddaljenost;'))
       
      eval(['clear ',ime(1:end-4)])
       
      stevec=stevec+1;
      
   end
  end
   

end
cd C:\Users\alic\Documents\Magistrsko_delo\Meritve\Matlab
clear i ime list stevec isci_string

figure
plot(oddaljenost,amplitude(:,1)*360)
hold on
plot(oddaljenost,amplitude(:,2)*360,'r')
plot(oddaljenost,amplitude(:,3)*360,'k')
legend('1','2','3')
