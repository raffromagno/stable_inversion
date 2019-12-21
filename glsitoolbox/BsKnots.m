
function [tk,Ln,Bit]=BsKnots(n_cp,d,Ns)
%  BSKNOTS B-spline parameter vector (tk) and knots vector (Ln)
%  OUTPUTS:
%  tk   - B-spline parameter vector;
%  Ln   - Knots Vector;
%  Bit  - B-spline functions, each column corresponds
%  INPUTS:
%  n_cp - number of control points
%    Ns - lenght of the parameter vector tk
%  
% author: Raffaele Romagnoli
% date  : 13/04/2017


k=1;
j=1;

n_knots=n_cp+d+1;

%% Knots Vector
Ln=zeros(1,n_knots);
for i=d+2:n_knots
    if i<n_knots-(d) 
       Ln(1,i)=k;
       k=k+j;
    else
        Ln(1,i)=k;
    end 
end
%% Parameter Vector 
tk=zeros(1,Ns);
for i=2:Ns
     tk(i)=tk(i-1)+Ln(n_knots)/Ns;
end
Bit=zeros(Ns,n_cp);
i_k=1;
for j=1:n_cp
    for i=1:Ns
        Bit(i,j)=BsFun(i_k,d,tk(i),Ln);
    end
    i_k=i_k+1;
end