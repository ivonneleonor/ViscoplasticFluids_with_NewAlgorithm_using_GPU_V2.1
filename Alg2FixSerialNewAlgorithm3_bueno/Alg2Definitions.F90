module Alg2Defs
! Module to define global variables for Alg2
	implicit none


!have to have deltaX * MaxI = 1.0
	real*8, parameter::  deltaX = 0.1666d0 !stepsize in phi - direction
	integer, parameter:: MaxI = 6 !no of steps in the phi - direction

! From non-dimensionalization:
! z(non-dim. at top hole) = 2 * dim. length of well/(Pi * (r_o + r_i))
! all of these are fixed for your flow loop
	real*8, parameter:: deltaY = 3.26d0 !stepsize in z- direction
	integer, parameter:: MaxJ = 6 !no of steps in z- direction

! Compute in moving or fixed frame?
	integer, parameter:: Imoving = 0

! CFL condition: deltaT ~ Ccfl /wmax * deltaY 
	real*8, parameter:: CFL = 0.2d0 !CFL no.

	real*8, parameter:: epsi = 0.0d0 !regularization param
	real*8, parameter:: ACDG = 9.8d0 !acceleration due to gravity 9.8 m/sec^2

	real*8, parameter:: ron = 1.0d0 !overelaxation params
	real*8, parameter:: orp = 1.0d0 !overelaxation params
	real*8, parameter:: sor = 1.4d0 !sor overelaxation params

	integer, parameter:: NoOfIterationsInGS = 50 !max no. of iterations in Laplace solver (AdvanceU)
	integer, parameter:: NoOfIterationsInInversion = 40 !max number of steps in N-R inversion (AdvanceP)
	integer, parameter:: NoOfIterationsInAlg2FirstPass = 100 
	integer, parameter:: NoOfIterationsInAlg2SubsequentPass = 30


	real*8, parameter:: ToleranceInGS = 1.0E-6 !tolerance for the poisson's solver in AdvanceU
	real*8, parameter:: INV_TOL	= 1.0e-7	! in Alg2MDFandXiCalculations

	real*8:: deltaT			! time step set up in UVWextract
	real*8:: run_time		! defined in Alg2MDIterations - how many units of time should be ran

	real*8, dimension( 0:1, 0:MaxI+2, 0:MaxJ+2):: pn
	real*8, dimension( 0:MaxI+1, 0:MaxJ+1):: un, PsiS
	real*8, dimension(0:MaxI+2,0:MaxJ+2):: c
	real*8, dimension(0:1,0:MaxI+2,0:MaxJ+2):: g
	real*8, dimension( 0:1, 0:MaxI+2, 0:MaxJ+2):: lambdan
	real*8, dimension( 0:1, 0:MaxI+2, 0:MaxJ+2):: lnm1, pnm1 ! lambda(n-1), p(n-1)

end module Alg2Defs

