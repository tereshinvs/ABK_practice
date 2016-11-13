function res = generate_symmetric_positive_definite_matrix(n)
    tmp = rand(n, n);
    res = tmp + tmp' + n * eye(n);
end
