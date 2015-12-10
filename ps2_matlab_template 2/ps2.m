% ps2

%% 1-a
% Read images
L = im2double(imread(fullfile('input', 'pair0-L.png')));
R = im2double(imread(fullfile('input', 'pair0-R.png')));

% Compute disparity
D_L = mat2gray(disparity_ssd(L, R, 15,1, 1));
Lmin=min(D_L(:));
Lmax=max(D_L(:));



%D_L = mat2gray((D_L - Lmin)/(Lmax - Lmin) * 255.0);
D_R = mat2gray(disparity_ssd(R, L, 15, 1, 0));
Rmin=min(D_R(:));
Rmax=max(D_R(:));



%D_R = mat2gray((D_R - Rmin)/(Rmax - Rmin) * 255.0);
% TODO: Save output images (D_L as output/ps2-1-a-1.png and D_R as output/ps2-1-a-2.png)
% Note: They may need to be scaled/shifted before saving to show results properly
%D_L = mat2gray(D_L);
%D_R = mat2gray(D_R);
imwrite(D_L, fullfile('output', 'ps2-1-a-1.png')); 
imwrite(D_R, fullfile('output', 'ps2-1-a-2.png')); 
% TODO: Rest of your code here
%% 2-
% Read images

L2 = imread(fullfile('ps2_matlab_template/input', 'pair1-L.png'));
R2 = imread(fullfile('ps2_matlab_template/input', 'pair1-R.png'));


L2 = im2double(rgb2gray(L2));
R2 = im2double(rgb2gray(R2));


% Compute disparity
D_L2 = mat2gray(disparity_ssd(L2, R2, 7, .8, 1));

D_R2 = mat2gray(disparity_ssd(R2, L2,7, .8, 0 ));


imwrite(D_L2, fullfile('output', 'ps2-2-a-1.png')); 
imwrite(D_R2, fullfile('output', 'ps2-2-a-2.png')); 

noisysigma = .1;
noise = randn(size(L2)) .* noisysigma;
L2 = L2 + noise;
noise = randn(size(R2)) .* noisysigma;
R2 = R2 + noise;


% Compute disparity
D_L2 = mat2gray(disparity_ssd(L2, R2, 7, .8, 1));

D_R2 = mat2gray(disparity_ssd(R2, L2,7, .8, 0 ));


imwrite(D_L2, fullfile('output', 'ps2-3-a-1.png')); 
imwrite(D_R2, fullfile('output', 'ps2-3-a-2.png')); 


L2 = imread(fullfile('ps2_matlab_template/input', 'pair1-L.png'));
R2 = imread(fullfile('ps2_matlab_template/input', 'pair1-R.png'));


L2 = rgb2gray(L2);
R2 = mat2gray(rgb2gray(R2));
% Compute disparity

L2= mat2gray(contrast(L2));
imshow(L2)
D_L2 = mat2gray(disparity_ssd(L2, R2, 7, .8, 1));

D_R2 = mat2gray(disparity_ssd(R2, L2,7, .8, 0 ));

imwrite(D_L2, fullfile('output', 'ps2-3-b-1.png')); 
imwrite(D_R2, fullfile('output', 'ps2-3-b-2.png')); 


L2 = imread(fullfile('ps2_matlab_template/input', 'pair1-L.png'));
R2 = imread(fullfile('ps2_matlab_template/input', 'pair1-R.png'));


L2 = im2double(rgb2gray(L2));
R2 = im2double(rgb2gray(R2));
% Compute disparity
D_L2 = mat2gray(disparity_ncorr(L2, R2, 7, .8, 1));

D_R2 = mat2gray(disparity_ncorr(R2, L2,7, .8, 0 ));

imwrite(D_L2, fullfile('output', 'ps2-4-a-1.png')); 
imwrite(D_R2, fullfile('output', 'ps2-4-a-2.png')); 


noisysigma = .1;
noise = randn(size(L2)) .* noisysigma;
L2 = L2 + noise;
noise = randn(size(R2)) .* noisysigma;
R2 = R2 + noise;


% Compute disparity
D_L2 = mat2gray(disparity_ncorr(L2, R2, 7, .8, 1));

D_R2 = mat2gray(disparity_ncorr(R2, L2,7, .8, 0 ));
imwrite(D_L2, fullfile('output', 'ps2-4-b-1.png')); 
imwrite(D_R2, fullfile('output', 'ps2-4-b-2.png')); 


L2 = imread(fullfile('ps2_matlab_template/input', 'pair1-L.png'));
R2 = imread(fullfile('ps2_matlab_template/input', 'pair1-R.png'));


L2 = rgb2gray(L2);
R2 = im2double(rgb2gray(R2));
% Compute disparity

L2= im2double(contrast(L2));
D_L2 = mat2gray(disparity_ncorr(L2, R2, 7, .8, 1));


L2 = imread(fullfile('ps2_matlab_template/input', 'pair1-L.png'));
L2 = im2double(rgb2gray(L2));
R2= im2double(contrast(R2));
D_R2 = mat2gray(disparity_ncorr( R2, L2, 7, .8, 0));

imwrite(D_L2, fullfile('output', 'ps2-4-b-3.png')); 
imwrite(D_R2, fullfile('output', 'ps2-4-b-4.png')); 




L2 = imread(fullfile('ps2_matlab_template/input', 'pair2-L.png'));
R2 = imread(fullfile('ps2_matlab_template/input', 'pair2-R.png'));


L2 = im2double(rgb2gray(L2));
R2 = im2double(rgb2gray(R2));
% Compute disparity
filter = fspecial('gaussian', [4 4] , 2);
L2= imfilter(L2, filter);
D_L2 = mat2gray(disparity_ncorr( L2, R2, 11, .8, 1));


D_R2 = mat2gray(disparity_ncorr( R2, L2, 11, .8, 0));


imwrite(D_L2, fullfile('output', 'ps2-5-a-1.png')); 
imwrite(D_R2, fullfile('output', 'ps2-5-a-2.png')); 





