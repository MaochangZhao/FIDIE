function C = diffusion_sbox(P, sbox, D)

[M, N] = size(P);
C = zeros(M, N);

C(1) = bitxor(bitxor(P(1),sbox(1,1)),D(1));

for i = 2:M*N
    x = ceil(i/256); % 第几个S盒
    y = i-(x-1)*256;
    a = mod( P(i) + sbox(x,C(i-1)+1), 256);
    C(i) = bitxor( bitxor( bitxor( a, C(i-1)), D(i)), sbox(x,y));
end

end