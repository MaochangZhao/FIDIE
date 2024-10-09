function [cml, u, e] = parameter(P,encry)
% 秘钥处理
if ischar(P) == 1
    img_hash = P;
else
    img_hash = hash(P,['SHA' num2str(encry)]);
end
b = zeros(1,encry);
% 转二进制
for n = 1:encry/4
    switch img_hash(n)
        case '0'
            a(:)=[0 0 0 0];
        case '1'
            a(:)=[0 0 0 1];
        case '2'
            a(:)=[0 0 1 0];
        case '3'
            a(:)=[0 0 1 1];
        case '4'
            a(:)=[0 1 0 0];
        case '5'
            a(:)=[0 1 0 1];
        case '6'
            a(:)=[0 1 1 0];
        case '7'
            a(:)=[0 1 1 1];
        case '8'
            a(:)=[1 0 0 0];
        case '9'
            a(:)=[1 0 0 1];
        case 'a'
            a(:)=[1 0 1 0];
        case 'b'
            a(:)=[1 0 1 1];
        case 'c'
            a(:)=[1 1 0 0];
        case 'd'
            a(:)=[1 1 0 1];
        case 'e'
            a(:)=[1 1 1 0];
        case 'f'
            a(:)=[1 1 1 1];
    end
    b(4*n-3:4*n) = a(:);
end

bz = reshape(b,16,16);

u = 3.9 + 0.1*bi2de(bitxor(bitxor(bitxor(bz(:,1),bz(:,3)),bitxor(bz(:,5),bz(:,7))),bitxor(bitxor(bz(:,9),bz(:,11)),bitxor(bz(:,13),bz(:,15))))')/2^16;
e = bi2de(bitxor(bitxor(bitxor(bz(:,2),bz(:,4)),bitxor(bz(:,6),bz(:,8))),bitxor(bitxor(bz(:,10),bz(:,12)),bitxor(bz(:,14),bz(:,16))))')/2^16;

sum = 0;
for i = 1:16
    sum = sum + bi2de(bz(:,i)');
end

cml = zeros(4,4);
for i = 1:16
    cml(i) = mod(sum/bi2de(bz(:,i)'),1);
end

end
