
function  B=BsFun(i,d,t,Ln)
%BSFUN Computes the value of the B-spline function (Cox - De Boor Algorithm)
%OUTPUT:
%   B - B-spline function value
%INPUTS:
%   i - index of the interval
%   d - B-spline order
%   t - parameter
%  Ln - knots vector
%  
% author: Raffaele Romagnoli
% date  : 13/04/2017

if d==0
   if t>=Ln(i) && t<Ln(i+1)
      B=1;
   else
      B=0; 
   end
else
   if  (Ln(d+i)-Ln(i))==0 
       a=0;
   else
       a=((t-Ln(i))/(Ln(d+i)-Ln(i)));
   end
   if (Ln(d+i+1)-Ln(i+1))==0
       b=0;
   else
       b=((Ln(d+i+1)-t)/(Ln(d+i+1)-Ln(i+1)));
   end
   B=a*BsFun(i,d-1,t,Ln)+...
          b*Bid(i+1,d-1,t,Ln);    
    
end
