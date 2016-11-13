function res = mat2rep(A)
    m = round(sqrt(size(A, 1)));
    n = round(sqrt(size(A, 2)));
    res = zeros(n, n, m, m);
    for i = 1 : (m * m)
        for j = 1 : (n * n)
            pos = (i - 1) * n * n + j - 1;
            tl = mod(pos, m); pos = (pos - tl) / m;
            tk = mod(pos, m); pos = (pos - tk) / m;
            tj = mod(pos, n); pos = (pos - tj) / n;
            ti = pos;
            res(ti + 1, tj + 1, tk + 1, tl + 1) = A(i, j);
        end
    end
end

