    function out=mojfft(Lincos)
      
            L=length(Lincos);
            T=1/L;      %imam eno periodo
            Fs=1/T;
            n = L;
            dim = (min(size(Lincos))~=1)+1;
            
            if dim==1
                if size(Lincos,2)==L
                    Lincos=Lincos';
                end
                Y=fft(Lincos,n,dim);
                P2 = abs(Y/n);
                phs=angle(fftshift(Y));
              
                P1 = P2(1:n/2+1);
                P1(2:end-1) = 2*P1(2:end-1);
                P1(1)=mean(Lincos);
                phase=[phs(n/2+1:end);-phs(1)];
            else
                Y=fft(Lincos,n,dim);
                P2 = abs(Y/n);
                phs=angle(fftshift(Y,2));
                P1 = P2(:,1:n/2+1);
                P1(:,2:end-1) = 2.*P1(:,2:end-1);
                P1(:,1)=mean(Lincos,2);
                phase=[phs(:,n/2+1:end),phs(:,1)];
                
            end
            
            out{1}=P1;
            out{2}=phase*180/pi;
            
    end