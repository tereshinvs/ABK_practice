function res = op2mat(A, n, m)
    Atmp = cell(n, n);
    tmp = zeros(n, n);
    for ii = 1 : n
        for jj = 1 : n
            tmp(ii, jj) = 1;
            Atmp{ii, jj} = A(tmp);
            tmp(ii, jj) = 0;
        end
    end

    function res2 = at_t(t)
        res2 = zeros(m * m, n * n);
        for i = 1 : n
            for j = 1 : n
                Atmpt = Atmp{i, j}(t);
                ti = (i - 1) * n + j - 1;
                for k = 1 : m
                    for l = 1 : m
                        res2((k - 1) * m + l, ti + 1) = Atmpt(k, l);
                    end
                end
            end
        end
    end

    res = @at_t;
end
