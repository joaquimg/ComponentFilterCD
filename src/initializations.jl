include("CDtypes.jl")

#N=10
#IT = iterator(N,[1, 2],[10, 10, 0, 0, 0])

function initIT_range(N,components, f = Vector{Float64}(0) ; MAXITER=100)
	#components = Int[]
	nelements = zeros(Int,5)
	elements = Vector{Vector{Int}}(5)
	obs = N

	if STEP in components
		#push!(components,STEP)
		nelements[STEP] = N-1
		elements[STEP] = collect( 1:(N-1) )
	else
		nelements[STEP] = 0
		elements[STEP] = collect( 1:0 )
	end
	if SPIKE in components
		#push!(components,SPIKE)
		if ( STEP in components || SLOPE in components )
			nelements[SPIKE] = N-1
			elements[SPIKE] = collect( 1:(N-1) )
		else
			nelements[SPIKE] = N
			elements[SPIKE] = collect( 1:N )
		end
	else
		nelements[SPIKE] = 0
		elements[SPIKE] = collect( 1:0 )
	end
	if SLOPE in components
		#push!(components,SLOPE)
		nelements[SLOPE] = N-1
		elements[SLOPE] = collect( 1:(N-1) )
	else
		nelements[SLOPE] = 0
		elements[SLOPE] = 1:0
	end
	if SIN in components
		#push!(components,SIN)
		nelements[SIN] = size(f)[1]
		elements[SIN] = collect( 1:size(f)[1] )
	else
		nelements[SIN] = 0
		elements[SIN] = collect( 1:0 )
	end
	if COS in components
		#push!(components,COS)
		nelements[COS] = size(f)[1]
		elements[COS] = collect( 1:size(f)[1] )
	else
		nelements[COS] =  0
		elements[COS] = collect( 1:0 )
	end

	out = iterator(obs,components,elements,nelements,ones(Bool,TOTALCOMPONENTS),sum(nelements),MAXITER)

	return out
end

function initSparse(IT)
	BCD = Array{SparseMatrixCSC{Float64,Int},1}[]

	beta_tilde = SparseMatrixCSC{Float64,Int}[]
	beta = SparseMatrixCSC{Float64,Int}[]

	activeSet = SparseMatrixCSC{Bool,Int}[]

	for i in 1:5

		if i in IT.components

			push!(beta_tilde,spzeros(IT.nelements[i],1))
			push!(beta,spzeros(IT.nelements[i],1))
			push!(activeSet,spzeros(Bool,IT.nelements[i],1))

		else

			push!(beta_tilde,spzeros(0,0))
			push!(beta,spzeros(0,0))
			push!(activeSet,spzeros(Bool,0,0))

		end

	end

	return BCD,beta_tilde,beta,activeSet
end

function initDense(IT)
	BCD = Array{Vector{Float64},1}[]

	beta_tilde = Vector{Float64}[]
	beta = Vector{Float64}[]

	activeSet = Vector{Bool}[]

	for i in 1:5

		if i in IT.components

			push!(beta_tilde,zeros(IT.nelements[i]))
			push!(beta,zeros(IT.nelements[i]))
			push!(activeSet,zeros(Bool,IT.nelements[i]))

		else

			push!(beta_tilde,zeros(0))
			push!(beta,zeros(0))
			push!(activeSet,zeros(Bool,0))

		end

	end

	return BCD,beta_tilde,beta,activeSet
end

function initXDY(IT,y,data)

	xdy0 = Vector{Float64}[]

	for i in 1:TOTALCOMPONENTS
		if in(i,IT.components)
			
			push!(xdy0,xdy[i](IT,y,data) )

		else
			push!(xdy0,Vector{Float64}(0) )
		end
		#temp)
	end


	return xdy0
end

#change for no preallocation and simply edit field
#requires changing normalizations.jl (returns)
function initData(IT,fs=[],fc=[])

	d = dataCD()
	for i in IT.components
		d.σ[i],d.μ[i] = getData[i](IT,fs)
	end
	d.fs = fs
	d.fc = fc
	return d
end




