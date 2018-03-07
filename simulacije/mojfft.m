    function amps=mojfft(Lincos)
            L=length(Lincos);
            T=1/L;      %imam eno periodo
            Fs=1/T;
            n = 2^nextpow2(L);
            dim = (min(size(Lincos))~=1)+1;
            Y=fft(Lincos,n,dim);
            P2 = abs(Y/n);
            if dim==1
                P1 = P2(1:n/2+1);
                P1(2:end-1) = 2*P1(2:end-1);
                P1(1)=mean(Lincos);
            else
                P1 = P2(:,1:n/2+1);
                P1(:,2:end-1) = 2*P1(:,2:end-1);
                P1(:,1)=mean(Lincos,2);
            end
            amps=P1;
    end