%% Example Generalized Approximated Model Stable Inversion using Bsplines
% 
% 
%
% Author: Raffaele Romagnoli
% Date  : 07/02/2018
clc;

[sys1,n,r,q]=robot2link();

Ts=0.01;          % Integration step size (in seconds)

%% Initialization

% ------ -------------** CHANGE FOR TUNING **-------------------------
n_cp=64;         % Number of basis functions for each input
T_t=10;           % Time interval size [0,T_t] 
%---------------------**-------------------**-------------------------

t1=0:Ts:T_t;      % Time vector
Ns=size(t1,2);    % number of samples

des1_deg=25;                   % Desired final angle of link 1
des2_deg=60;                   % Desired final angle of link2

des1_rad=des1_deg*pi/180;      % Deg/Rad conversion
des2_rad=des2_deg*pi/180;      % Deg/Rad conversion

%               ***********    WARNING   ***************
%      ** smf(sigmoid function) belongs to Fuzzy Logic Toolbox (FLT) **
yd=[des1_rad*smf(t1,[0 2]);... % Desired angle transitions 
    des2_rad*smf(t1,[0 2])];
% --------------************-------------****************------------------

%% Steady State Response
x0 = zeros(n,1);                                  % Initial state
u_s= [des1_rad*ones(1,Ns);des2_rad*ones(1,Ns);];  % Steady state input u_s
y_s= lsim(sys1,u_s,t1,x0);                        % Steady state input response

ydo= yd-y_s';                                     % Transient Desired output


%% Bsplines basis function
d=3;   % Bspline order 
[tk,Ln,Bit]=BsKnots(n_cp,d,Ns); % tk knots vector Ln knots control points
%% Pseudo Inversion


% ---Matrices that can be computed independently from the desired output---

% ------------------------------------------
tic
[Cb] = coeffMatrix(sys1,n_cp,t1,Ns,Ts,Bit);  % comment this part if Cb and
timebs=toc;
[ Phi ] = PhiMatrix( Cb,n_cp,q,Ns,Ts);       % Phi are already computed

% -------------------------------------------

% --------------------------
% load('yourPhiCbfile.mat')    %uncomment this part if you have those files
% --------------------------

% ----- Vectors that must to be computed for every new desired output -----

[e_s] = measVector(sys1,Ns,ydo);
[ Psi ] = PsiVector( Cb,e_s,n_cp,q,Ns,Ts);

% -- least square solution
[x,sp1] = leastSqauresInversion( Phi,Psi,n_cp,q,Ns,Bit);

y=lsim(sys1,sp1,t1)+y_s;

%% Plots

% Inputs
figure
subplot(2,1,1)
plot(t1,sp1(1,:))
ylabel('u_t 1')
xlabel('Time - s')
subplot(2,1,2)
plot(t1,sp1(2,:))
xlabel('Time - s')
ylabel('u_t 2')

% Outputs
figure
subplot(2,1,1)
plot(t1,(180/pi)*y(:,1))
xlabel('Time - s')
ylabel('y_1')
subplot(2,1,2)
plot(t1,(180/pi)*y(:,2))
xlabel('Time - s')
ylabel('y_2')
