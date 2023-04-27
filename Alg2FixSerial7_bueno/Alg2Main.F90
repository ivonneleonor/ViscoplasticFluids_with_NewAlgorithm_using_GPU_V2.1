
program Alg2Fix

        use Alg2Defs
	use param

	implicit none

	auxtime = timeinterval

!	print *, '    '

!	print *, '   '
!	read parameters from text file
!	call readparameters
!	print *, ' '
!	print *, ' '
!	print *, 'COMPUTING 2-D... please wait. '


!	write parameters to text file
!	if (Imoving == 1) then
!		open(88,file='./Mparam.txt',status='replace')
!	else
!		open(88,file='./param.txt',status='replace')
!	endif
!	write(88,*) kappa1, kappa2
!	write(88,*) rho1, rho2
!	write(88,*) m1, m2
!	write(88,*) tau1, tau2
!	write(88,*) e, beta
!	write(88,*) StStar, timeinterval
!	close(88)

	if (Imoving == 1) then
		open(36,file = 'MMeshSize.txt',status = 'replace')
	else
		open(36,file = 'MeshSize.txt',status = 'replace')
	endif
	write(36,*) MaxI, MaxJ, deltaX, deltaY

	close(36)

	if (Imoving == 1) then
		open(35,file = './MStream.txt',status = 'replace')
                open(37,file = './MStream.txt',status = 'replace')
	else
		open(35,file = './Stream.txt',status = 'replace')
                open(37,file = './Stream2.dat',status = 'replace')
	endif
	call RunTimeAdvance
	close(35)
        close(37)
!	print*, 'Run Alg2Fix.m in matlab to see figures...'


end program Alg2Fix



