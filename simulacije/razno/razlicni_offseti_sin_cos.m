clear
theta = linspace(0,2*pi,8192);



% x = sqrt(2)/2;
x = linspace(-1,1,101);
primer = 2;


Sin = zeros(length(x),length(theta));
Cos = Sin;
theta1 = Sin;
predviden_err = Sin;
dodaj = Sin;
tempSin = ones(1,length(theta));


for i = 1: length(x)
    dodaj(i,:) =x(i).*tempSin;
    theta1(i,:) = theta;
end

if primer == 1
    Sin = sin(theta1)+dodaj;
    Cos = cos(theta1);
    for i = 1:length(x)
        if abs(x(i)) <= 1
                    
            for n =1:60
                predviden_err(i,:) = predviden_err(i,:) +...
                    x(i).^n./n.*sin(n.*theta+n.*pi/2);
            end
        elseif x(i) <= -1
            for n =1:60
                predviden_err(i,:) = predviden_err(i,:) +...
                    (2-abs(x(i)).^-n)./n.*sin(n.*theta-n.*pi/2);
            end
            
        elseif x(i) > 1
            for n =1:150
                predviden_err(i,:) = predviden_err(i,:) +...
                    (2-x(i).^-n)./n.*sin(n.*theta+n.*pi/2);
            end
        end
    end

elseif primer == 2
    Sin = sin(theta1);
    Cos = cos(theta1)+dodaj;
    for i = 1:length(x)
        if abs(x(i)) <= 1
                    
            for n =1:60
                predviden_err(i,:) = predviden_err(i,:) +...
                    x(i).^n./n.*sin(n.*theta+n.*pi);
            end
        elseif x(i) < -1
            for n =1:150
                predviden_err(i,:) = predviden_err(i,:) +...
                    (2-abs(x(i)).^-n)./n.*sin(n.*theta);
            end
            
        elseif x(i) > 1
            for n =1:150
                predviden_err(i,:) = predviden_err(i,:) +...
                    (2-x(i).^-n)./n.*sin(n.*theta+n.*pi);
            end
        end
    end
    
elseif primer == 3
    Sin = sin(theta1)+dodaj;
    Cos = cos(theta1)+dodaj;
    for i = 1:length(x)
        if abs(x(i)) < sqrt(2)/2
                    
            for n =1:150
                predviden_err(i,:) = predviden_err(i,:) +...
                    (sqrt(2)*x(i)).^n./n.*sin(n.*theta+n.*3*pi/4);
            end
        elseif x(i) < -sqrt(2)/2
            for n =1:150
                predviden_err(i,:) = predviden_err(i,:) +...
                    (2-abs(sqrt(2)*x(i)).^-n)./n.*sin(n.*theta-n.*pi/4);
            end
            
        elseif x(i) >= sqrt(2)/2
            for n =1:120
                predviden_err(i,:) = predviden_err(i,:) +...
                    (2-(sqrt(2)*x(i)).^-n)./n.*sin(n.*theta+n.*3*pi/4);
            end
        end
    end


end
    

kot = atan2(Sin,Cos);
clear Sin Cos primer i n
err = kot -theta1;
err(err<-pi) = err(err<-pi)+2*pi;
err(err> pi) = err(err> pi)-2*pi;


figure(2)
subplot(3,1,1)
plot(theta1'*180/pi,err'*180/pi)
grid on


subplot(3,1,2)
plot(theta1'*180/pi,predviden_err'*180/pi)
grid on

subplot(3,1,3)
plot(theta1'*180/pi,err'*180/pi-predviden_err'*180/pi)
grid on

razlikaNapak = err-predviden_err;
fftRazlike = mojfft(razlikaNapak);

fftErr = mojfft(err);
fftPred = mojfft(predviden_err);