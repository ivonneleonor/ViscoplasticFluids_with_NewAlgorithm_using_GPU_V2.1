FCFLAGS = -Mcuda=rdc  -fast -O3  –Mvect=fuse 
F90 = pgfortran

Alg2Fix:Alg2Main.cuf Alg2Iterations.o Alg2IterationsModule.o  Alg2ConcentrationAdvance.o Alg2ConcentrationAdvanceModule.o Alg2FandXiCalculations.o Alg2Definitions.o Alg2parameters.o Alg2IterationsParallel.o
	$(F90) $(FCFLAGS) $^ -o $@

Alg2Iterations.o: Alg2Definitions.o \
	Alg2IterationsModule.o \
	Alg2FandXiCalculations.o Alg2parameters.o\
	Alg2ConcentrationAdvance.o\
	Alg2ConcentrationAdvanceModule.o \
	Alg2Iterations.cuf
	$(F90)  $(FLAGS) -c $^ -o $@

Alg2IterationsParallel.o: Alg2Definitions.o \
	Alg2FandXiCalculations.o Alg2parameters.o\
	Alg2ConcentrationAdvance.o\
	Alg2ConcentrationAdvanceModule.o \
	Alg2IterationsParallel.cuf
	$(F90)  $(FLAGS) -c $^ -o $@

Alg2FandXiCalculations.o: Alg2parameters.o Alg2Definitions.o  Alg2FandXiCalculations.cuf
	$(F90)  $(FLAGS) -c $^ -o $@

Alg2ConcentrationAdvance.o:Alg2parameters.o Alg2Definitions.o\
	Alg2ConcentrationAdvanceModule.o Alg2ConcentrationAdvance.cuf
	$(F90)  $(FLAGS) -c $^ -o $@

Alg2ConcentrationAdvanceModule.o:Alg2Definitions.o  Alg2ConcentrationAdvanceModule.cuf
	$(F90)  $(FLAGS) -c $^ -o $@


Alg2IterationsModule.o:Alg2Definitions.o  Alg2IterationsModule.cuf
	$(F90)  $(FLAGS) -c $^ -o $@

Alg2Definitions.o: Alg2Definitions.cuf
	$(F90) $(FCFLAGS) -c $<

Alg2parameters.o: Alg2parameters.cuf
	$(F90)  $(FCFLAGS) -c $<

.PHONY: clean
clean:
	rm *.o *.mod


















