T = readtable('onaxis_rh18.txt');

T1 = table2array(T);
X = T1(:,1);
Y = T1(:,2);
Z = T1(:,3);

%%
Xmesh = [];
Ymesh = [];
Zmesh = [];

for i=0:2000
   Xmesh(i+1,:)=X(i*2001+1:(i+1)*2001);
   Ymesh(i+1,:)=Y(i*2001+1:(i+1)*2001);
   Zmesh(i+1,:)=Z(i*2001+1:(i+1)*2001);
end

X_tmp = Xmesh(1, :);
Y_tmp = transpose(Ymesh(:, 1));
%%
mesh(Xmesh, Ymesh, Zmesh)
xlabel('X/mm')
ylabel('Y/mm')
zlabel('Z/mT')