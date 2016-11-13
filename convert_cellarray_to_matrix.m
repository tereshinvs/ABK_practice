function res1 = convert_cellarray_to_matrix(A, n, m)
    function res2 = at_t(t)
        res2 = zeros(n, n, m, m);
        for i = 1 : n
            for j = 1 : n
                res2(i, j, :, :) = A{i, j}(t);
            end
        end
    end
    res1 = @at_t;
end
