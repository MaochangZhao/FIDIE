function sbox = FSM(sbox, fim, xy)

[H, ~] = size(fim);  % 分形索引矩阵的大小
[H1, ~] = size(sbox);  % Sbox的大小

high = H1/H;  % 待扩展矩阵的大小

x = xy(1,1);
y = xy(1,2);

tmp = [sbox, sbox; sbox, sbox];
[~, tmp] = sort(reshape(tmp(x:x+7,y:y+7),1,[]));
t = reshape(tmp, high, []);

% 计算对应索引矩阵
M = zeros(H1, H1);
for i = 1:high
    for j = 1:high
        tmp = t(i,j);
        M((i-1)*H+1:i*H, (j-1)*H+1:j*H) = fim + (tmp-1)*H*H;
    end
end

% 对Sbox进行置乱
new_sbox(M) = sbox;
sbox = reshape(new_sbox, H1, []);

end