function res = mat2vec_col(A)
    res = zeros(size(A, 1) * size(A, 2), 1);
    for i = 1 : size(A, 1)
        for j = 1 : size(A, 2)
            res((i - 1) * size(A, 2) + j) = A(j, i);
        end
    end
end
