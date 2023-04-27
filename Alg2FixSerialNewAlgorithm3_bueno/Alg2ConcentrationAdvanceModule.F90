module Alg2ConcentrationAdvanceModule
! variables 
	use Alg2Defs

	real*8, dimension(0:MaxI+3,0:MaxJ+3):: U ! H*c
	real*8, dimension(0:MaxI+3,0:MaxJ+3):: Cshift !c moved one half step
	real*8, dimension(0:MaxI+4,0:MaxJ+4):: v !azimuthal direction
	real*8, dimension(0:MaxI+4,0:MaxJ+4):: w !axial direction

	integer:: iAR, jAR !azimuthal and axial counters


end module Alg2ConcentrationAdvanceModule
