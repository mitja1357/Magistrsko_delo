% DISKRETNA FOURIERJEVA ANALIZA PERIODIÈNEGA SIGNALA 
%
% Avtor: Denis Sušin
% Datum: 25.5.2016
% Razlièica: 2
% Vir: lasten
% 
% Funkcija opravi Fourier-jevo analizo (razcep v Fourier-jevo vrsto),
% vrne pa amplitudo c in fazo fi posameze višjeharmonske komponente.
% 
% 
% Fourier-jeva vrsta:
% y(t) = a0 + sum(an*cos(n*w*t) + bn*sin(n*w*t)) = c0 + sum(cn*cos(n*w*t + fin))
% 
% 
% Vhodni parametri:
% 1. èas t (tip: število - vektor)
% 2. èasovna funkcija y (tip: število - vektor)
% 3. število višjeharmoskih komponent h (tip: število)
% 4. risi - možnost risanja spektra, èe je število razlièno od 0 (tip: število)
% 
% OPOMBA: Signal mora biti podan znotraj ene periode.
% 
% Izhodni parametri:
% 1. frekvenca osnove harmonske komponente f (tip: število)
% 2. enosmerna komponenta c0 - offset (tip: število)
% 3. amplituda višjih harmonikov c  (tip: število - vektor)
% 4. fazni zamik fi v °(tip: število - vektor)
% 5. harmonsko popaèenje po DIN standardu THD (tip: število)
% 
% PRIMER UPORABE:
% f = inline('3 + 2*sin(t) + 0.2*cos(2*t) + 0.3*cos(3*t+150*pi/180) + 1*cos(4*t+(-100)*pi/180) + 0.08*sin(10*t)','t');   % testni signal
% t = linspace(0,2*pi,72);                                                                                               % enakomerno razmaknjeni diskretni trenutki                                                                                     % x-os
% y = f(t);                                                                                                              % y-os --> vzorèenje testnega signala 
% h = 20;
% risi = 1;
% [c0,a,b,c,fi] = fourier(t,y,h,risi);

%%
function varargout = fourier(t,y,h,risi)

        if (nargin == 3),
            risi = 0;
        end;

% vmesne velièine
T = t(end)-t(1);                                                                            % perioda signala
f = 1/T;                                                                                    % frekvenca signala
w = 2*pi/T;                                                                                 % krožna frekvenca signala
dt = T/(length(t)-1);                                                                       % korak èasa signala


a0 = 0;                                                                                     % zaèetni približek
a = zeros(1,h);
b = zeros(1,h);
%% a0
for i=2:length(y),
    a0 = a0 + 1/T*y(i)*dt;
end;
%% an
for j=1:h,
    for i=2:length(y),
        a(j) = a(j) + 2/T*y(i)*cos(j*w*t(i))*dt;
    end; 
end;
%% bn
for j=1:h,
    for i=2:length(y),
        b(j) = b(j) + 2/T*y(i)*sin(j*w*t(i))*dt;
    end; 
end;
%%
eps = 1e-6;
for i=1:h,
    if (a(i)<eps && a(i)>-eps),                                                             % èe je an ali bn manjši od eps je kar enak 0
        a(i) = 0;                                                                           % èe je an ali bn manjši od eps je kar enak 0   
    elseif (b(i)<eps && b(i)>-eps),                                                         % èe je an ali bn manjši od eps je kar enak 0
        b(i) = 0;                                                                           % èe je an ali bn manjši od eps je kar enak 0
    end;                                                                                    % èe je an ali bn manjši od eps je kar enak 0
end;
%% cn in fin
c0 = a0;
c = sqrt((a.^2)+(b.^2));

for i=1:h,
    %fi(i) = atan(a(i)/b(i))*180/pi;                                                        % za y(t) = cn*sin(n*w*t + fin)
    fi(i) = atan(-b(i)/a(i))*180/pi;                                                        % enacba pride iz adicijskega izreka za y(t) = cn*cos(n*w*t + fin)

%     if (a(i)>0 && b(i)<0),                                                                % za y(t) = cn*sin(n*w*t + fin)
%          fi(i) = fi(i) + 180;                                                             % za y(t) = cn*sin(n*w*t + fin)
%     elseif (a(i)<0 && b(i)<0),                                                            % za y(t) = cn*sin(n*w*t + fin)
%         fi(i) = fi(i) - 180;                                                              % za y(t) = cn*sin(n*w*t + fin)
%     end;
    if (a(i)<0 && b(i)>0),
         fi(i) = fi(i) - 180;      
    elseif (a(i)<0 && b(i)<0),
         fi(i) = fi(i) + 180;
    end;
end;
%% adicijska izreka
    % cos(n*w*t + fin) = cos(n*w*t)*cos (fin) - sin(n*w*t)*sin(fin)
    % sin(n*w*t + fin) = sin(n*w*t)*cos (fin) + cos(n*w*t)*sin(fin)
%% THD po DIN standardu (ni nikoli veèji od 1)
y_ef = sqrt(sum(c.^2));
THD = sqrt(y_ef^2 - c(1)^2)/y_ef;                                                       	% Total harmonic distortion po DIN standardu  
%% izhodi
st_izhodnih_arg = 5;                                                                        % varargout omogoèa veè izhodnih argumentov
varargout = cell(1,st_izhodnih_arg);                                                        % varargout omogoèa veè izhodnih argumentov
varargout{1} = c0;                                                                         	% varargout omogoèa veè izhodnih argumentov
varargout{2} = a;                                                                         	% varargout omogoèa veè izhodnih argumentov
varargout{3} = b;                                                                           % varargout omogoèa veè izhodnih argumentov
varargout{4} = c;                                                                          % varargout omogoèa veè izhodnih argumentov
varargout{5} = fi;                                                                         % varargout omogoèa veè izhodnih argumentov



%% prikaz podatkov
if (risi ~= 0),
	fprintf('\n\n REZULTATI DISKRETNE FOURIER-JEVE TRANSFORMACIJE \n\n')

	fprintf('Osnovna perioda signala: T = %f s \n',T)
	fprintf('Osnovna frekvenca signala: f = %f Hz \n\n',f)

	fprintf('a0 = %f \n\n',a0); 

	for i=1:h,
		fprintf('a%d = %f \n',i,a(i));   
		fprintf('b%d = %f \n\n',i,b(i));
	end;

	for i=1:h,
		fprintf('fi%d = %0.1f°\n',i,fi(i));
	end;

	fprintf('\n');

	fprintf('c0 = %0.4f \n\n',c0);
	for i=1:h,
		fprintf('c%d = %0.4f       fi%d = %0.4f° \n',i,c(i),i,fi(i));
	end;

	fprintf('\n\nTHD = %0.4f\n\n',THD);
end;
%% izris grafov
% if (risi ~= 0),
%     figure;
%     plot(t,y,'.-');
%     hold on;
% 
%     y2 = c0;
%     izrisi_do_harmonika = 1;
%     for i=1:izrisi_do_harmonika,
%         y2 = y2 + c(i)*cos(i*2*pi/T.*t + fi(i)*pi/180);
%     end;
% 
%     plot(t,y2,'r');
%     title('signal')
%     legend('y(t)','Location','Best','c0 + c1*cos(wt + fi1)','Location','Best')
% 
% 
% 
%     zap_harmonik = 1:1:h;
% 
%     figure;
%     bar(zap_harmonik,c)
%     title('amplitudni spekter signala')
%     xlabel('n-ti harmonik')
%     ylabel('amplituda harmonika')
% 
% 
%     figure;
%     bar(zap_harmonik,fi)
%     title('fazni spekter signala')
%     xlabel('n-ti harmonik')
%     ylabel('fazni kot harmonika [ °]')
% end;

if (risi ~= 0),
    figure;
    plot(t,y,'.-');
    hold on;

    y2 = c0;
    izrisi_do_harmonika = 1;
    for i=1:izrisi_do_harmonika,
        y2 = y2 + c(i)*cos(i*2*pi/T.*t + fi(i)*pi/180);
    end;

    plot(t,y2,'r');
    title('signal')
    legend('y(t)','Location','Best','c0 + c1*cos(wt + fi1)','Location','Best')



    zap_harmonik = 1:1:h;

    figure;
    bar(zap_harmonik*f,c)
    title('amplitudni spekter signala')
    xlabel('frekvenca [Hz]')
    ylabel('amplituda harmonika')


    figure;
    bar(zap_harmonik*f,fi)
    title('fazni spekter signala')
    xlabel('frekvenca [Hz]')
    ylabel('fazni kot harmonika [ °]')
end;