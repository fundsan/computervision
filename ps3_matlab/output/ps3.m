a= dlmread('pts3d-norm.txt');
a(:, 4) = 1;
Asize = size(a,1);
A = zeros(Asize*2,12);
uv = dlmread('pts2d-norm-pic_a.txt');
funkyn = 1;
for n = 1:Asize
    x = a(n,1);
    y = a(n,2);
    z = a(n,3);
    u = uv(n,1);
    v = uv(n,2);
    A(funkyn,:) = [x, y, z, 1, 0, 0, 0, 0, -u*x,-u*y, -u*z, -u];
    A((funkyn+1), :) = [0, 0, 0, 0,x, y, z, 1, -v*x, -v*y, -v*z, -v];
    funkyn = funkyn +2;
end
[U,S,V] = svd(A);
Y = zeros(size(V,1),1);
Y(size(V,1),1) = 1;
m = V*Y;
M = ones(3,4);

M(1,:) = m(1:4);
M(2,:) = m(5:8);
M(3,:) = m(9:12);

cordsW = M*a';
W = ones(size(cordsW));
W(1,:) = cordsW(3,:);
W(2,:) = cordsW(3,:);
W(3,:) = cordsW(3,:);
cords = cordsW./W;
cords = cords(1:2,:)';

residual = sqrt(ssd(cords, uv));


%% b
eightMs = zeros(3,4,10);
eightRes = zeros(10,1);
%k = 8 
for test = 1:10
eightK = randsample(Asize,8);
eighta = a(eightK,:);


eightA = zeros(8*2,12);
eightuv = uv(eightK,:);
funkyn = 1;
for n = 1:8
    x = eighta(n,1);
    y = eighta(n,2);
    z = eighta(n,3);
    u = eightuv(n,1);
    v = eightuv(n,2);
    eightA(funkyn,:) = [x, y, z, 1, 0, 0, 0, 0, -u*x,-u*y, -u*z, -u];
    eightA((funkyn+1), :) = [0, 0, 0, 0,x, y, z, 1, -v*x, -v*y, -v*z, -v];
    funkyn = funkyn +2;
end

[U,S,V] = svd(eightA);
Y = zeros(size(V,1),1);
Y(size(V,1),1) = 1;
m = V*Y;
M = ones(3,4);

M(1,:) = m(1:4);
M(2,:) = m(5:8);
M(3,:) = m(9:12);


i = 1;
notK = 1:Asize;
notK(eightK) = [];
newPoints= randsample(notK, 4)';

cordsW = M*a(newPoints,:)';
W = ones(size(cordsW));
W(1,:) = cordsW(3,:);
W(2,:) = cordsW(3,:);
W(3,:) = cordsW(3,:);
cords = cordsW./W;
cords = cords(1:2,:)';

residual8 = sqrt(ssd(cords, uv(newPoints,:)));
eightMs(:,:,test) = M;
eightRes(test) = residual8;
end
% k = 12
twelveMs = zeros(3,4,10);
twelveRes = zeros(10,1);
for test = 1:10
twelveK = randsample(Asize,12);
twelvea = a(twelveK,:);


twelveA = zeros(12*2,12);
twelveuv = uv(twelveK,:);
funkyn = 1;
for n = 1:12
    x = twelvea(n,1);
    y = twelvea(n,2);
    z = twelvea(n,3);
    u = twelveuv(n,1);
    v = twelveuv(n,2);
    twelveA(funkyn,:) = [x, y, z, 1, 0, 0, 0, 0, -u*x,-u*y, -u*z, -u];
    twelveA((funkyn+1), :) = [0, 0, 0, 0,x, y, z, 1, -v*x, -v*y, -v*z, -v];
    funkyn = funkyn +2;
end

[U,S,V] = svd(twelveA);
Y = zeros(size(V,1),1);
Y(size(V,1),1) = 1;
m = V*Y;
M = ones(3,4);

M(1,:) = m(1:4);
M(2,:) = m(5:8);
M(3,:) = m(9:12);


i = 1;
notK = 1:Asize;
notK(twelveK) = [];
newPoints= randsample(notK, 4)';

cordsW = M*a(newPoints,:)';
W = ones(size(cordsW));
W(1,:) = cordsW(3,:);
W(2,:) = cordsW(3,:);
W(3,:) = cordsW(3,:);
cords = cordsW./W;
cords = cords(1:2,:)';



residual12 = sqrt(ssd(cords, uv(newPoints,:)));
twelveMs(:,:,test) = M;
twelveRes(test) = residual12;
end

% k = 16
sixteenMs = zeros(3,4,10);
sixteenRes = zeros(10,1);
for test = 1:10
sixteenK = randsample(Asize,16);
sixteena = a(sixteenK,:);


sixteenA = zeros(16*2,12);
sixteenuv = uv(sixteenK,:);
funkyn = 1;
for n = 1:12
    x = sixteena(n,1);
    y = sixteena(n,2);
    z = sixteena(n,3);
    u = sixteenuv(n,1);
    v = sixteenuv(n,2);
    sixteenA(funkyn,:) = [x, y, z, 1, 0, 0, 0, 0, -u*x,-u*y, -u*z, -u];
    sixteenA((funkyn+1), :) = [0, 0, 0, 0,x, y, z, 1, -v*x, -v*y, -v*z, -v];
    funkyn = funkyn +2;
end

[U,S,V] = svd(sixteenA);
Y = zeros(size(V,1),1);
Y(size(V,1),1) = 1;
m = V*Y;
M = ones(3,4);

M(1,:) = m(1:4);
M(2,:) = m(5:8);
M(3,:) = m(9:12);


i = 1;
notK = 1:Asize;
notK(sixteenK) = [];
newPoints= randsample(notK, 4)';

cordsW = M*a(newPoints,:)';
W = ones(size(cordsW));
W(1,:) = cordsW(3,:);
W(2,:) = cordsW(3,:);
W(3,:) = cordsW(3,:);
cords = cordsW./W;
cords = cords(1:2,:)';

residual16 = sqrt(ssd(cords, uv(newPoints,:)));
sixteenMs(:,:,test) = M;
sixteenRes(test) = residual16;
end
% find best M
mean8 = mean(eightRes)

mean12 = mean(twelveRes)


mean16 = mean(sixteenRes)

masterMs = zeros(3,4,10,3);
masterMs(:,:,:,1) = eightMs;
masterMs(:,:,:,2) = twelveMs;
masterMs(:,:,:,3) = sixteenMs;

masterRes = zeros(10,3);
masterRes(:,1) = eightRes;
masterRes(:,2) = twelveRes;
masterRes(:,3) = sixteenRes;

[mins, testI]= min(masterRes);

[fMin, KI] = min(mins);
bestM = masterMs(:,:,testI(KI),KI);

%%c 

Q = bestM(1:3,1:3);
m4 = bestM(1:3,4);

C = (-1*Q)\m4;

%%2
%%a
a_points = dlmread('pts2d-pic_a.txt');
b_points =  dlmread('pts2d-pic_b.txt');
img_a = imread('pic_a.jpg');
img_b = imread('pic_b.jpg');
numberPoints = size(a_points,1);
A = zeros(numberPoints, 9);

for n = 1:numberPoints
    au = a_points(n,1);
    av = a_points(n,2);
    
    bu = b_points(n,1);
    bv = b_points(n,2);
    A(n,:) = [(au*bu), (au*bv), au, (av*bu), (av*bv), av, bu, bv, 1];
end

[U D V] = svd(A);
Y = zeros(size(V,1),1);
Y(size(V,1),1) = 1;
f = V*Y;
F = ones(3,3);

F(1,:) = f(1:3);
F(2,:) = f(4:6);
F(3,:) = f(7:9);

[U, D ,V] = svd(F);

D(3,3) = 0; % if you comment this out the epipolar lines are more accurate
F_hat = U * D * V';
a_points(:,3) = 1;
b_points(:,3) = 1;

a_epilines = F_hat * b_points';
b_epilines =  (a_points * F_hat)';

upLx = 1;
upLy= 1;
downLx = 1;
downLy = size(img_a,1);

upRx = size(img_a,2);
upRy= 1;
downRx = size(img_a,2);
downRy = size(img_a,1);
lineL = cross([upLx, upLy,1],[downLx,downLy,1]);
lineR = cross([upRx, upRy,1],[downRx,downRy,1]);

pila = zeros(size(a_points,1),3);
pira = zeros(size(a_points,1),3);

pilb = zeros(size(a_points,1),3);
pirb = zeros(size(a_points,1),3);

for n = 1: size(a_points,1);
    pila(n,:) = cross( a_epilines(:,n)',lineL);
    pira(n,:) = cross(a_epilines(:,n)',lineR);
    
    pilb(n,:) = cross( b_epilines(:,n)',lineL);
    pirb(n, :) = cross( b_epilines(:,n)',lineR);
end
Wal = ones(size(pila));
Wal(:,1) = pila(:,3);
Wal(:,2) = pila(:,3);
Wal(:,3) = pila(:,3);
pila_s = pila./Wal;


War = ones(size(pila));
War(:,1) = pira(:,3);
War(:,2) = pira(:,3);
War(:,3) = pira(:,3);
pira_s = pira./War;


Wbl = ones(size(pila));
Wbl(:,1) = pilb(:,3);
Wbl(:,2) = pilb(:,3);
Wbl(:,3) = pilb(:,3);
pilb_s = pilb./Wbl;


Wbr = ones(size(pila));
Wbr(:,1) = pirb(:,3);
Wbr(:,2) = pirb(:,3);
Wbr(:,3) = pirb(:,3);
pirb_s = (pirb./ Wbr);

figure,imshow(img_a)


hold on

for n = 1:size(pila_s,1)
plot([pila_s(n,1),pira_s(n,1)],[pila_s(n,2),pira_s(n,2)],'Color','r','LineWidth',1)
end
hold off

figure,imshow(img_b)

hold on
for n = 1:size(pilb_s,1)
plot([pilb_s(n,1),pirb_s(n,1)],[pilb_s(n,2),pirb_s(n,2)],'Color','r','LineWidth',1)
end
hold off

%% 2 d and e
acords = a_points(:,1:2);
bcords = b_points(:,1:2);
amean = mean(acords);

stda = 1/std(acords(:)-mean(acords(:)));


samatrix = [stda, 0, 0; 0 ,stda, 0; 0 , 0, 1];
camatrix = [ 1, 0, -amean(1);0, 1, -amean(2); 0, 0 ,1];

newA_points = (samatrix*camatrix*a_points')';


bmean = mean(bcords);


stdb = 1/std(bcords(:)-mean(bcords(:)));

sbmatrix = [stdb 0 0; 0 stdb 0; 0  0 1];
cbmatrix = [ 1, 0, -bmean(1);0, 1, -bmean(2); 0, 0 ,1];
newB_points = (sbmatrix*cbmatrix*b_points')';

A = zeros(numberPoints, 9);

for n = 1:numberPoints
    au = newA_points(n,1);
    av = newA_points(n,2);
    
    bu = newB_points(n,1);
    bv = newB_points(n,2);
    A(n,:) = [(au*bu), (au*bv), au, (av*bu), (av*bv), av, bu, bv, 1];
end


[U D V] = svd(A);
Y = zeros(size(V,1),1);
Y(size(V,1),1) = 1;
f = V*Y;
F = ones(3,3);

F(1,:) = f(1:3);
F(2,:) = f(4:6);
F(3,:) = f(7:9);
[U, Da, V] = svd(F);


Da(3,3) = 0; % if you comment this out the epipolar lines are more accurate
F_hat = U * Da * V';

tb = samatrix*camatrix;
ta = sbmatrix*cbmatrix;

F = (samatrix*camatrix)'*F_hat*(sbmatrix*cbmatrix);

F;

a_epilines = F * b_points';
b_epilines =  (a_points * F)';

upLx = 1;
upLy= 1;
downLx = 1;
downLy = size(img_a,1);

upRx = size(img_a,2);
upRy= 1;
downRx = size(img_a,2);
downRy = size(img_a,1);
lineL = cross([upLx, upLy,1],[downLx,downLy,1]);
lineR = cross([upRx, upRy,1],[downRx,downRy,1]);

pila = zeros(size(a_points,1),3);
pira = zeros(size(a_points,1),3);

pilb = zeros(size(a_points,1),3);
pirb = zeros(size(a_points,1),3);

for n = 1: size(a_points,1);
    pila(n,:) = cross( a_epilines(:,n)',lineL);
    pira(n,:) = cross(a_epilines(:,n)',lineR);
    
    pilb(n,:) = cross( b_epilines(:,n)',lineL);
    pirb(n, :) = cross( b_epilines(:,n)',lineR);
end
Wal = ones(size(pila));
Wal(:,1) = pila(:,3);
Wal(:,2) = pila(:,3);
Wal(:,3) = pila(:,3);
pila_s = pila./Wal;


War = ones(size(pila));
War(:,1) = pira(:,3);
War(:,2) = pira(:,3);
War(:,3) = pira(:,3);
pira_s = pira./War;


Wbl = ones(size(pila));
Wbl(:,1) = pilb(:,3);
Wbl(:,2) = pilb(:,3);
Wbl(:,3) = pilb(:,3);
pilb_s = pilb./Wbl;


Wbr = ones(size(pila));
Wbr(:,1) = pirb(:,3);
Wbr(:,2) = pirb(:,3);
Wbr(:,3) = pirb(:,3);
pirb_s = (pirb./ Wbr);

figure,imshow(img_a)


hold on

for n = 1:size(pila_s,1)
plot([pila_s(n,1),pira_s(n,1)],[pila_s(n,2),pira_s(n,2)],'Color','g','LineWidth',1)
end
hold off

figure,imshow(img_b)

hold on
for n = 1:size(pilb_s,1)
plot([pilb_s(n,1),pirb_s(n,1)],[pilb_s(n,2),pirb_s(n,2)],'Color','g','LineWidth',1)
end
hold off
