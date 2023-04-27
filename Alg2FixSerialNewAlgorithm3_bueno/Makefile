# 16/01/2007
#
.SUFFIXES: .F90 .o .mod
# find the compiler and put here
#F90 = gfortran
F90 = pgf90
#/usr/bin/gfortran
#LIBone = '/usr/lib/gcc/i686-pc-linux-gnu/4.2.0/'
allLIBS = 
FLAGS = -c -p 
#-ffree-form -ff2c 
#
#Alg2Fix.out: Alg2Fix
#	./Alg2Fix > Alg2Fix.out

Alg2Fix: Alg2Iterations.o\
 Alg2ConcentrationAdvance.o\
 Alg2ConcentrationAdvanceModule.o\
 Alg2FandXiCalculations.o Alg2Main.o\
 Alg2Definitions.o Alg2parameters.o\
 Alg2ReadParameters.o\
 Alg2IterationsModule.o
	$(F90) -o Alg2Fix Alg2Iterations.o\
 Alg2ConcentrationAdvance.o\
 Alg2ConcentrationAdvanceModule.o\
 Alg2FandXiCalculations.o Alg2Main.o\
 Alg2Definitions.o Alg2parameters.o\
 Alg2ReadParameters.o\
 Alg2IterationsModule.o
#
Alg2Definitions.o: Alg2Definitions.F90
	$(F90) $(allLIBS) $(FLAGS) Alg2Definitions.F90
#
Alg2parameters.o: Alg2parameters.F90
	$(F90) $(allLIBS) $(FLAGS) Alg2parameters.F90
#
Alg2ReadParameters.o: Alg2parameters.o Alg2ReadParameters.F90
	$(F90) $(allLIBS) $(FLAGS) Alg2ReadParameters.F90
#
Alg2ConcentrationAdvanceModule.o: Alg2Definitions.o Alg2ConcentrationAdvanceModule.F90
	$(F90) $(allLIBS) $(FLAGS) Alg2ConcentrationAdvanceModule.F90
#
Alg2IterationsModule.o: Alg2Definitions.o Alg2IterationsModule.F90
	$(F90) $(allLIBS) $(FLAGS) Alg2IterationsModule.F90
#
Alg2FandXiCalculations.o: Alg2parameters.o Alg2Definitions.o \
	Alg2FandXiCalculations.F90
	$(F90) $(allLIBS) $(FLAGS) Alg2FandXiCalculations.F90
#
Alg2Iterations.o: Alg2Definitions.o Alg2IterationsModule.o\
	Alg2FandXiCalculations.o Alg2parameters.o\
	Alg2ConcentrationAdvance.o\
	Alg2ConcentrationAdvanceModule.o \
	Alg2Iterations.F90
	$(F90) $(allLIBS) $(FLAGS) Alg2Iterations.F90
#
Alg2ConcentrationAdvance.o: Alg2parameters.o Alg2Definitions.o\
	Alg2ConcentrationAdvanceModule.o\
	Alg2ConcentrationAdvance.F90
	$(F90) $(allLIBS) $(FLAGS) Alg2ConcentrationAdvance.F90
#
Alg2Main.o: Alg2Definitions.o Alg2Iterations.o Alg2parameters.o\
	Alg2ConcentrationAdvance.o \
	Alg2Main.F90
	$(F90) $(allLIBS) $(FLAGS) Alg2Main.F90
#
clean:
	/bin/rm Alg2Fix *.o *.mod
