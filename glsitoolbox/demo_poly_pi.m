%% Example Generalized Approximated Model Stable Inversion using piecewise polynomials
% functions.
% 
%
% Author: Raffaele Romagnoli
% Date  : 07/02/2018
clc;

[sys1,n,r,q]=robot2link();    % 2 link robot model

Ts=0.01;                      % Integration step size (in seconds)


%% Initialization

% ------ -------------** CHANGE FOR TUNING **-------------------------
n_cp=16;         % Number of time intervals for each input
T_t=10;          % Time interval size [0,T_t] 
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


%% Piece-wise polynomial function of 3rd order withut continuity constraints
d=3;
n_cp1=n_cp*(d+1);          %number of basis functions for each input
Bit=Pit(n_cp,t1,T_t,d);

%% Pseudo Inversion

% ---Matrices that can be computed independently from the desired output---

% ------------------------------------------
tic
[Cb] = coeffMatrix(sys1,n_cp1,t1,Ns,Ts,Bit);  % comment this part if Cb and
tds=toc;
[ Phi ] = PhiMatrix( Cb,n_cp1,q,Ns,Ts);       % Phi are already computed

% -------------------------------------------

% --------------------------
% load('yourPhiCbfile.mat')    %uncomment this part if you have those files
% --------------------------

% ----- Vectors that must to be computed for every new desired output -----

[e_s] = measVector(sys1,Ns,ydo);
[ Psi ] = PsiVector(Cb,e_s,n_cp1,q,Ns,Ts);

% -- least square solution
[x,sp1] = leastSqauresInversion( Phi,Psi,n_cp1,q,Ns,Bit);

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
%% Continuity constraints

[Tu,Su]=null_space_3rd(n_cp,T_t);
T=[Tu zeros(size(Tu));zeros(size(Tu)) Tu];

[x1,sp2]=leastSqauresInversion( Phi,Psi,n_cp1,q,Ns,Bit,T);

y1=lsim(sys1,sp2,t1)+y_s;

%% Plots

% Inputs
figure
subplot(2,1,1)
plot(t1,sp2(1,:))
ylabel('u_t 1')
xlabel('Time - s')
subplot(2,1,2)
plot(t1,sp2(2,:))
xlabel('Time - s')
ylabel('u_t 2')

% Outputs
figure
subplot(2,1,1)
plot(t1,(180/pi)*y1(:,1))
xlabel('Time - s')
ylabel('y_1')
subplot(2,1,2)
plot(t1,(180/pi)*y1(:,2))
xlabel('Time - s')
ylabel('y_2')