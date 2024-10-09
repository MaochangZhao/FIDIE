function img = confusion(P,index)

[M, N] = size(P);
img = zeros(M, N);

% P = reshape(P, 1, []);

for i = 1:M*N
    t = i+1;
    if t == M*N+1
        t = 1;
    end
    img(index(t)) = P(index(i));
end

end