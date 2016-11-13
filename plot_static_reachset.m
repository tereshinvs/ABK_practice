function plot_static_reachset(xc, Xc, lt, dphi, c1, c2)
    global N
    hold on

    for i = 1 : size(xc, 1)
        xres = zeros(size(lt, 1));
        yres = zeros(size(lt, 1));
        xct = xc(i, :)';
        Xct = vec2mat(Xc(i, :), N, N)';
        for j = 1 : size(lt, 1)
            dir = lt(j, :)';
            tdist = sqrt(scalar_mult(inv(Xct) * dir, dir));
            vec2mat(Xct * dir, 2, 2)
            tvect = xct + dir / tdist
            xres(j) = tvect(1);%scalar_mult(tvect, l1m);
            yres(j) = tvect(2);%scalar_mult(tvect, l2m);
        end

        plot(xres, yres, c2);
        %plot(scalar_mult(xct, l1m), scalar_mult(xct, l2m));
    end

    xres = zeros(size(lt, 1));
    yres = zeros(size(lt, 1));

    for j = 1 : size(lt, 1)
        dir = lt(i, :)';
        dist = 0;
        distv = dir;
            
        for i = 1 : size(xc, 1)
            xct = xc(i, :)';
            Xct = vec2mat(Xc(i, :), N, N)';
            tdir = inv(Xct) * dir;
            tdist = sqrt(scalar_mult(tdir, dir));
            tvect = xct + dir / sqrt(scalar_mult(tdir, dir));
            if tdist > dist
                dist = tdist;
                distv = tvect;
            end
        end
            
        xres(j) = distv(1);%scalar_mult(distv, l1m);
        yres(j) = distv(2);%scalar_mult(distv, l2m);
    end

    plot(xres, yres, c1);
end
