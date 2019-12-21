# stable_inversion
Matlab toolbox for model stable inversion based on least squares
General Least Square Inversion toolbox - beta version

0 - Biblio:

[1]	R. Romagnoli and E. Garone. "A general framework for approximated model stable inversion." Automatica 101, pp. 182-189, 2019.


1 - Description:

The general least square inversion toolbox provides the basic m-functions (matlab-functions) for the computation of the approximated 
model stable inversion approach based on the least square and generalized basis functions [1].

The core of the toolbox is made by the m-functions:

 - coeffMatrix.m

 - PhiMatrix.m

 - PsiVector.m

 - measVector.m

 - leastSqauresInversion.m

Those  m-functions can be used for any basis function involved to compute the stable inversion.

In this toolbox there are implemented three basis functions:

 - Bsplines    : BsKnots.m -> BsFun.m -> Bid.m

 - Sin x / x   : Sit.m  

 - Piece-wise polynomials (3rd order) : Pit.m,null_space_3rd.m 

There are three demos, one for each kind of basis function

 - demo_bs_pi.m      (Bspline)

 - demo_sin_pi.m     (Sinx/x)

 - demo_poly_pi.m    (Polynomials)

applied to the case of a 2 link robot with flexible forearm.

 - robot2link.m

See [1] for more details. Note that, in the above examples 64 basis functions for each
input have been considered over a finite time interval [0,10s]. 


2 - Requirements:

MATLAB 

 - Fuzzy logic toolbox  (smf function)

 - Signal Processing toolbox (sinc function)


3 - Further details:

The toolbox has been tested using MATLAB 9.2.0.538062 (R2017a)
using a CPU Intel(R) Core(TM) i7-6700HQ 2.60 GHz. 

The computation of the convolution integrals (coeffMatrix.m)
represents the most expensive procedure in terms of computation
costs.  

This function is implemented offline and it may take several 
minutes for providing its results.

The proposed method is an off-line method.


4 - Contacts:

Raffaele Romagnoli   overaffo@gmail.com
