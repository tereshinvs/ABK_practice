function res = shape_right_part(t, l_Xcm)
    global A B P N
    
    lt = l_Xcm(1 : N);
    Xc = vec2mat(l_Xcm((N + 1) : end), N, N);
    
    At = A(t);
    Bt = B(t);
    Pt = P(t);
    
    %lt
    %Xc
    BtPtBtT = Bt * Pt * Bt';
    %scalar_mult(lt, BtPtBtT * lt)
    %scalar_mult(lt, Xc * lt)
    pi_l_t = sqrt(scalar_mult(lt, BtPtBtT * lt) / scalar_mult(lt, Xc * lt));
    if ~isreal(pi_l_t) || pi_l_t == Inf
        disp('error');
        pi_l_t = 0;
    end
    %pi_l_t
    if isnan(Xc)
        error('Xc');
    end

    if abs(pi_l_t) < 1e-6
        Xcres = At * Xc + Xc * At';
    else
        Xcres = At * Xc + Xc * At' + pi_l_t * Xc + 1/pi_l_t * BtPtBtT;
    end
    
    lres = -At' * lt;
    
    res = real([lres; mat2vec(Xcres)]);
end
