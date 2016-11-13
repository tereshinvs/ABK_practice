function plot_static_reach_tube(T, Te, xc, Xc, l, dphi, c)
    global N
    
    tres = zeros(size(T, 2), size(l, 1));
    xres = zeros(size(T, 2), size(l, 1));
    yres = zeros(size(T, 2), size(l, 1));
    
    pos = 1;
    for i = 1 : size(T, 2)
        for j = 1 : size(l, 1)
            curpos = pos;
            dir = l(j, :)';
            dist = 0;
            distv = dir;
            
            while curpos < size(Te, 1) && abs(Te(curpos) - T(i)) < 1e-6
                xct = xc(curpos, :)';
                Xct = vec2mat(Xc(curpos, :), N, N)';
                if norm(Xct) < 1e-4
                    tdist = 0;
                    tvect = xct;
                else
                    tdir = inv(Xct) * dir;
                    tdist = sqrt(scalar_mult(tdir, Xct * tdir));
                    tvect = xct + Xct * tdir / tdist;
                end
                if tdist > dist
                    dist = tdist;
                    distv = tvect;
                end
                curpos = curpos + 1;
            end
            
            tres(i, j) = T(i);
            xres(i, j) = distv(1);%scalar_mult(distv, l1);
            yres(i, j) = distv(2);%scalar_mult(distv, l2);
        end
        tmp = convhull(xres(i, :), yres(i, :));
        if size(tmp, 1) < size(l, 1)
            q = size(tmp, 1);
            for j = (q + 1) : size(l, 1)
                tmp = [tmp; tmp(q)];
            end
        end
        xres(i, :) = xres(i, tmp);
        yres(i, :) = yres(i, tmp);
        pos = curpos;
    end
    
    hold on
    surf(tres, xres, yres, 'FaceAlpha', 0.5, 'FaceColor', c);
    xlabel('t');
    ylabel('l_1');
    zlabel('l_2');
end
