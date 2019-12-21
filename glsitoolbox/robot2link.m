
function [sys1,n,r,q] = robot2link()
%ROBOT2LINK returns the closed loop matrices of a two-link robot with a
%flexible forearm, and the dimensions of the state, inputs and outputs
%The controller is computed as in
%
%  -M.T. Hussein, M.N. Nemah "Control of a two-link (rigid-flexible) manipulator"
%   International Conference on Robotics and Mechatronics (ICROM), 2015
%
%  -De Luca, Lanari, Lucibello, Panzieri and Ulivi "Control experiments on a 
%   two-link robot with a flexible forearm". IEEE CDC 1990.
%
%OUTPUTS:
%    sys1: structure of the closed loop system;
%       n: state dimension
%       r: inputs dimension
%       q: outputs dimension
% Author: Raffaele Romagnoli
% Date 06/02/2018


M=[1.14 0.498 0.336 0.195;...
   0.498 0.303 0 0;...  
   0.336 0  1 0;...
   0.195 0 0 1];
K_dd=[878.03 0;...
      0 8180.6];
w1=4.716*2*pi; w2=14.395*2*pi; 
D_dd=[2*0.07*w1 0;...
      0 2*0.03*w2];
Kd=[zeros(2) zeros(2);zeros(2) K_dd];  
Dd=[zeros(2) zeros(2);zeros(2) D_dd];

A=[zeros(4) eye(4);-inv(M)*Kd -inv(M)*Dd];

phi1_0=5.74; phi2_0=11.64;
phi1_l=-1.446; phi2_l=1.369;

G=[1 0;0 1;0 phi1_0;0 phi2_0];
    
B=[zeros(4,2);inv(M)*G];

C1=[1 0 0 0;1 1 (phi1_l/0.7-phi1_0) (phi2_l/0.7-phi2_0)];

C=[C1 zeros(2,4)];

%% Controller

Km=[11.5 0 0 0 2 0 0 0;...
     0 6 0 0 0 0.8 0 0];
%% Closed Loop system
A_cl=A-B*Km;
B_cl=B;
C_cl=C;
  
ss_cl=ss(A_cl,B_cl,C_cl,zeros(2));            
Dc=dcgain(ss_cl);                  % Dc gain computation
B_cl1=B*inv(Dc);                   % Input normalization
D_cl=zeros(2);
n=size(A_cl,2); r=size(B_cl1,2); q=size(C_cl,1);

sys1=ss(A_cl,B_cl1,C_cl,zeros(2));
