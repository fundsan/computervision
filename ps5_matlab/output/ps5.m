test0 = imread('input/TestSeq/Shift0.png');
test2 = imread('input/TestSeq/ShiftR2.png');
test5 = imread('input/TestSeq/ShiftR5U5.png');
test10 = imread('input/TestSeq/ShiftR10.png');
test20 = imread('input/TestSeq/ShiftR20.png');
test40 = imread('input/TestSeq/ShiftR40.png');

[testY, testX] = size(test0);

filter = fspecial('gaussian', [13, 13],13/5);
smoothed0 = imfilter(test0, filter);
smoothed2 = imfilter(test2, filter);
smoothed5 = imfilter(test5, filter);
gt02 = double(smoothed2 )- double(smoothed0); 
gt05 = double(smoothed5 )- double(smoothed0);
[gx0, gy0 ] = gradient(smoothed0);


 [U2,V2] = LK_Step(gx0 , gy0, gt02,49);
 [U5,V5] = LK_Step(gx0 , gy0, gt05,49);
 %since since the y axis start on the top multiply by -1
 

 % reduce the number of arrows shown for clarity. 

 figure(1)
 subplot(2,1,1)
 imagesc(U2);
 colorbar;
 subplot(2,1,2)
  imagesc(V2);
  colorbar;
 export_fig 'output/ps5-1-a-1.png';
  figure(2)
subplot(2,1,1)
 imagesc(U5);
 colorbar;
 subplot(2,1,2)
  imagesc(V5);
  colorbar;
 export_fig 'output/ps5-1-a-2.png';
 %%1b
 smoothed10 = imfilter(test10, filter);
 smoothed20 = imfilter(test20, filter);
 smoothed40 = imfilter(test40, filter);
 gt010 = double(smoothed10 )- double(smoothed0); 
gt020 = double(smoothed20 )- double(smoothed0);
gt040 = double(smoothed40 )- double(smoothed0);

 [U10,V10] = LK_Step(gx0 , gy0, gt010,49);
 [U20,V20] = LK_Step(gx0 , gy0, gt020,49);
 [U40,V40] = LK_Step(gx0 , gy0, gt040,49);
  
  
  figure(3)
 subplot(2,1,1)
 imagesc(U10);
 colorbar;
 subplot(2,1,2)
  imagesc(V10);
  colorbar;
 export_fig output/ps5-1-b-1.png
 figure(4)
 subplot(2,1,1)
 imagesc(U20);
 colorbar;
 subplot(2,1,2)
  imagesc(V20);
  colorbar;
 export_fig output/ps5-1-b-2.png
 figure(5)
 subplot(2,1,1)
 imagesc(U40);
 colorbar;
 subplot(2,1,2)
  imagesc(V40);
  colorbar;
 export_fig output/ps5-1-b-3.png
  yos1 =  imread('input/DataSeq1/yos_img_01.jpg');
  
  yos2 =  imread('input/DataSeq1/yos_img_02.jpg');
  
  
  yos3 =  imread('input/DataSeq1/yos_img_03.jpg');
   yos1Smoothed = imfilter(yos1, filter);

  reduce1 = REDUCE(yos1Smoothed);
   reduce2 = REDUCE(reduce1);
   reduce3 = REDUCE(reduce2);
 figure(5)  
subplot(2,2,1), subimage(yos1Smoothed)
subplot(2,2,2), subimage(reduce1)

subplot(2,2,3), subimage(reduce2)
subplot(2,2,4), subimage(reduce3)
   
export_fig 'output/ps5-2-a-1.png';
   
   expand2 = uint8(EXPAND(reduce3));
   expand2 = trimImg(expand2, 1 ,1);
   expand1 = uint8(EXPAND(expand2));
   
   expandOrig =uint8(EXPAND(expand1));
   
   l2 = convertTo256Img(reduce2 - expand2);
   l1 = convertTo256Img(reduce1 - expand1);
   l0 = convertTo256Img(yos1Smoothed - expandOrig); 
   figure(6)
   subplot(2,2,1), subimage(l0)
   subplot(2,2,2), subimage(l1)

   subplot(2,2,3), subimage(l2)
   subplot(2,2,4), subimage(reduce3)
export_fig 'output/ps5-2-b-1.png';

 yos2Smoothed = imfilter(yos2, filter);

  reduce11 = REDUCE(yos2Smoothed);
   reduce21 = REDUCE(reduce11);
  reduce31 = REDUCE(reduce21);
   
   expand21 = uint8(EXPAND(reduce31));
   expand21 = trimImg(expand21, 1 ,1);
   expand11 = uint8(EXPAND(expand21));
   
   expandOrig1 =uint8(EXPAND(expand11));
   
gt1 = double(reduce3 )- double(reduce31); 
[gxR31, gyR31 ] = gradient(reduce31);
[UR31, VR31] = LK_Step(gxR31, gyR31,gt1,11);
expandUR2 = EXPAND(UR31);
expandUR2 = 2 .* trimImg(expandUR2,1,1);

expandVR2 = EXPAND(VR31);
expandVR2 = 2 .* trimImg(expandVR2,1,1);
warp2 = warp(double(reduce21),expandUR2,expandVR2);
   
gt1 = double(reduce21 )- double(warp2); 
[gxR31, gyR31 ] = gradient(warp2);
[UR31d, VR31d] = LK_Step(gxR31, gyR31,gt1,11);
expandUR2 = expandUR2+ UR31d;
expandVR2 = expandVR2 + VR31d;

yos3Smoothed = imfilter(yos3, filter);

  reduce12 = REDUCE(yos3Smoothed);
   reduce22 = REDUCE(reduce12);
  reduce32 = REDUCE(reduce22);
   
   expand22 = uint8(EXPAND(reduce32));
   expand22 = trimImg(expand22, 1 ,1);
   expand12 = uint8(EXPAND(expand22));
   
   expandOrig2 =uint8(EXPAND(expand12));
   
gt2 = double(reduce31 )- double(reduce32); 
[gxR32, gyR32 ] = gradient(reduce32);
[UR32, VR32] = LK_Step(gxR32, gyR32,gt2,11);
expandUR3 = EXPAND(UR32);
expandUR3 = 2 .* trimImg(expandUR3,1,1);

expandVR3 = EXPAND(VR32);
expandVR3 = 2 .* trimImg(expandVR3,1,1);
warp3 = warp(double(reduce22),expandUR3,expandVR3);
   
gt2 = double(reduce22 )- double(warp3); 
[gxR32, gyR32 ] = gradient(warp3);
[UR32d, VR32d] = LK_Step(gxR32, gyR32,gt2,11);
expandUR3 = expandUR3+ UR32d;
expandVR3 = expandVR3 + VR32d;

figure(7)
subplot(2,2,1), imagesc(expandUR2)
colorbar;
subplot(2,2,2),  imagesc(expandVR2)
colorbar;
subplot(2,2,3), imagesc(expandUR3)
colorbar;
subplot(2,2,4),  imagesc(expandVR3)
colorbar;
export_fig 'output/ps5-3-a-1.png';
imwrite(convertTo256Img((double(reduce2 )- double(warp2))), 'output/ps5-3-a-2.png');

dog0 =  rgb2gray(imread('input/DataSeq2/0.png'));
  
  dog1 =  rgb2gray(imread('input/DataSeq2/1.png'));
  
  
  dog2 =  rgb2gray(imread('input/DataSeq2/2.png'));
  filter = fspecial('gaussian', [31, 31],31/5);

  dog0Smoothed = imfilter(dog0, filter);

  reduce1 = REDUCE(dog0Smoothed);
   reduce2 = REDUCE(reduce1);
   reduce3 = REDUCE(reduce2);
 
   
   expand2 = uint8(EXPAND(reduce3));
   
   expand1 = uint8(EXPAND(expand2));
   
   expandOrig =uint8(EXPAND(expand1));
   
   l2 = reduce2 - expand2;
   l1 = reduce1 - expand1;
   l0 = dog0Smoothed - expandOrig; 
   

 dog1Smoothed = imfilter(dog1, filter);

  reduce11 = REDUCE(dog1Smoothed);
   reduce21 = REDUCE(reduce11);
  reduce31 = REDUCE(reduce21);
   
   expand21 = uint8(EXPAND(reduce31));
   
   expand11 = uint8(EXPAND(expand21));
   
   expandOrig1 =uint8(EXPAND(expand11));
   
gt1 = double(reduce3 )- double(reduce31); 
[gxR31, gyR31 ] = gradient(reduce31);
[UR31, VR31] = LK_Step(gxR31, gyR31,gt1,11);
expandUR2 = EXPAND(UR31);
expandUR2 = 2 .* expandUR2,1,1;

expandVR2 = EXPAND(VR31);
expandVR2 = 2 .* expandVR2,1,1;
warp2 = warp(double(reduce21),expandUR2,expandVR2);
   
gt1 = double(reduce21 )- double(warp2); 
[gxR31, gyR31 ] = gradient(warp2);
[UR31d, VR31d] = LK_Step(gxR31, gyR31,gt1,11);
expandUR2 = expandUR2+ UR31d;
expandVR2 = expandVR2 + VR31d;

dog2Smoothed = imfilter(dog2, filter);

  reduce12 = REDUCE(dog2Smoothed);
   reduce22 = REDUCE(reduce12);
  reduce32 = REDUCE(reduce22);
   
   expand22 = uint8(EXPAND(reduce32));
   
   expand12 = uint8(EXPAND(expand22));
   
   expandOrig2 =uint8(EXPAND(expand12));
   
gt2 = double(reduce31 )- double(reduce32); 
[gxR32, gyR32 ] = gradient(reduce32);
[UR32, VR32] = LK_Step(gxR32, gyR32,gt2,11);
expandUR3 = EXPAND(UR32);
expandUR3 = 2 .* expandUR3;

expandVR3 = EXPAND(VR32);
expandVR3 = 2 .* expandVR3;
warp3 = warp(double(reduce22),expandUR3,expandVR3);
   
gt2 = double(reduce22 )- double(warp3); 
[gxR32, gyR32 ] = gradient(warp3);
[UR32d, VR32d] = LK_Step(gxR32, gyR32,gt2,11);
expandUR3 = expandUR3+ UR32d;
expandVR3 = expandVR3 + VR32d;

figure(8)
subplot(2,2,1), imagesc(expandUR2)
colorbar;
subplot(2,2,2),  imagesc(expandVR2)
colorbar;
subplot(2,2,3), imagesc(expandUR3)
colorbar;
subplot(2,2,4),  imagesc(expandVR3)
colorbar;

export_fig 'output/ps5-3-a-3.png';
imwrite(convertTo256Img((double(reduce2 )- double(warp2))), 'output/ps5-3-a-4.png');
  filter = fspecial('gaussian', [37, 37],101/5);

smoothed0 = imfilter(test0, filter);
  smoothed10 = imfilter(test10, filter);
 smoothed20 = imfilter(test20, filter);
 smoothed40 = imfilter(test40, filter);
[U10, V10] =Heir_LK(smoothed0, smoothed10, 2);
[U20, V20] =Heir_LK(smoothed0, smoothed20, 3);
[U40, V40] =Heir_LK(smoothed0, smoothed40, 4);

figure(10)
subplot(3,2,1)
 imagesc(U10);
 colorbar;
 subplot(3,2,2)
  imagesc(V10);
  colorbar;
 
 subplot(3,2,3)
 imagesc(U20);
 colorbar;
 subplot(3,2,4)
  imagesc(V20);
  colorbar;

 subplot(3,2,5)
 imagesc(U40);
 colorbar;
 subplot(3,2,6)
  imagesc(V40);
  colorbar;
  export_fig output/ps5-4-a-1.png;
  figure(11)
subplot(1,3,1)
imshow(convertTo256Img((double(smoothed10 )- double(warp(double(smoothed0), U10,V10)))));
subplot(1,3,2)
imshow(convertTo256Img((double(smoothed20 )- double(warp(double(smoothed0), U20,V20)))));
subplot(1,3,3)
imshow(convertTo256Img((double(smoothed40 )- double(warp(double(smoothed0), U40,40)))));
export_fig output/ps5-4-a-2.png;
[Uy2, Vy2] =Heir_LK(yos1Smoothed, yos2Smoothed, 1);
[Uy3, Vy3] =Heir_LK(yos2Smoothed, yos3Smoothed, 1);
figure(12)
subplot(2,2,1)
 imagesc(Uy2);
 colorbar;
 subplot(2,2,2)
  imagesc(Vy2);
  colorbar;
 
 subplot(2,2,3)
 imagesc(Uy3);
 colorbar;
 subplot(2,2,4)
  imagesc(Vy3);
  colorbar;

  export_fig output/ps5-4-b-1.png;
  figure(13)
subplot(1,2,1)
imshow(convertTo256Img((double(yos2Smoothed )- double(warp(double(yos1Smoothed), Uy2,Vy2)))));
subplot(1,2,2)
imshow(convertTo256Img((double(yos3Smoothed )- double(warp(double(yos2Smoothed), Uy3,Vy3)))));


  export_fig output/ps5-4-b-2.png;
 
[Ud2, Vd2] =Heir_LK(dog0Smoothed, dog1Smoothed, 1);
[Ud3, Vd3] =Heir_LK(dog1Smoothed, dog2Smoothed, 1);
figure(14)
subplot(2,2,1)
 imagesc(Ud2);
 colorbar;
 subplot(2,2,2)
  imagesc(Vd2);
  colorbar;
 
 subplot(2,2,3)
 imagesc(Ud3);
 colorbar;
 subplot(2,2,4)
  imagesc(Vd3);
  colorbar;

  export_fig output/ps5-4-c-1.png;
  figure(15)
subplot(1,2,1)
imshow(convertTo256Img((double(dog1Smoothed )- double(warp(double(dog0Smoothed), Ud2,Vd2)))));
subplot(1,2,2)
imshow(convertTo256Img((double(dog2Smoothed )- double(warp(double(dog1Smoothed), Ud3,Vd3)))));


  export_fig output/ps5-4-c-2.png;
