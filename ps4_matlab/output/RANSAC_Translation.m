function [offset, C] = RANSAC_Translation(ind, A,B,noiseVariance)

t= sqrt(3.84*noiseVariance^2);
N = ceil(log(1-.99)/(log(1-(1-.5)^2)));

C = [];
counter = 1;
Xavg = 0;
Yavg = 0;
for n = 1:N
p = randperm(size(ind,2),1);

s = ind(:, p);
AX = A(1,s(1,1));
AY= A(2,s(1,1));
BX = B(1,s(2,1));
BY= B(2,s(2,1));
currentX=  AX-BX;
currentY = AY-BY;
P = [1 0 -currentX;
     0 1 -currentY];

tempC = [];
tempXavg = 0;
tempYavg = 0;
for i = 1:size(ind,2)
    tAX = A(1,ind(1,i));
    tAY= A(2,ind(1,i));
    tBX = B(1,ind(2,i));
    tBY= B(2,ind(2,i));
    tempVals = [tAX- tBX, tAY- tBY, 1];
    res = sum(P*tempVals');
    if (res) <= t
        tempC(counter ,1) = i;
        counter = counter +1;
        tempXavg = tempXavg + ( tAX- tBX);
        tempYavg = tempYavg + ( tAY- tBY);
    end
end
counter = 1;
if size(tempC,1) > size(C,1)
    C = tempC;
    Xavg = tempXavg/size(tempC,1);
    Yavg = tempYavg/size(tempC,1);
end
end
offset = [Xavg, Yavg];