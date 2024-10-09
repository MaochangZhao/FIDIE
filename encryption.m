clc;
clear;

img = imread('img\baboon.bmp');
img_p = img;
img = double(img);

[M, N] = size(img);
isRGB = numel(size(img)) > 2;
if isRGB
    img = [img(:,:,1),img(:,:,2),img(:,:,3)];
end

[cml, u, e] = parameter(img,256); % 秘钥处理

cml = URCML(cml, u, e, M*N);
[~, Index] = sort(reshape(cml(1,2,:), 1, [])); % 置乱序列
D = mod(floor(reshape(cml(1,4,:)*2^13, 1, [])),256); % 扩散序列

[~, sbox] = sort(cml(3,1,end-255:end));
sbox = reshape(sbox, 16, 16); % S盒初始化
length = ceil((M*N)/(16*16)); % 计算Sbox分形变化所需迭代次数

% 坐标信息
mat = mod(floor([reshape(cml(2,2,end-length+1:end), 1, []); reshape(cml(2,4,end-length+1:end), 1, [])]'*10^8),16)+1;
fim = zeros(4,length);
fim(1,:) = cml(3,2,end-length+1:end);
fim(2,:) = cml(3,4,end-length+1:end);
fim(3,:) = cml(4,2,end-length+1:end);
fim(4,:) = cml(4,4,end-length+1:end);
[~, fim] = sort(fim);
fim = reshape(fim, 2, 2, []);

% 矩阵存储sbox， 每行存储一个sbox
sbox_mat = zeros(length, 16*16);
for i = 1:length
    sbox = FSM(sbox, fim(:,:,i), mat(i,:));
    sbox_mat(i,:) = reshape(sbox, 1, []);
end
tic
img = confusion(img, Index);
img = diffusion_sbox(img, sbox_mat-1, D);
toc
C = uint8(img);
if isRGB
    C = cat(3,C(1:M,1:N/3),C(1:M,N/3+1:2*N/3),C(1:M,2*N/3+1:N));
end

imshow([img_p,C]);
imwrite(C, 'img_en\lena.bmp');