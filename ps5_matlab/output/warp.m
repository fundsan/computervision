function [warpI2]=warp(i2,vx,vy) 
    % warp i2 according to flow field in vx vy 
    % this is a "backwards" warp: 
    % if vx,vy are correct then warpI2==i1
    [M,N]=size(i2);
    [x,y]=meshgrid(1:N,1:M);
    %use Matlab interpolation routine
    warpI3=interp2(x,y,i2,x+vx,y+vy,'*nearest');
    %use Matlab interpolation routine
    warpI2=interp2(x,y,i2,x+vx,y+vy,'*linear');
    I=isnan(warpI2); warpI2(I)=warpI3(I);
    I=isnan(warpI2);
    warpI2(I)=0;