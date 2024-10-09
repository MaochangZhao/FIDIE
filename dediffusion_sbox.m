function P = dediffusion_sbox(C, sbox, D)

[M, N] = size(C);
P = zeros(M, N);

for i = M*N:-1:2
    x = ceil(i/256); % µÚ¼¸¸öSºÐ
    y = i-(x-1)*256;
    P(i) = mod(bitxor(bitxor(bitxor(C(i), sbox(x,y)), D(i)), C(i-1)) - sbox(x,C(i-1)+1), 256);
end

P(1) = bitxor(bitxor(C(1),sbox(1,1)),D(1));

end