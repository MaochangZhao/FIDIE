function CML = URCML(init, u, e, length)

% 格子数 迭代次数
lattice = 4;
R = 4;
times = length + 500;
p = 13;
q = 7;

cml = zeros(R,lattice,times);
cml(:,:,1) = init;

% 时空混沌
for n = 2:times
    for i = 1:R
        for j = 1:lattice
            i1 = mod((i+p*i),R)+1;
            i2 = mod(q*i+(p*q+1)*i,R)+1;
            j1 = mod((j+p*j),lattice)+1;
            j2 = mod(q*j+(p*q+1)*j,lattice)+1;
            
            aaa = u*cml(i,j,n-1)*(1-cml(i,j,n-1));
            if mod(n,2) == 0
                cml(i,j,n) = (1-e)*aaa + (e/2)*( u*cml(i1,j,n-1)*(1-cml(i1,j,n-1)) + u*cml(i2,j,n-1)*(1-cml(i2,j,n-1)));
            else
                cml(i,j,n) = (1-e)*aaa + (e/2)*(u*cml(i,j1,n-1)*(1-cml(i,j1,n-1)) +  u*cml(i,j2,n-1)*(1-cml(i,j2,n-1)));
            end
            e = 3.99*e*(1-e);
        end
    end
end

CML = cml(:, :, end-length+1:end);

end

