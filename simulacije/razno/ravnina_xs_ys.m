load('X_tmp.mat');
load('Y_tmp.mat');
load('Zmesh.mat');
n = 2048;
theta = linspace(0,360-360/(n),n);

complex_H1=2.4;
complex_H2=2.4.*1j;
kot = 0;
complex_H1=complex_H1.*exp(1j.*kot.*pi/180);
complex_H2=complex_H2.*exp(1j.*kot.*pi/180);
Hall1=[real(complex_H1);imag(complex_H1)]; 
Hall2=[real(complex_H2);imag(complex_H2)];

deltax = linspace(-0.2,0.2,21);
deltay = deltax;

for x = 1: length(deltax)
    for y = 1:length(deltay)
        
        xs = deltax(x);
        ys = deltay(y);
        for k=1:length(theta)
            rot_mat=[ cosd(theta(k)), sind(theta(k)) ...
                    ;-sind(theta(k)), cosd(theta(k))];
            
            Hall1_k=rot_mat*(Hall1+[xs;ys]);           
            Hall2_k=rot_mat*(Hall2+[xs;ys]); 

            H1x=round(50*(min(abs(Hall1_k(1)-X_tmp))+Hall1_k(1)))/50;
            H1y=round(50*(min(abs(Hall1_k(2)-Y_tmp))+Hall1_k(2)))/50;
            
            H2x=round(50*(min(abs(Hall2_k(1)-X_tmp))+Hall2_k(1)))/50;
            H2y=round(50*(min(abs(Hall2_k(2)-Y_tmp))+Hall2_k(2)))/50;

            
            sin1=find(abs(Y_tmp-H2y)<1e-6);
            sin2=find(abs(X_tmp-H2x)<1e-6);
            cos1=find(abs(Y_tmp-H1y)<1e-6);
            cos2=find(abs(X_tmp-H1x)<1e-6);
            Sin(k)=Zmesh(sin1,sin2);     
            Cos(k)=Zmesh(cos1,cos2);
        end
        fftSin = mojfft(Sin);
        fftCos = mojfft(Cos);
        cosA0(x,y) = fftCos{1}(1);
        cosA1(x,y)= fftCos{1}(2);
        cosf1(x,y)= fftCos{2}(2);
        sinA0(x,y)= fftSin{1}(1);
        sinA1(x,y)= fftSin{1}(2);
        sinf1(x,y)= fftSin{2}(2);
    end
end
[X,Y]=meshgrid(deltax,deltay);
%%
figure(1)
mesh(X,Y,cosA0')
xlabel('\Delta x')
ylabel('\Delta y')
zlabel('cosA0')

figure(2)
mesh(X,Y,cosA1')
xlabel('\Delta x')
ylabel('\Delta y')
zlabel('cosA1')

figure(3)
mesh(X,Y,sinA0')
xlabel('\Delta x')
ylabel('\Delta y')
zlabel('sinA0')

figure(4)
mesh(X,Y,sinA1')
xlabel('\Delta x')
ylabel('\Delta y')
zlabel('sinA1')


figure(5)
mesh(X,Y, cosf1')
xlabel('\Delta x')
ylabel('\Delta y')
zlabel('cosf1')

figure(6)
mesh(X,Y,sinf1'+90)
xlabel('\Delta x')
ylabel('\Delta y')
zlabel('sinf1')
