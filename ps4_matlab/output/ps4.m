simA = imread('input/simA.jpg');
simB = imread('input/simB.jpg');

transA = imread('input/transA.jpg');
transB = imread('input/transB.jpg');
%%test

checker = imread('input/check.bmp');
[gxchecker, gychecker ] = gradient(checker);
Rc = Harris(gxchecker,gychecker,3);

%%1a
[gxSimA, gySimA ] = gradient(simA);
[gxSimB, gySimB ] = gradient(simB);
fusedSimA = [gxSimA, gySimA ];
      
[gxTransA, gyTransA ] = gradient(transA);

[gxTransB, gyTransB ] = gradient(transB);

fusedTransA = [gxTransA, gyTransB ];
imwrite(fusedSimA, fullfile('output', 'ps4-1-a-2.png')); 

imwrite(fusedTransA, fullfile('output', 'ps4-1-a-1.png')); 
%% 1b

RsimA = Harris(gxSimA,gySimA,3);
RsimB = Harris(gxSimB,gySimB,3);

RtransA = Harris(gxTransA,gyTransA,3);

RtransB= Harris(gxTransB,gyTransB,3);

imwrite(RsimA, fullfile('output', 'ps4-1-b-3.png')); 

imwrite(RsimB, fullfile('output', 'ps4-1-b-4.png')); 

imwrite(RtransA, fullfile('output', 'ps4-1-b-1.png')); 

imwrite(RtransB, fullfile('output', 'ps4-1-b-2.png')); 
%% 1c
bestRsimA = FindBestPointsHarris(RsimA,7,.30);

bestRsimB = FindBestPointsHarris(RsimB,7,.30);


bestRtransA = FindBestPointsHarris(RtransA,7,.3);

bestRtransB = FindBestPointsHarris(RtransB,7,.3);
redSimA =addRed(simA,bestRsimA);
redSimB =addRed(simB,bestRsimB);

redTransA =addRed(transA,bestRtransA);
redTransB =addRed(transB,bestRtransB);

imwrite(redSimA, fullfile('output', 'ps4-1-c-3.png'));

imwrite(redSimB, fullfile('output', 'ps4-1-c-4.png'));


imwrite(redTransA, fullfile('output', 'ps4-1-c-1.png'));


imwrite(redTransB, fullfile('output', 'ps4-1-c-2.png'));

anglesSimA = computeAnglesSIFT(gySimA, gxSimA );


anglesSimB = computeAnglesSIFT(gySimB, gxSimB );


anglesTransA = computeAnglesSIFT(gyTransA, gxTransA );

anglesTransB = computeAnglesSIFT(gyTransB, gxTransB );


frameSimA = convertToFrames(bestRsimA, anglesSimA);
frameSimB = convertToFrames(bestRsimB, anglesSimB);

frameTransA = convertToFrames(bestRtransA, anglesTransA);
frameTransB = convertToFrames(bestRtransB, anglesTransB);

[FsimA, DsimA] = vl_sift(single(simA), 'frames', frameSimA);
[FsimB, DsimB] = vl_sift(single(simB), 'frames', frameSimB);

[FtransA, DtransA] = vl_sift(single(transA), 'frames', frameTransA);
[FtransB, DtransB] = vl_sift(single(transB), 'frames', frameTransB);
tempFsim = FsimB;
tempFsim(1,:) = FsimB(1,:) + size(simB,2);
figure (1);
imshow([simA,simB]) ;
%perm = randperm( size (FsimA , 2 ) ) ; %Premute the order randomly
%sel = perm (1:100); %Choose the 50 f i r s t keypoints
tempFsim(:, (size(tempFsim,2)+1):(size(tempFsim,2)+size(FsimA,2))) = FsimA;
h1 = vl_plotframe (tempFsim) ;
h2 = vl_plotframe (tempFsim ) ;
set (h1 , 'color' , 'k' , 'linewidth' ,3);
set (h2 , 'color' , 'y' , 'linewidth' ,2);

export_fig output/ps4-2-a-2.png

tempFtrans = FtransB;
tempFtrans(1,:) = FtransB(1,:) + size(transB,2);
figure (2);
imshow([transA,transB]) ;
%perm = randperm( size (FsimA , 2 ) ) ; %Premute the order randomly
%sel = perm (1:100); %Choose the 50 f i r s t keypoints
tempFtrans(:, (size(tempFtrans,2)+1):(size(tempFtrans,2)+size(FtransA,2))) = FtransA;
h1 = vl_plotframe (tempFtrans) ;
h2 = vl_plotframe (tempFtrans ) ;
set (h1 , 'color' , 'k' , 'linewidth' ,3);
set (h2 , 'color' , 'y' , 'linewidth' ,2);
export_fig output/ps4-2-a-1.png

Mtrans = vl_ubcmatch(DtransA, DtransB);



figure (3);
% with the same proportion and dimension, we can now show both
% images. Parts that are not used in the matrices will be black.

imshow([transA transB]);

hold all;

    X = zeros(2,1);
    Y = zeros(2,1);

    % draw line from the matched point in one image to the respective matched point in another image.
    for k=1:numel(Mtrans(1,:))

        X(1) = FtransA(1, Mtrans(1, k));
        Y(1) = FtransA(2, Mtrans(1, k));
        X(2) = FtransB(1, Mtrans(2, k)) + size(transA,2);  % for placing matched point of 2nd image correctly.
        Y(2) = FtransB(2, Mtrans(2, k));

        plot(X,Y);

    end


export_fig output/ps4-2-b-1.png
    
    Msim = vl_ubcmatch(DsimA, DsimB);



figure (4);
% with the same proportion and dimension, we can now show both
% images. Parts that are not used in the matrices will be black.
imshow([simA simB]);

hold all;

    X = zeros(2,1);
    Y = zeros(2,1);

    % draw line from the matched point in one image to the respective matched point in another image.
    for k=1:numel(Msim(1,:))

        X(1) = FsimA(1, Msim(1, k));
        Y(1) = FsimA(2, Msim(1, k));
        X(2) = FsimB(1, Msim(2, k)) + size(simA,2);  % for placing matched point of 2nd image correctly.
        Y(2) = FsimB(2, Msim(2, k));

        plot(X,Y);

    end
export_fig output/ps4-2-b-2.png


[offset, Ctrans] = RANSAC_Translation(Mtrans, FtransA,FtransB,15);

figure (5);
% with the same proportion and dimension, we can now show both
% images. Parts that are not used in the matrices will be black.
imshow([transA transB]);

hold all;

    X = zeros(2,1);
    Y = zeros(2,1);

    % draw line from the matched point in one image to the respective matched point in another image.
    for k=1:length(Ctrans)

        X(1) = FtransA(1, Mtrans(1, Ctrans(k,1)));
        Y(1) = FtransA(2, Mtrans(1, Ctrans(k,1)));
        X(2) = FtransA(1, Mtrans(1, Ctrans(k,1))) + size(transA,2)-offset(1,1);  % for placing matched point of 2nd image correctly.
        Y(2) = FtransA(2, Mtrans(1, Ctrans(k,1)))-offset(1,2);

        plot(X,Y);

    end




export_fig output/ps4-3-a-1.png

 [sim, C] = computeSim(Msim, FsimA,FsimB,2);

figure (6);
% with the same proportion and dimension, we can now show both
% images. Parts that are not used in the matrices will be black.
imshow([simA simB]);

hold all;

    X = zeros(2,1);
    Y = zeros(2,1);

    % draw line from the matched point in one image to the respective matched point in another image.
    for k=1:length(C)

        X(1) = FsimA(1, Msim(1, C(k,1)));
        Y(1) = FsimA(2, Msim(1, C(k,1)));
        A = [ X(1), Y(1),1]';
        B = sim*A;
        X(2) = size(simA,2)+B(1,1);  % for placing matched point of 2nd image correctly.
        Y(2) = B(2,1);

        plot(X,Y);

    end




export_fig output/ps4-3-b-1.png

     [aff, affC] = RANSAC_affine(Msim, FsimA,FsimB,2);

figure (7);
% with the same proportion and dimension, we can now show both
% images. Parts that are not used in the matrices will be black.
imshow([simA simB]);

hold all;

    X = zeros(2,1);
    Y = zeros(2,1);

    % draw line from the matched point in one image to the respective matched point in another image.
    for k=1:length(affC)

        X(1) = FsimA(1, Msim(1, affC(k,1)));
        Y(1) = FsimA(2, Msim(1, affC(k,1)));
        A = [ X(1), Y(1),1]';
        B = aff*A;
        X(2) = size(simA,2)+B(1,1);  % for placing matched point of 2nd image correctly.
        Y(2) = B(2,1);

        plot(X,Y);

    end




export_fig output/ps4-3-c-1.png
