module Alg2IterationsModule

	use Alg2Defs

	implicit none

	real*8, parameter:: INV_TOL2	= 1.0e-6

	real*8:: G0, GL ! values of modified pressure gradient (MPG) at z=0 and z=L
	real*8, dimension(MaxI+1):: psi0, psiL ! Stream function Psi at z=0 amd z=L

	integer:: i, j; ! general counters


end module Alg2IterationsModule
