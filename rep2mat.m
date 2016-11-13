function res = rep2mat(f, n, m)
    function res2 = at_t(t)
        A = f(t);
        res2 = zeros(m * m, n * n);
%         for i = 1 : (n * n)
%             for j = 1 : (m * m)
%                 ti = floor((i - 1) / n);
%                 tj = i - n * ti;
%                 ti = ti + 1;
% 
%                 tk = floor((j - 1) / m);
%                 tl = j - m * tk;
%                 tk = tk + 1;
%                 res2(j, i) = A(tj, ti, tl, tk);
%             end
%         end
        for i = 1 : n
            for j = 1 : n
                for k = 1 : m
                    for l = 1 : m
                        ti = (i - 1) * n + j - 1;
                        tj = (k - 1) * m + l - 1;
                        res2(tj + 1, ti + 1) = A(i, j, k, l);
                    end
                end
            end
        end
    end
    res = @at_t;
end

