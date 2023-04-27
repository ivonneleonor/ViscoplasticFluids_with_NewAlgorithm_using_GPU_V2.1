

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
!Modification of the algorithm, we reduce the nested calculation and change root finder, bisection instead of Newton method

	use Alg2Defs

	implicit none


	real*8:: gradapsi, halfgap, yieldstress, consistency, invpowerindex, epsilon, modpg

	real*8:: yieldcriterion,const1,const2,const3,const4,absgradpsi;
	real*8:: xstepn, xstepnpo, deltaxx;
	real*8:: fxstepn,fpxstepn,gleft,grite,fleft,frite;
        real*8:: aside,bside,cside,signchecka,signcheckb,faxstepn,fbxstepn,fcxstepn,deltabis,deltabis2;
        real*8:: const4a,const4b,const4c,signcheckc;
	integer:: count,count2,i,n;
        real*8, dimension(10) :: vector,vectorf

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
		! 	Bisection method: get an initial condition for 
		! 	iteration from lower bound for G
		const1 = (invpowerindex + 1.0d0)*yieldcriterion/halfgap/halfgap;
		gleft = consistency/halfgap*(const1**(1.0d0/invpowerindex)) + &
		 yieldstress/halfgap;

		!  set initial guesss
		xstepn = gleft;
		deltaxx = 10.0d0;
                deltabis = 0.2d0;
		count = 0;
                count2 = 0;

                const2 = halfgap*halfgap*(halfgap/consistency)**invpowerindex/ &
                                        ((invpowerindex+1.0d0)*(invpowerindex+2.0d0));
                const3 = yieldstress/halfgap;

!                print *,"gleft", gleft;

                 
               !  aside=gleft;
               !  bside=gleft+deltabis;
               aside=0.493d0;
               bside=0.494d0;
                 cside=(aside+bside)/2.0d0;
   !             print *,"Bisection starts with this values"
   !             print *,"aside",aside
   !             print *,"bside",bside
   !             print *,"cside",cside


                do while ((deltabis > INV_TOL) .and. (count2 < 50))
                         count2 = count2 + 1;
!                         print *,"count2",count2
                         cside=(aside+bside)/2.0d0;
                         const4a =(dabs(aside-const3))**invpowerindex
                         const4b =(dabs(bside-const3))**invpowerindex
                         const4c =(dabs(cside-const3))**invpowerindex

  !                       print*,"const4a",const4a
  !                       print*,"const4b",const4b
  !                       print*,"const4c",const4c
                        
  !                      print *,"invpowerindex",invpowerindex
  !                      print *,"const3",const3 
  !                      print *,"aside",aside
  !                      print *,"bside",bside
  !                      print *,"cside",cside


                        faxstepn = epsilon*aside + const2*(1.0d0-const3/aside)* &
                                        ( (invpowerindex+1.0d0) + const3/aside)*const4a - absgradpsi;
                        fbxstepn = epsilon*bside + const2*(1.0d0-const3/bside)* &
                                        ( (invpowerindex+1.0d0) + const3/bside)*const4b - absgradpsi;
                        fcxstepn = epsilon*cside + const2*(1.0d0-const3/cside)* &
                                        ( (invpowerindex+1.0d0) + const3/cside)*const4c - absgradpsi;
                      
                        deltabis=(bside-aside)/10.d0;
                       ! do i=1,10 
                       !    vector(i) =aside+ deltabis*i;
                       !    print *,"vector(i)",vector(i);     
                       ! enddo
                       ! do i=1,10
                       !    const4 = dabs((vector(i)-const3))**invpowerindex
                       !    vectorf(i) = epsilon*vector(i) + const2*(1.0d0-const3/vector(i))* &
                       !                 ( (invpowerindex+1.0d0) + const3/vector(i))*const4 - absgradpsi;
                          ! write(*,44)"vectorf(i)",vectorf(i);
                       !    print *,"vectorf(i)",vectorf(i);
                       ! enddo




                        IF(faxstepn>0)THEN
                                signchecka=1;
                        ELSE
                                signchecka=-1;
                        END IF
                        IF(fbxstepn>0)THEN
                                signcheckb=1;
                        ELSE
                                signcheckb=-1;
                        END IF
                        IF(fcxstepn>0)THEN
                                signcheckc=1;
                        ELSE
                                signcheckc=-1;
                        END IF 
                               
!                        print *,"faxstepn",faxstepn
!                        print *,"fbxstepn",fbxstepn
!                        print *,"fcxstepn",fcxstepn

                       ! signchecka=sign(1,faxstepn);
                       ! signcheckb=sign(1,fbxstepn);
                       ! signcheckc=sign(1,fcxstepn);

!                        print *,"signchecka", signchecka;
!                        print *,"signcheckb", signcheckb;
!                        print *,"signcheckc", signcheckc;

                        IF (signchecka==signcheckb)THEN
 !                               print *,"signchecka==signcheckb bisection exit"
                                exit
                        END IF

                        IF (signchecka==signcheckc) THEN
                                aside=cside;
                        ELSE
                                bside=cside;
                        END IF
                        
                        !deltabis=dabs(fcxstepn);
                        !print *,"deltabis", deltabis;
                        deltabis=dabs(aside-bside)/2.d0;
 !                       print *,"deltabis", deltabis;


                enddo

                modpg = cside;
                !print *,"Final value of bisection method cside", cside;
               ! print *, signcheckb;
               ! print *, gleft;
                !print *, aside;
                !print *, bside;

		!const2 = halfgap*halfgap*(halfgap/consistency)**invpowerindex/ &
				!	((invpowerindex+1.0d0)*(invpowerindex+2.0d0));
		!const3 = yieldstress/halfgap;

!		do while ((deltaxx > INV_TOL) .and. (count < 50))
!			count = count + 1;

!			const4 = (xstepn-const3)**invpowerindex
 !                       print *,"In Newton"
                       ! print *,"xstepn",xstepn
                       ! print *,"const4",const4
                       ! print *,"invpowerindex",invpowerindex
!			fxstepn = epsilon*xstepn + const2*(1.0d0-const3/xstepn)* &
!					( (invpowerindex+1.0d0) + const3/xstepn)*const4 - absgradpsi;
!			fpxstepn = epsilon + const2*const4/xstepn*((invpowerindex+1.0d0)* &
!				   invpowerindex + 2.0d0*invpowerindex*const3/xstepn +  &
!				    2.0d0*const3*const3/xstepn/xstepn);

!			xstepnpo = xstepn - fxstepn/fpxstepn;

!			deltaxx = dabs(xstepnpo - xstepn);
!			xstepn = xstepnpo;
!		enddo
 !               print *,"count",count
  !              print *,"deltaxx",deltaxx
   !             print *,"Final answer in Newton xstepn",xstepn;
    !            modpg = cside;
                !modpg = xstepn;

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
