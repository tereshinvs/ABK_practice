function res = par_op2mat(A, n, m)
    Atmp = cell(n, n);
    tmp = zeros(n, n);
    for iii = 1 : n
        for jj = 1 : n
            tmp(iii, jj) = 1;
            Atmp{iii, jj} = A(tmp);
            tmp(iii, jj) = 0;
        end
    end

    function res2 = at_t(t)
        res2 = zeros(m * m, n * n);
        parfor ii = 1 : (n * n)
			i = floor((ii - 1) / n);
			j = ii - i * n - 1;
            Atmpt = Atmp{i + 1, j + 1}(t);
			ptmp = zeros(m * m, 1);
            for k = 1 : m
                for l = 1 : m
					ptmp((k - 1) * m + l) = Atmpt(k, l);
				end
			end
			res2(:, ii) = ptmp;
        end
    end
    res = @at_t;
end
