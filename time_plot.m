Ns = [10 20 30 40 50 70 100]
Tmat = [0.99 8.44 39.1 145.5 800 4233 15430]
Tkron = [0.16 2.9 18.5 88 791 6301 28123]

hold on;
plot(Ns, Tmat)
plot(Ns, Tkron, 'r')
xlabel('n');
ylabel('t, sec');
