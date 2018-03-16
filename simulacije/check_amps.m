            ime='test9a.csv';

            path='Y:\Alic_Mitja\Magistrsko_delo\simulacije\mat_datoteke\';
            filename=strcat(path,ime);
            
   
            matrika=csvread(filename,1,0);

            
            cas=clock;
            newname=strcat(num2str(cas(4)),'_',num2str(cas(5)),'_',num2str(cas(6),'%2.0f'));
           % rename(filename,strcat(path,newname,'.csv')
            clear ime path filename cas
            kot_ref=matrika(:,2);
            kot_RM44=matrika(:,4);
            
            sinus=matrika(:,8)*80;
            cosinus=matrika(:,10)*80;
            
            protocol_nemec=(kot_RM44-kot_ref).*360;
            protocol_nemec(protocol_nemec>90)=protocol_nemec( protocol_nemec>90)-360;
            protocol_nemec(protocol_nemec<-90)=protocol_nemec( protocol_nemec<-90)+360;
            clear  kot_RM44 

            cosinus1=cosinus(length(cosinus):-1:1);
            sinus1=sinus(length(sinus):-1:1);
           % clear sinus cosinus
            
      %      referr=kot_ref-linspace(0,1,1000)';
     %       ref1=referr(1000:-1:1)+linspace(0,1,1000)';
    %        ref1=ref1.*360;
    ref1=-kot_ref(length(kot_ref):-1:1)-kot_ref(1)+kot_ref(end);
    ref1=ref1.*360;
  
novi_ref=linspace(0,360,1024);


for i=1:length(novi_ref)
najblizji=min(abs(ref1-novi_ref(i)));

najblizji_element=find(abs(novi_ref(i)+najblizji-ref1)<1e-14);

if length(najblizji_element)==0
  najblizji_element=find(abs(novi_ref(i)-najblizji-ref1)<1e-14);
end

%if ref1-novi_ref(i)>0
%  najblizji_element=length(novi_ref)-1;
 % else
%najblizji_element=find(ref1-novi_ref(i)>0,1);
%end
if najblizji_element==1000
najblizji_element=999;
end



%koef_sin=polyfit(ref1(vzemi),sinus1(vzemi),3);
%koef_cos=polyfit(ref1(vzemi),cosinus1(vzemi),3);

%Sin(i)=koef_sin(1) .*novi_ref(i)^3 +koef_sin(2) .*novi_ref(i)^2 +koef_sin(3) .*novi_ref(i)+koef_sin(4);
%Cos(i)=koef_cos(1) .*novi_ref(i)^3 +koef_cos(2) .*novi_ref(i)^2 +koef_cos(3) .*novi_ref(i)+koef_cos(4);

Sin(i)=sinus1(najblizji_element)+(novi_ref(i)-ref1(najblizji_element)).*(sinus1(najblizji_element+1)-sinus1(najblizji_element))./(ref1(najblizji_element+1)-ref1(najblizji_element));
Cos(i)=cosinus1(najblizji_element)+(novi_ref(i)-ref1(najblizji_element)).*(cosinus1(najblizji_element+1)-cosinus1(najblizji_element))./(ref1(najblizji_element+1)-ref1(najblizji_element));
%sinus1(vzemi);
%Sin(i);
%cosinus1(vzemi);
%Cos(i);
end



ref_star=ref1;
sin_star=sinus1;
cos_star=cosinus1;
sinus1=Sin;
cosinus1=Cos;
ref1=novi_ref;
figure
plot(ref_star, cos_star)
hold on
plot(ref1, cosinus1,'-r')


            kot_RM44_1=atan2d(sinus1,cosinus1);
            kot_RM44_1((find(diff(kot_RM44_1)<-90)+1):end)= kot_RM44_1((find(diff(kot_RM44_1)<-90)+1):end)+360;











  
            protocol=kot_RM44_1(:)-ref1(:);
            %clear kot_ref referr ref1 kot_RM44_1           
            protocol(protocol>180)= protocol(protocol>180)-360;
            protocol(protocol<-180)= protocol(protocol<-180)+360;
                
            ffttmp=mojfft(sinus1);
            harmonik_sin=ffttmp{1};
            kotsin=ffttmp{2}(2);
            ffttmp=mojfft(cosinus1);
            kotcos=ffttmp{2}(2);
            harmonik_cos=ffttmp{1};
           % clear sinus1 cosinus1
            ffttmp=mojfft(protocol);
            harmonik_protocol=ffttmp{1};
            disp(strvcat({['at ',newname],'      Offset          Amp     Kot',...
                strcat('Sin |',num2str(harmonik_sin(1:2)'),' |',num2str(kotsin-kotsin)),...
                strcat('Cos |',num2str(harmonik_cos(1:2)'),'  |',num2str(kotcos-kotsin)),...
                ' '...
                'Offset          1          2           3            4',...
                        num2str(harmonik_protocol(1:5)') }))
          %  plot(protocol_nemec)
           % hold on
            plot(ref1,protocol)
            grid on
          %  legend('Nemec','Alic')
          % mean(protocol_nemec);
            
% 	function amps=mojfft(Lincos)
%             L=length(Lincos);
%             T=1/L;      %imam eno periodo
%             Fs=1/T;
%             n = 2^nextpow2(L);
%             dim = (min(size(Lincos))~=1)+1;
%             Y=fft(Lincos,n,dim);
%             P2 = abs(Y/n);
%             if dim==1
%                 P1 = P2(1:n/2+1);
%                 P1(2:end-1) = 2*P1(2:end-1);
%                 P1(1)=mean(Lincos);
%             else
%                 P1 = P2(:,1:n/2+1);
%                 P1(:,2:end-1) = 2*P1(:,2:end-1);
%                 P1(:,1)=mean(Lincos,2);
%             end
%             amps=P1;
%     end
