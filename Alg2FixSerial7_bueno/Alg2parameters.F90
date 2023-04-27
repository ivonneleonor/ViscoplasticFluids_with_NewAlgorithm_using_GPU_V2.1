module param
!	Module where the fluids parameters and others are defined
!	*********************************************************************************


	real*8, parameter :: pi = 3.1415926535897d0

!	*d parameters to be read from file
	real*8 :: StStar=0.05d0
	real*8 :: e = 0.0d0
	real*8 :: beta = 0.0d0
	real*8 :: tau1 = 0.9d0
	real*8 :: tau2 = 0.3d0
	real*8 :: m1 = 1.d0
	real*8 :: m2 = 1.42d0
	real*8 :: kappa1 = 0.0176d0
	real*8 :: kappa2 = 0.0492d0
	real*8 :: rho1 = 0.8d0
	real*8 :: rho2 = 1.0d0
	real*8 :: Qrof = 1.0d0

	real*8  :: timeinterval = 0.5d0	
	real*8  :: totaltime = 5.1d0

	integer :: printfunctions	! to print 2d simulations to file
	real*8 :: auxtime		! auxiliary to print to files

end module param

