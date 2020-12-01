clc; clear all;
img_1 = imread('IU_gray.jpg');
img_2 = imread('2018250040.jpg'); % ������ ���� �� ���� �о����.
img_2 = rgb2gray(img_2); % gray ��ȯ
img_2 = imresize(img_2, size(img_1)); % size ���߱� ���� 500 x 500���� resize

[a, b] = Swap_image(img_1, img_2);

figure(1);
subplot(2,2,1);
imshow(img_1);
title('image 1');
subplot(2,2,2);
imshow(img_2);
title('image 2');
subplot(2,2,3);
imshow(uint8(a));
title('image 1 magnitude + image 2 phase');
subplot(2,2,4);
imshow(uint8(b));
title('image 2 magnitude + image 1 phase');

%%%%%%%%%%%%%%%%%%%%% End of the problem 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%% Start the problem  2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
img = imread('IU_gray.jpg');

noisy_fft = img_noiser(img); % ���� noise�� ���ϰ� noisy image�� fft�� ��ȯ 
figure(2);
Filtering_denoiser(noisy_fft);


function [a, b] = Swap_image(img_1, img_2)
% a = magnitude of img 1 + phase of img 2
% b = magnitude of img 2 + phase of img 1
%%%%%%%%%%%%function starts from here %%%%%%%%%%%%%%%%%%%
img1_fft = fft2(img_1);
mag1 = abs(img1_fft);
phase1 = angle(img1_fft);

img2_fft = fft2(img_2);
mag2 = abs(img2_fft);
phase2 = angle(img2_fft);

pic_a = complex(mag1.*cos(phase2), mag1.*sin(phase2));
pic_b = complex(mag2.*cos(phase1), mag2.*sin(phase1));

a = ifft2(pic_a);
b = ifft2(pic_b);


%%%%%%%%%%%%function ends from here %%%%%%%%%%%%%%%%%%%
end

function Filtering_denoiser(noisy_fft)
%%%%%%% noisy image�� fft�� �Է¹޾� fft ����� magnitude �� ��� ���� �� ��� 

%%%%%%%%%%%%function starts from here %%%%%%%%%%%%%%%%%%%
subplot(2,2,1);
l = ifft2(fftshift(noisy_fft));
imshow(uint8(l));
title('noisy image');

subplot(2,2,2);
I = 10 * log(1 + abs(noisy_fft));
imshow(uint8(I));
title('DFT magnitude');

[x,y] = meshgrid(-249:250, -249:250);
x = abs(x);
y = abs(y);
c = x + y < 200;

k = noisy_fft.*c;
subplot(2,2,3);
imshow(uint8(ifft2(fftshift(k))));
title('denoised image')

subplot(2,2,4);
imshow(uint8(10 * log(1 + abs(k))));
title('denoised DFT magnitude');
%%%%%%%%%%%%function ends from here %%%%%%%%%%%%%%%%%%%
end

