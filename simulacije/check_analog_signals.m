            ime='xs_000u.csv';

            path='Z:\Home\Magistrsko_delo\simulacije\Meritve\';
            filename=strcat(path,ime);
            
            matrika=csvread(filename,1,0);
            cas=clock;
            newname=strcat(num2str(cas(4)),'_',num2str(cas(5)),'_',num2str(cas(6),'%2.0f'));
%             movefile(filename,strcat(path,newname,'.csv');
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
            clear sinus cosinus
            kot_RM44_1=atan2d(sinus1,cosinus1);
            kot_RM44_1((find(diff(kot_RM44_1)<-90)+1):end)= kot_RM44_1((find(diff(kot_RM44_1)<-90)+1):end)+360;
    
            
            referr=kot_ref-linspace(0,1,1000)';
            ref1=referr(1000:-1:1)+linspace(0,1,1000)';
            ref1=ref1.*360;          
            protocol=kot_RM44_1-ref1;
            clear kot_ref referr ref1 kot_RM44_1           
            protocol(protocol>180)= protocol(protocol>180)-360;
            protocol(protocol<-180)= protocol(protocol<-180)+360;
                        
            harmonik_sin=mojfft(sinus1);
            harmonik_cos=mojfft(cosinus1);
            clear sinus1 cosinus1
            harmonik_protocol=mojfft(protocol);
            disp(strvcat({['at ',newname],'      Offset          Amp',...
                strcat('Sin |',num2str(harmonik_sin(1:2)')),...
                strcat('Cos |',num2str(harmonik_cos(1:2)')),...
                ' '...
                'Offset          1          2           3            4',...
                        num2str(harmonik_protocol(1:5)') }))
            plot(protocol_nemec)
            hold on
            plot(protocol)
            legend('Nemec','Alic')
           mean(protocol_nemec)
            
% 	function amps=mojfft(Lincos)
%             L=length(Lincos);
%             T=1/L;      %imam eno periodo
%             Fs=1/T;
%             n = 2^nextpow2(L);
%             dim = min(size(Lincos));
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