#!/bin/julia 

#=
NAME: download_julia_packages - download all registered Julia packages in one go.
	
SYNOPSYS
 	download_julia_packages [--dir <path>] [--archive <option>] [--update]
                            [--julia-dir <path>] [--registry <path to 'Registry.toml'>]

DESCRIPTION
	The script downloads the latest Julia nightly from http://julialang.org and installs it in 
	/opt if --dir is not used. It also generates a sylink named 'julia_nightly' in /usr/local/bin.
OPTIONS
	--dir <install path>
        Downloads all Julia packages to the path specified. If the path does not exist,
        it is created.
	--archive
		Additionally creates a '.tar.gz' archive with all packages.
	--update
		Updates all Julia packages that exist at the specified path running 'git pull' and
        downloads new packages.
    --julia-dir <path>
        The path to the '.julia' folder; this is used for accessing the 'Registry.toml' file.
    --registry <path>
        Custom path for the 'Registry.toml' file; has priority over the '--julia-dir' value.
  
AUTHOR

Written by Corneliu Cofaru, (c) 2018
=#



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
        "--update"
            help = ""
            action = :store_true
        "--julia-dir"
            help = "path to the '.julia' folder"
            default = ""
        "--registry"
            help = "path to the 'Registry.toml' file"
            default = ""
    end	
    return parse_args(args,s)
end



#TODO(Corneliu): Integrate with LibGit2 to perform operations.
function main(ARGS::Vector{String})
	
	# Parse command line arguments
	args = get_commandline_arguments(ARGS)

	DIR = args["dir"]
	ARCHIVE = args["archive"]
	UPDATE = args["update"]
    JULIA_DIR = args["julia-dir"]
    REGISTRY = args["registry"]

    # TODO(Corneliu): Get/update Registry.toml by default without needing a Julia
    # installation path or path to registry toml; the options can be used as
    # overrides only.
    
    @warn "No functionality implemented yet."
    
    # Create installation path if it does not exist

    # Decide the path for 'Registry.toml'

    # Parse file and extract information in a Vector of tuples (package_name, path/to/Package.toml)  
    
    # If no 'update'
        
        # For each element of the vector, retrieve from the 'Package.toml' the GitHub package path
        # and create a new Vector of tuples (package_name, GitHub path)

        # Download packages asynchronously (try-catch) and store the result of the download somewhere

        # Do another retry and write down a list of downloaded package names that exist 
    # else
        
        # Compare existing package list with the one extracted from 'Registry.toml'
        
        # Download non-existing packages
        
        # Update the rest

    # Create archive if specified
end



#########################
# Run the main function #
#########################
main(ARGS)
