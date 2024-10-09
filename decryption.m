clc;
clear;

img = imread('img_en\test.bmp');
% img = imnoise(img,'salt & pepper',0.05);

key = '9660d6f5c5c5fd3cfa96bd49b72d7652a55a64dd00030fbf2bec996322a8e0b3';
% key = '20636bf73d4890b936d30d375139c68e3842d5d95a09192689d968895c7736f8';
img_c = img;
img = double(img);

[M, N] = size(img);
isRGB = numel(size(img)) > 2;
if isRGB
    img = [img(:,:,1),img(:,:,2),img(:,:,3)];
end

[cml, u, e] = parameter(key,256); % 秘钥处理

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

img = dediffusion_sbox(img, sbox_mat-1, D);
img = deconfusion(img, Index);

P = uint8(img);
if isRGB
    P = cat(3,P(1:M,1:N/3),P(1:M,N/3+1:2*N/3),P(1:M,2*N/3+1:N));
end
imshow([img_c,P]);
imwrite(P, 'img_en\lena1.bmp');