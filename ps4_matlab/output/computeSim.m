function [result, C] = computeSim(M,A,B, noiseVariance)

t= sqrt(3.84*noiseVariance^2);
N = ceil(log(1-.99)/(log(1-(1-.5)^2)));
result = 0;
C = [];
counter = 1;
for n = 1:N
p = randperm(size(M,2),2);

s = M(:, p);
AX = A(1,s(1,1));
AY= A(2,s(1,1));
BX = B(1,s(2,1));
BY= B(2,s(2,1));
CX = A(1,s(1,2));
CY= A(2,s(1,2));
DX = B(1,s(2,2));
DY= B(2,s(2,2));

Q = [AX, -AY, 1, 0;
     AY, AX, 0, 1;
     CX, -CY, 1, 0;
     CY , CX, 0 , 1];
 P = [BX BY DX DY];
 R = pinv(Q)*P';
 sim = [R(1,1), -R(2,1) ,R(3,1);
        R(2,1) R(1,1) R(4,1)];
 
 tempC = [];
 for i = 1:size(M,2)
    AX = A(1,M(1,i));
    AY= A(2,M(1,i));
    BX = B(1,M(2,i));
    BY= B(2,M(2,i));
    a = [AX; AY; 1];
    b = sim * a;

tempX = abs(BX - b(1,1))^2;
    tempY = abs(BY - b(2,1))^2;
    if (tempX+tempY) <= t
        tempC(counter,1) = i;
        counter = counter +1;
    end
 end

 if size(tempC,1) > size(C,1)
    C = tempC;
    result = sim;
 end
 counter = 1;
end