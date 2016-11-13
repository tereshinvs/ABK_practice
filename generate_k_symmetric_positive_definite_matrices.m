function res = generate_k_symmetric_positive_definite_matrices(k, n)
    res = zeros(k, n * n);
    for i = 1 : k
        res(i, :) = mat2vec(generate_symmetric_positive_definite_matrix(n))';
    end
end
