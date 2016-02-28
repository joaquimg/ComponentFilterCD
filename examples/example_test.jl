#cd("C:/Users/LabOpto/Documents/SmartGit Projects/src")
# using Debug
using PyPlot

include("../src/CDtypes.jl")
include("../src/initializations.jl")
include("../src/CDmainAlg.jl")
include("../src/GetResult.jl")
include("../src/GramMatrix.jl")
include("../src/InnerProducts.jl")
include("../src/Normalization.jl")
include("../src/utils.jl")

#y=readcsv("C:/Users/LabOpto/Documents/SmartGit Projects/TestBench.csv")

#y=readcsv("C:/Users/LabOpto/Documents/SmartGit Projects/TestBench.csv")
y = ones(10)

run = 6

if run == 1
	##TESTE STEP + SPIKE
	@time BCD,β1,β2 = CD(y,[1,2], numλ = 100)
	a = β1[1] + β1[2]
	b = β2[1] + β2[2]
	plot(a)
	plot(b)
	writecsv("C:/Users/LabOpto/Documents/SmartGit Projects/ResultsJulia1.csv",a)
	writecsv("C:/Users/LabOpto/Documents/SmartGit Projects/ResultsJulia2.csv",b)
end

if run == 2
	##TESTE SLOPE
	@time BCD,β1,β2 = CD(y,[3], numλ = 100)
	a = β1[3]
	b = β2[3]
	plot(a)
	plot(b)
	writecsv("C:/Users/LabOpto/Documents/SmartGit Projects/ResultsJulia1.csv",a)
	writecsv("C:/Users/LabOpto/Documents/SmartGit Projects/ResultsJulia2.csv",b)
end

if run == 3
	##TESTE STEP + SPIKE + SLOPE
	@time BCD,β1,β2 = CD(y,[1,2,3], numλ = 100)
	a = β1[1] + β1[2] + β1[3]
	b = β2[1] + β2[2] + β2[3]
	plot(a)
	plot(b)
	writecsv("C:/Users/LabOpto/Documents/SmartGit Projects/ResultsJulia1.csv",a)
	writecsv("C:/Users/LabOpto/Documents/SmartGit Projects/ResultsJulia2.csv",b)
end

if run == 4
	##TESTE STEP + SLOPE
	@time BCD,β1,β2 = CD(y,[1,3], numλ = 100)
	a = β1[1] + β1[3]
	b = β2[1] + β2[3]
	plot(a)
	plot(b)
	writecsv("C:/Users/LabOpto/Documents/SmartGit Projects/ResultsJulia1.csv",a)
	writecsv("C:/Users/LabOpto/Documents/SmartGit Projects/ResultsJulia2.csv",b)
end

if run == 5
	##TESTE SPIKE + SLOPE
	@time BCD,β1,β2 = CD(y,[2,3], numλ = 100)
	a = β1[2] + β1[3]
	b = β2[2] + β2[3]
	plot(a)
	plot(b)
	writecsv("C:/Users/LabOpto/Documents/SmartGit Projects/ResultsJulia1.csv",a)
	writecsv("C:/Users/LabOpto/Documents/SmartGit Projects/ResultsJulia2.csv",b)
end

if run == 6
	## WARNING!!!!
	## problem with cos and (step or slope)
	t = 1:1000
	y= sin(2*pi*t/10)+sin(2*pi*t/5)+cos(2*pi*t/10)
	f = 2*pi./collect(5:10)
	@time BCD,β1,β2 = l1_adaptive_trend_filter(y,[1,4,5], numλ = 40, f = f)
	#@time  CD(y,[1,2,3,4,5], numλ = 100, f = f)
	#a = β1[4]
	#b = β2[4]
	#plot(a)
	#plot(b)
	#writecsv("C:/Users/LabOpto/Documents/SmartGit Projects/ResultsJulia1.csv",a)
	#writecsv("C:/Users/LabOpto/Documents/SmartGit Projects/ResultsJulia2.csv",b)
end
