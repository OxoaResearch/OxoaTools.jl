#!/bin/julia 

#=
NAME: download_julia_packages - download all registered Julia packages in one go.
	
SYNOPSYS
    download_julia_packages [--dir <path>] [--archive <option>] [--julia-dir <path>]
                            [--registry <path to 'Registry.toml'>]

DESCRIPTION
	The script downloads the latest Julia nightly from http://julialang.org and installs it in 
	/opt if --dir is not used. It also generates a sylink named 'julia_nightly' in /usr/local/bin.
OPTIONS
	--dir <install path>
        Downloads all Julia packages to the path specified. If the path does not exist,
        it is created.
	--archive
		Additionally creates a '.tar.gz' archive with all packages.
    --julia-dir <path>
        The path to the '.julia' folder; this is used for accessing package information.
    --registry <path>
        Custom path for the 'Registry.toml' file.
  
AUTHOR

Written by Corneliu Cofaru, (c) 2018
=#

# TODO(Corneliu): Add update option (i.e. incremental download + update existing)
# TODO(Corneliu): Integrate with LibGit2 to perform operations.
# TODO(Corneliu): Get/update Registry.toml by default without needing a Julia
# installation path or path to registry toml; the options can be used as
# overrides only.



using Pkg
installed = Pkg.installed()
!("ArgParse" in keys(installed)) &&  Pkg.add("ArgParse")
using ArgParse



# Function that parses input arguments
function get_commandline_arguments(args::Vector{String})
    s = ArgParseSettings()
    @add_arg_table s begin
        "--dir"
            help = "download path"
            default = "./"
        "--archive"
            help = "archive the downloaded repositories into a '.tar.gz' archive"
            action = :store_true
        "--julia-dir"
            help = "path to the '.julia' folder"
            default = abspath(expanduser("~/.julia"))
        "--registry"
            help = "path to the 'Registry.toml' file"
            default = abspath(expanduser("~/.julia/registries/General/Registry.toml"))
    end	
    return parse_args(args,s)
end



function main(ARGS::Vector{String})
	
	# Parse command line arguments
	args = get_commandline_arguments(ARGS)

	DIR = args["dir"]
	ARCHIVE = args["archive"]
    JULIA_DIR = args["julia-dir"]
    REGISTRY = args["registry"]

    # Create installation path if it does not exist
    directory = abspath(DIR)
    !isdir(directory) && mkpath(directory)

    # Check the Julia directory for registries
    pkg_reg_path = abspath(joinpath(JULIA_DIR, "registries", "General"))
    !isdir(pkg_reg_path) && @error "$pkg_reg_path does not exist."

    # Get the Registry.toml path
    registry_path = joinpath(pkg_reg_path, "Registry.toml")
    if !isfile(registry_path)
        @warn "Registry.toml not found in $JULIA_DIR."
        if !isfile(REGISTRY)
            @error "Registry.toml not found in $REGISTRY."
        else
            registry_path = abspath(REGISTRY)
        end
    end

    # Parse file and extract information in a Vector of tuples (package_name, path/to/Package.toml)  
    @info "Parsing $registry_path..."

    # Function that parses the line in the Registry.toml file
    function _parse_registry_line(line)
        _, _tmp1 = split(line, "{");
        _tmp1=replace(_tmp1, r"(\"|})"=>"");
        _name, _path = split(_tmp1, ",")
        _, name = strip.(split(_name, "="))
        _, path = strip.(split(_path, "="))
        return name, path
    end
    
    function _git_clone(repo, path)
        run(pipeline(`git clone $repo $path`, stdout=devnull))
    end

    PkgInfos = Vector{Tuple{String, String}}()
    open(registry_path, "r") do fid_registry
        # Inside Registry.toml
        for line in eachline(fid_registry)
            if all(occursin(symbol,line) for symbol in ["{", "}", "="])
                #00701ae9-d1dc-5365-b64a-a3a3ebf5695e = { name = "BioAlignments", path = "B/BioAlignments" }
                name, regdir = _parse_registry_line(line)
                open(joinpath(pkg_reg_path, regdir, "Package.toml"), "r") do fid_package
                    # Inside Package.toml
                    for _line in eachline(fid_package)
                        key, val = strip.(split(_line, "="))
                        if key == "repo"
                            push!(PkgInfos, (name, replace(val, "\""=>"")))
                        end
                    end
                end
            end
        end
    end

    @info "Cleaning up $directory ..."
    directories = readdir(directory)
    if !isempty(directories)
        for _dir in directories
            @info "removing $_dir"
            Base.Filesystem.rm(joinpath(directory,_dir), recursive=true, force=true)
        end
    end

    @info "Cloning repositories..."
    CONCURRENT = 8
    asyncmap(PkgInfos, ntasks=CONCURRENT) do x
        _git_clone(x[2], joinpath(DIR, x[1]))
    end

    if ARCHIVE
        @info "Compressing repositories"
        run(pipeline(`tar czf ./all_julia_repositories.tar.gz $(joinpath(directory, "*"))`,
                     stdout=devnull))
    end
end



#########################
# Run the main function #
#########################
main(ARGS)
