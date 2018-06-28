clear
theta = linspace(0,2*pi,8192);

primer = 2;


x = linspace(0,-45,46)*pi/180;



Sin = zeros(length(x),length(theta));
Cos = Sin;
theta1 = Sin;
dodajSin = Sin;
dodajCos = Sin;
tempSin = ones(1,length(theta));

i1 = 1:length(x);
harmoniki = 1: 100;
PredErr = x'/2*ones(size(theta));




for i = 1: length(x)
    dodajSin(i,:) =sin(x(i)).*tempSin;
    dodajCos(i,:) =cos(x(i)).*tempSin;
    theta1(i,:) = theta;
end
if primer == 1
    Sin = dodajCos.*sin(theta1)+dodajSin.*cos(theta1);
    Cos = cos(theta1);
    for i = i1
        for n = harmoniki
            PredErr(i,:) = PredErr(i,:)+ ...
                (tan(x(i)/2)).^n/n.*sin(2*n*theta+(n)*pi/2+n*x(i));
        end
    end
elseif primer == 2
    Sin = sin(theta1);
    Cos = dodajCos.*cos(theta1)-dodajSin.*sin(theta1);

    for i = i1
        for n = harmoniki
            PredErr(i,:) = PredErr(i,:)+ ...
                (tan(x(i)/2)).^n/n.*sin(2*n*theta-(n)*pi/2+n*x(i));
        end
    end
end


kot = atan2(Sin,Cos);
clear Sin Cos primer i n
err = kot -theta1;
err(err<-pi) = err(err<-pi)+2*pi;
err(err> pi) = err(err> pi)-2*pi;



figure(1)
subplot(3,1,1)
plot(theta1'.*180/pi,err'.*180/pi)
grid on

subplot(3,1,2)
plot(theta1'.*180/pi,PredErr'.*180/pi)
grid on

subplot(3,1,3)
plot(theta1'.*180/pi,(PredErr'-err').*180/pi)
grid on
fftErr = mojfft(err);
fftPred = mojfft(PredErr);

%%
h2 = fftErr{1, 1}(i1,3);
h2(x<0) = -h2(x<0);
h4 = fftErr{1, 1}(i1,5);
h6 = fftErr{1, 1}(i1,7);
harmoniki1 = 2*harmoniki+1;
najvecjiErr = fftErr{1, 1}(end,harmoniki1);