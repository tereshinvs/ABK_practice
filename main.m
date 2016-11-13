clear
warning('off','all')
global N Nu T0 T1 A B x1 X1 p P dT options l dphi

% N_ = 40;
% Nu_ = 1;
% 
% T0 = 0;
% T1 = 1;
% dT = 1;
% 
% M = eye(N_, Nu_);
% IN_ = eye(N_);
% 
% T = @(t) IN_;
% B_ = @(t) M;
% 
% q0 = IN_;
% Q0 = @(Q) IN_ * Q;
% 
% p_ = [1];
% P_ = @(p) p;
% 
% options = odeset('RelTol', 1e-3,'AbsTol', 1e-3);
% 
% k = 1;
% l = generate_k_symmetric_positive_definite_matrices(k, N_);
% 
% 
% Aop = @(Q) @(t) T(t) * Q + Q * T(t)';
% Bop = @(U) @(t) B_(t) * U * B_(t)';
% Q0op = @(Q) @(t) Q0(Q);
% Pop = @(p) @(t) P_(p);
% 
% Ao = op2mat(Aop, N_, N_);
% Bo = op2mat(Bop, Nu_, N_);
% Q0o = op2mat(Q0op, N_, N_);
% Po = op2mat(Pop, Nu_, Nu_);
% 
% N = N_ * N_;
% Nu = Nu_ * Nu_;
% A = Ao;
% B = Bo;
% x1 = mat2vec(q0);
% X1 = Q0o(0);
% p = @(t) mat2vec(p_);
% P = Po;
% 
% Ts = T0 : dT : T1;
% tic();
% [Te, xc, Xc] = static_projection(l, Ts, dphi);
% t_mat = toc();
% 
% N = N_ * N_;
% Nu = Nu_ * Nu_;
% Iq = eye(N_);
% A = @(t) kron(T(t), Iq) + kron(Iq, T(t));
% B = @(t) kron(B_(t), B_(t));
% x1 = mat2vec(q0);
% Q0op = @(Q) @(t) Q0(Q);
% Q0repr = repr(Q0op, N_, N_);
% Q0o = rep2mat(Q0repr, N_, N_);
% X1 = Q0o(0);
% p = @(t) mat2vec(p_);
% Pop = @(p) @(t) P_(p);
% Prepr = repr(Pop, Nu_, Nu_);
% Po = rep2mat(Prepr, Nu_, Nu_);
% P = Po;
% 
% Ts = T0 : dT : T1;
% tic();
% [Te, xc, Xc] = static_projection(l, Ts);
% t_kron = toc();


N_ = 2;
Nu_ = 1;

T0 = 0;
T1 = 20;
dT = 1;

T = @(t) cos(t) * [5 -7; 3 -4];
B_ = @(t) sin(t) * [1; -1];

q0 = [1 0; 0 1];
Q0 = @(Q) [2 1; 1 2] * Q;

p_ = [1];
P_ = @(p) 2 * p;

options = odeset('RelTol', 1e-6,'AbsTol', 1e-6);

k = 10;
l = generate_k_symmetric_positive_definite_matrices(k, N_);

l1 = [1; 0];
l2 = [0; 1];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Aop = @(Q) @(t) T(t) * Q + Q * T(t)';
Bop = @(U) @(t) B_(t) * U * B_(t)';
Q0op = @(Q) @(t) Q0(Q);
Pop = @(p) @(t) P_(p);

% Arepr = repr(Aop, N_, N_);
% Brepr = repr(Bop, Nu_, N_);
% Q0repr = repr(Q0op, N_, N_);
% Prepr = repr(Pop, Nu_, Nu_);

% Ao = rep2mat(Arepr, N_, N_);
% Bo = rep2mat(Brepr, Nu_, N_);
% Q0o = rep2mat(Q0repr, N_, N_);
% Po = rep2mat(Prepr, Nu_, Nu_);

Ao = op2mat(Aop, N_, N_);
Bo = op2mat(Bop, Nu_, N_);
Q0o = op2mat(Q0op, N_, N_);
Po = op2mat(Pop, Nu_, Nu_);

N = N_ * N_;
Nu = Nu_ * Nu_;
A = Ao;
B = Bo;
x1 = mat2vec(q0);
X1 = Q0o(0);
p = @(t) mat2vec(p_);
P = Po;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ts = T0 : dT : T1;
tic();
[Te, xc, Xc] = static_projection(l, Ts);
t_mat = toc();
%plot_static_reach_tube(Ts, Te, xc, Xc, l, 0.1, 'r');
plot_static_ell0Q(Ts, Te, xc, Xc, l, l1, l2, 0.1, 'r');
return;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N = N_ * N_;
Nu = Nu_ * Nu_;
Iq = eye(N_);
A = @(t) kron(T(t), Iq) + kron(Iq, T(t));
B = @(t) kron(B_(t), B_(t));
x1 = mat2vec(q0);
Q0op = @(Q) @(t) Q0(Q);
Q0repr = repr(Q0op, N_, N_);
Q0o = rep2mat(Q0repr, N_, N_);
X1 = Q0o(0);
p = @(t) mat2vec(p_);
Pop = @(p) @(t) P_(p);
Prepr = repr(Pop, Nu_, Nu_);
Po = rep2mat(Prepr, Nu_, Nu_);
P = Po;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ts = T0 : dT : T1;
tic();
[Te, xc, Xc] = static_projection(l, Ts);
t_kron = toc();
%plot_static_reach_tube(Ts, Te, xc, Xc, l, 0.1, 'g');
plot_static_ell0Q(Ts, Te, xc, Xc, l, l1, l2, 0.1, 'g');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_mat
t_kron

%delete(pool);
