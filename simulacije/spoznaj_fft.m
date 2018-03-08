   theta=linspace(0,360,1000);
   Lincos=sind(theta)+sind(10.*theta);
   
   
   
   L=length(Lincos);
            T=1/L;      %imam eno periodo
            Fs=1/T;
            n = L;
            dim = (min(size(Lincos))~=1)+1;
            if size(Lincos,2)==L
            Lincos=Lincos';
            end
            Y=fft(Lincos,n,dim);
            P2 = abs(Y/n);
            if dim==1
              
                P1 = P2(1:n/2+1);
                P1(2:end-1) = 2*P1(2:end-1);
                P1(1)=mean(Lincos);
                
            else
                P1 = P2(:,1:n/2+1);
                P1(:,2:end-1) = 2.*P1(:,2:end-1);
                P1(:,1)=mean(Lincos,2);
                
            end
            
            phs=angle(fftshift(Y));
            phase=[phs(n/2+1:end);-phs(1)]*180/pi;
            amps=P1;
            
            out=0;
            for i=0:length(amps)-1
            out=out+amps(i+1).*cosd(i.*theta+phase(i+1));
            end
            plot(theta,out,theta,Lincos);
            