clc;
clear all;
%%%%%%%%%% main function start %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

img = imread('2018250040.jpg'); % 읽어들일 파일명 입력.
img = rgb2gray(img);

img_noisy = imnoise(img,'salt & pepper', 0.005);

%%%%%%%%%%%%% Start From here %%%%%%%%%%%%%

img_avg = Average_3x3(img_noisy); % average filterd image 
img_gaussian = Gaussian_3x3(img_noisy); % gaussian filtered image
img_med = Median3x3(img_noisy); % median filtered image

%%%%%%%%%%%% Plot 4 images %%%%%%%%%%%%%%%
subplot(2,2,1);
imshow(img_noisy);
title('noisy image');
subplot(2,2,2);
imshow(img_gaussian);
title('Gaussian Filtered');
subplot(2,2,3);
imshow(img_avg);
title('Average Filtered');
subplot(2,2,4);
imshow(img_med);
title('Median Filtered');

%%%%%%%%%%%% Save Output images%%%%%%%%%%
imwrite(img_noisy, '2018250040_noisy.jpg');
imwrite(img_avg, '2018250040_avg.jpg');
imwrite(img_gaussian, '2018250040_gau.jpg');
imwrite(img_med, '2018250040_med.jpg');

%%%%%%%%%%%% main function end %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function img_avg = Average_3x3(img)
%%%%%%%%%%%% input : noisy img, output : 3x3 average filtered image %%%%%%%%%%%%%%
z_avg = ones(3)/9;
img_avg = conv2(img, z_avg,'same');
img_avg = uint8(img_avg);

end

function img_gaussian= Gaussian_3x3(img) 
%%%%%%%%%%%% input : noisy img, output : 3x3 gaussian filtered image %%%%%%%%%%%%%%
z_gau = [1,2,1;2,4,2;1,2,1]/16;
img_gaussian = conv2(img, z_gau,'same');
img_gaussian = uint8(img_gaussian);
end



function img_med = Median3x3(img)
%%%%%%%%%%%% input : noisy img, output : 3x3 median filtered image %%%%%%%%%%%%%%
[a,b] = size(img);
img1 = padarray(img,[1,1],'replicate', 'both');   %replicate padding 행,열 1칸씩
img_med = zeros(a,b);  %제로행렬 생성
for i = 2 : b+1
    for j = 2 : a+1
        med = img1(j-1:j+1, i-1:i+1);
        med = reshape(med,1,9);
        med = sort(med);
        img_med(j-1,i-1) = med(5); 
    end   
end
img_med = uint8(img_med);

end