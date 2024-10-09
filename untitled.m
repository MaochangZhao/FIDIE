% Define the 16*16 S-box


sbox = reshape(sbox_mat(1,:),16,16);
% sbox = [1,2,8;5,3,7;6,4,9];
% Insert your S-box here
n = size(sbox,1);% Compute the nonlinearity of the S-box
nl = 0;
for i = 0:(n-1)
    for j = 0:(n-1)
        x = bitxor(i,j);
        y = bitxor(sbox(i+1),sbox(j+1));
        nl = nl + bitxor(x,y);
    end
end
nl = abs(nl - n^2/2);
% Print the result
disp(nl);
