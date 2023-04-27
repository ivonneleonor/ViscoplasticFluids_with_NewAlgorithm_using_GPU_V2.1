

! ****************************************************************************************
! ****************************************************************************************

function hgp(x, ecc)
! half gap width
	use param
	use Alg2Defs

	implicit none

	real*8:: x, ecc
	real*8:: hgp


	!hgp = 1.0d0 + ecc * dcos(Pi * x) 
        hgp = 1.0d0 + ecc * cos(Pi * x)

end function hgp

! ****************************************************************************************
! ****************************************************************************************

function signA(x)

	implicit none


	real*8:: x, signA

	if (x < 0.0d0) then
	
		signA = -1.0d0
	elseif (x>0.d0) then
		signA = 1.0d0
	else
		signA = 0.d0
	endif

end function signA



! ****************************************************************************************
! ****************************************************************************************


subroutine BigF(modpg, halfgap, yieldstress, consistency, invpowerindex,epsilon,gradapsi)
! Modified Pressure Gradient -> | gradient of stream function | 

	use Alg2Defs

	implicit none


	real*8:: modpg,  halfgap, yieldstress, consistency, invpowerindex, epsilon, gradapsi
	real*8:: yieldcriterion, absg

	absg = dabs(modpg);
	yieldcriterion = absg*halfgap - yieldstress;
	if (yieldcriterion <= 0.0d0) then
		gradapsi = epsilon*absg;
	else
		gradapsi = epsilon*absg + yieldcriterion* &
			((invpowerindex+1.0d0)*halfgap*absg+yieldstress)* &
			(yieldcriterion/consistency)**invpowerindex/ &
			((invpowerindex+1.0d0)*(invpowerindex+2.0d0)*absg**2);
	endif

	if (modpg < 0.0d0) then
		gradapsi = - (gradapsi)
	endif

end subroutine BigF

! ****************************************************************************************
! ****************************************************************************************

subroutine InverseBigF(gradapsi, halfgap, yieldstress, consistency, invpowerindex, epsilon, modpg)
! | gradient of stream function | -> Modified Pressure Gradient

	use Alg2Defs

	implicit none


	real*8:: gradapsi, halfgap, yieldstress, consistency, invpowerindex, epsilon, modpg

	real*8:: yieldcriterion,const1,const2,const3,const4,absgradpsi;
	real*8:: xstepn, xstepnpo, deltaxx;
	real*8:: fxstepn,fpxstepn,gleft,grite,fleft,frite;
	integer:: count;

	absgradpsi = dabs(gradapsi);

	!  Check if flow yielded or not
	yieldcriterion = absgradpsi - epsilon*yieldstress/halfgap;
	if (yieldcriterion <= 0.0d0) then	
		if (epsilon == 0.0d0) then
			modpg = 0.0d0;
		else
			modpg = absgradpsi/epsilon;
		endif
	else
		!  Above yield stress - invert numerically
		! 	Attempt 1: Newtons method: get an initial condition for 
		! 	iteration from lower bound for G
		const1 = (invpowerindex + 1.0d0)*yieldcriterion/halfgap/halfgap;
		gleft = consistency/halfgap*(const1**(1.0d0/invpowerindex)) + &
		 yieldstress/halfgap;

		!  set initial guesss
		xstepn = gleft;
		deltaxx = 10.0d0;
		count = 0;

		const2 = halfgap*halfgap*(halfgap/consistency)**invpowerindex/ &
					((invpowerindex+1.0d0)*(invpowerindex+2.0d0));
		const3 = yieldstress/halfgap;

		do while ((deltaxx > INV_TOL) .and. (count < 50))
			count = count + 1;

			const4 = (xstepn-const3)**invpowerindex
			fxstepn = epsilon*xstepn + const2*(1.0d0-const3/xstepn)* &
					( (invpowerindex+1.0d0) + const3/xstepn)*const4 - absgradpsi;
			fpxstepn = epsilon + const2*const4/xstepn*((invpowerindex+1.0d0)* &
				   invpowerindex + 2.0d0*invpowerindex*const3/xstepn +  &
				    2.0d0*const3*const3/xstepn/xstepn);

			xstepnpo = xstepn - fxstepn/fpxstepn;

			deltaxx = dabs(xstepnpo - xstepn);
			xstepn = xstepnpo;
		enddo
		if (count < 50) then
			modpg = xstepn;
		else
			!  use Regula Falsi method
			deltaxx = 10.0d0;
			count = 0;
			!  get upper bound for g to bracket root
			const2 = (consistency/yieldstress)**invpowerindex
			const3 = 1.0d0/(1.0d0+invpowerindex);
			const4 = const2**const3
			grite = yieldstress/halfgap* &
					(const4 + (const4*const4+4.0d0)**0.5d0)* &
					(const4 + (const4*const4+4.0d0)**0.5d0)/4.0d0

			call BigF(gleft,halfgap,yieldstress,consistency,invpowerindex, &
							epsilon,fleft);
			fleft = fleft - absgradpsi;
			call BigF(grite,halfgap,yieldstress,consistency,invpowerindex, &
							epsilon,frite);
			frite = frite - absgradpsi;

			do while ((deltaxx > INV_TOL) .and. (count < 50))
				count = count + 1;
				xstepn = (gleft*frite-grite*fleft)/(frite-fleft);

				call BigF(xstepn,halfgap,yieldstress,consistency,invpowerindex, &
						epsilon,fxstepn);
				fxstepn = fxstepn - absgradpsi;

				if (fxstepn > 0.0d0) then
					grite = xstepn;
					frite = fxstepn;
				else
					gleft = xstepn;
					fleft = fxstepn;
				endif
				deltaxx = dabs(gleft-grite)
			enddo
			modpg = xstepn;
		endif
	endif
	if (gradapsi < 0.0d0) then
		modpg = -1.0d0*(modpg);
	endif

end subroutine InverseBigF


! ****************************************************************************************
! ****************************************************************************************


subroutine BigXi(gradapsi, halfgap, yieldstress, consistency, &
				invpowerindex, epsilon, modpg)

	use Alg2Defs

	implicit none


	real*8:: gradapsi, halfgap, yieldstress, consistency
	real*8:: invpowerindex, epsilon, modpg

	real*8:: rtrnGfromFinv

	if (gradapsi <= 0) then
		modpg = 0;
	else
		call InverseBigF(gradapsi, halfgap, yieldstress, consistency, &
		      invpowerindex, epsilon, rtrnGfromFinv);
		modpg = rtrnGfromFinv - yieldstress / halfgap;
	endif

end subroutine BigXi


! ****************************************************************************************
! ****************************************************************************************


subroutine dFdG(modpg, halfgap, yieldstress, consistency, invpowerindex, &
				epsilon, gradient)

	use Alg2Defs

	implicit none


	real*8:: modpg, halfgap, yieldstress, consistency
	real*8:: invpowerindex, epsilon, gradient

	real*8:: yieldcriterion,absg;

	absg = dabs(modpg);
	yieldcriterion = absg*halfgap - yieldstress;
	if (yieldcriterion <= 0.0d0) then
		gradient = 0;
	else
		gradient = ((yieldcriterion/consistency)**invpowerindex) * & 
		 	( (invpowerindex * (invpowerindex + 1.0d0) * yieldcriterion **2) &
		 	+ (2.0d0 * invpowerindex * (invpowerindex + 2.0d0) *  &
		    yieldstress * yieldcriterion) &
		 	+ ((invpowerindex + 1.0d0) * (invpowerindex + 2.0d0) * yieldstress **2) ) &
		 	/ ((invpowerindex + 1.0d0) * (invpowerindex + 2.0d0) * absg **3)
	endif

end subroutine dFdG


! ****************************************************************************************
! ****************************************************************************************
