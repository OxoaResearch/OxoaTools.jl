#!/bin/julia 

#=
NAME: update_julia - a small script that installs the latest precompiled Julia nightly lor Linux x86-64
	
SYNOPSYS
 	update_julia [--dir=<install path>] [--precompile] [--update]

DESCRIPTION
	The script downloads the latest Julia nightly from http://julialang.org and installs it in 
	/opt if --dir is not used. It also generates a sylink named 'julia_nightly' in /usr/local/bin.
OPTIONS
	--dir=<install path>
		Installs julia in the path specified, provided that the path exists. If the path
		does not exists, the installation aborts.
	--precompile
		Creates a Julia system image by calling build_sysimg.jl
	--update
		Runs a Pkg.update() after installation
AUTHOR

Written by Corneliu Cofaru, (c) 2018
=#

using Distributed

# Keep track of input arguments
JULIA_INST = "/opt"		# installation directory (has to exist)
PRECOMPILE = false;		# pre-compilation flag 
UPDATE = false; 		# update flag

# Parse arguments
if length(ARGS) >0
	for (i, arg) in enumerate(ARGS)
		arg == "--precompile" 	&& begin global PRECOMPILE = true end
		arg == "--update" 	&& begin (global UPDATE = true) end
		if occursin("--dir=", arg)
			global JULIA_INST = split(arg,"=")[2]
			!ispath(JULIA_INST) && begin
				println("Install path \"$JULIA_INST\" does not exist. Aborting...")
				exit(-1)	
			end
		end
	end
end

# Initialize constants 
JULIA_LINK = "https://julialangnightlies-s3.julialang.org/bin/linux/x64/julia-latest-linux64.tar.gz"	# download link
JULIA_DWL_FILE = "/tmp/julia_latest_tmp.tar.gz"				# save file

# Clean /opt
println("Pre-cleaning...")
files_opt = open(readlines, `ls $JULIA_INST`)
files_to_remove = files_opt[ findall([occursin(r"julia-[0-9a-f]{10}", s)||isequal(s, "julia") for s in files_opt]) ]
for fname in files_to_remove
	println("\tdeleteing $(fname)...")
	run(`rm -rf $(joinpath(JULIA_INST,fname))`)
end

# Download and extract
println("Downloading...")
run(`wget $(JULIA_LINK) --output-document=$(JULIA_DWL_FILE)`)

println("Extracting...")
run(`tar zxvf $(JULIA_DWL_FILE) -C $(JULIA_INST)`)
run(`rm $(JULIA_DWL_FILE)`)

# Create /opt/julia symlink
println("Sym-linking...")
JULIA_VER = open(readlines, pipeline(`ls /opt/. --sort=time`,`grep julia-`))
run(`ln -s $(joinpath(JULIA_INST,JULIA_VER[1])) $(joinpath(JULIA_INST,"julia"))`)

# Precompile if specified
if PRECOMPILE
    BUILD_IMAGE_SCRIPT = "/opt/julia/share/julia/build_sysimg.jl"
    new_script = replace(open(x->read(x, String), BUILD_IMAGE_SCRIPT),
                         "info("=>"@info(")
    open(x->write(x, new_script), BUILD_IMAGE_SCRIPT, "w")
    precompile_cmd = "using Libdl;" *
                     "include(\"$BUILD_IMAGE_SCRIPT\");"*
                     "build_sysimg(default_sysimg_path(), \"native\", nothing;force=true);"
	run(`$(joinpath(JULIA_INST,"julia/bin/julia")) -e $(precompile_cmd)`)
end

# Update packages if specified
if UPDATE
	pkgup_cmd = "Pkg.update()"
	run(`$(joinpath(JULIA_INST,"julia/bin/julia")) -e $(pkgup_cmd)`)
end

println("Installation of julia $(split(JULIA_VER[1],"-")[2]) done.")
