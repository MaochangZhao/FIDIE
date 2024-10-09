function img = deconfusion(P,index)

[M, N] = size(P);
img = zeros(M, N);

% P = reshape(P, 1, []);

for i = M*N:-1:1
   t = i+1;
    if t == M*N+1
        t = 1;
    end
    img(index(i)) = P(index(t));
end

end
