function [xc, Xc] = static_reachset(lt, T0, t, dphi)
    global N Nu Nv T0 T1 A B C x1 X1 p P q Q dT options

    xc = [];
    Xc = [];

    for i = 1 : size(lt, 1)
        l = lt(i, :)';
        [~, lv] = ode45(@(t, x) -A(t)' * x, [t T0], l, options);
             [~, xctmp, Xctmp] = solve(lv(end, :)', T0 : dT : t);
        %if norm(vec2mat(Xctmp, N, N)) < 1e-2
        %    Xctmp = mat2vec(0.01 * eye(N));
        %    continue;
        %end
        if size(xc, 1) > 0
            xc = [xc; xctmp(end, :)];
            Xc = [Xc; Xctmp(end, :)];
        else
            xc = xctmp(end, :);
            Xc = Xctmp(end, :);
        end
    end
end
