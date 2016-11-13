function [T, xc, Xc] = static_projection(lt, T_)
    global N Nu Nv T0 T1 A B C x1 X1 p P q Q dT options
   
    T = zeros(size(T_, 2) * size(lt, 1), 1);
    xc = zeros(size(T_, 2) * size(lt, 1), N);
    Xc = zeros(size(T_, 2) * size(lt, 1), N * N);
    
    num = 1;
    for j = 1 : size(T_, 2)
        j
        size(T_, 2)
        for i = 1 : size(lt, 1)
            l = lt(i, :)';
            if j > 1
                [~, lv] = ode45(@(t, x) -A(t)' * x, [T_(j) T_(1)], l, options);
                [~, xctmp, Xctmp] = solve(lv(end, :)', T_(1 : j));
            else
                xctmp = x1';
                Xctmp = mat2vec(X1)';
            end
            T(num) = T_(j);
            xc(num, :) = xctmp(end, :);
            Xc(num, :) = Xctmp(end, :);
            num = num + 1;
        end
    end
end
