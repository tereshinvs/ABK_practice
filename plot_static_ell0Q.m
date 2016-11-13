function plot_static_ell0Q(T, Te, xc, Xc, l, l1, l2, dphi, c)
    global N
    
    l1 = l1 / norm(l1);
    l2 = l2 - scalar_mult(l2, l1) * l1;
    
    phi = [0 : dphi : (2 * pi) 0];

    tres = zeros(size(T, 2), size(phi, 2));
    xres = zeros(size(T, 2), size(phi, 2));
    yres = zeros(size(T, 2), size(phi, 2));
    
    pos = 1;
    for i = 1 : size(T, 2)
        mat = zeros(size(l, 1), N);
        for j = 1 : size(l, 1)
            curpos = pos;
            dir = l(j, :)';
            dist = 0;
            distv = dir;
            
            while curpos < size(Te, 1) && abs(Te(curpos) - T(i)) < 1e-6
                xct = xc(curpos, :)';
                Xct = vec2mat(Xc(curpos, :), N, N)';
                tdir = inv(Xct) * dir;
                tdist = sqrt(scalar_mult(tdir, Xct * tdir));
                tvect = xct + Xct * tdir / tdist;
                if tdist > dist
                    dist = tdist;
                    distv = tvect;
                end
                curpos = curpos + 1;
            end
            
            mat(j, :) = distv';
        end
        pos = curpos;
        
        q = zeros(sqrt(N), 1);
        for w = 1 : size(phi, 2)
            dir = l1 * cos(phi(w)) + l2 * sin(phi(w));
            dist = 0;
            distv = dir;
            for j = 1 : size(l, 1)
                Q = vec2mat(mat(j, :)', sqrt(N), sqrt(N));
                tdir = inv(Q) * dir;
                tdist = sqrt(scalar_mult(tdir, Q * tdir));
                tvect = q + Q * tdir / tdist;            
                if tdist > dist
                    dist = tdist;
                    distv = tvect;
                end
            end
            tres(i, w) = T(i);
            xres(i, w) = scalar_mult(distv, l1);
            yres(i, w) = scalar_mult(distv, l2);
        end
    end
    
    hold on
    surf(tres, xres, yres, 'FaceAlpha', 0.5, 'FaceColor', c);
    xlabel('t');
    ylabel('l_1');
    zlabel('l_2');
end
