import Crayons;
import OhMyREPL

function colorscheme_elflord()
	color_scheme = OhMyREPL.Passes.SyntaxHighlighter.ColorScheme()

	# Keyword 
	OhMyREPL.Passes.SyntaxHighlighter.keyword!(color_scheme, Crayons.Crayon(foreground = :white, bold=true))

	# Number 
	OhMyREPL.Passes.SyntaxHighlighter.number!(color_scheme, Crayons.Crayon(foreground = :white, bold=true))

	# Text 
	OhMyREPL.Passes.SyntaxHighlighter.text!(color_scheme, Crayons.Crayon(foreground = :light_gray, bold=false))

	# Symbol 
	OhMyREPL.Passes.SyntaxHighlighter.symbol!(color_scheme, Crayons.Crayon(foreground = :magenta, bold=true))

	# String
	OhMyREPL.Passes.SyntaxHighlighter.string!(color_scheme, Crayons.Crayon(foreground = :light_magenta, bold=true))

	# Operators 
	OhMyREPL.Passes.SyntaxHighlighter.op!(color_scheme, Crayons.Crayon(foreground = :light_cyan, bold=true))

	# Macros 
	OhMyREPL.Passes.SyntaxHighlighter.macro!(color_scheme, Crayons.Crayon(foreground = :light_green, bold=true))

	# Comment
	OhMyREPL.Passes.SyntaxHighlighter.comment!(color_scheme, Crayons.Crayon(foreground = :dark_gray, bold=true))

	# Argument definitions 
	OhMyREPL.Passes.SyntaxHighlighter.argdef!(color_scheme, Crayons.Crayon(foreground = :light_blue, bold=true))

	# Function definitions 
	OhMyREPL.Passes.SyntaxHighlighter.function_def!(color_scheme, Crayons.Crayon(foreground = :default, bold=true))

	# Function call 
	OhMyREPL.Passes.SyntaxHighlighter.call!(color_scheme, Crayons.Crayon(foreground = :default, bold=true))

	# Error 
	OhMyREPL.Passes.SyntaxHighlighter.error!(color_scheme, Crayons.Crayon(foreground = :light_red, bold=false))

	return color_scheme
end


function colorscheme_Mustang()
	color_scheme = OhMyREPL.Passes.SyntaxHighlighter.ColorScheme()

	# Keyword 
	OhMyREPL.Passes.SyntaxHighlighter.keyword!(color_scheme, Crayons.Crayon(foreground = :050, bold=false))

	# Number 
	OhMyREPL.Passes.SyntaxHighlighter.number!(color_scheme, Crayons.Crayon(foreground = :208, bold=true))

	# Text 
	OhMyREPL.Passes.SyntaxHighlighter.text!(color_scheme, Crayons.Crayon(foreground = :252, bold=false))

	# Symbol 
	OhMyREPL.Passes.SyntaxHighlighter.symbol!(color_scheme, Crayons.Crayon(foreground = :149, bold=true))

	# String
	OhMyREPL.Passes.SyntaxHighlighter.string!(color_scheme, Crayons.Crayon(foreground = :149, bold=true))

	# Operators 
	OhMyREPL.Passes.SyntaxHighlighter.op!(color_scheme, Crayons.Crayon(foreground = :254, bold=false))

	# Macros 
	OhMyREPL.Passes.SyntaxHighlighter.macro!(color_scheme, Crayons.Crayon(foreground = :191, bold=true))

	# Comment
	OhMyREPL.Passes.SyntaxHighlighter.comment!(color_scheme, Crayons.Crayon(foreground = :244, bold=false))

	# Argument definitions 
	OhMyREPL.Passes.SyntaxHighlighter.argdef!(color_scheme, Crayons.Crayon(foreground = :105, bold=true))

	# Function definitions 
	OhMyREPL.Passes.SyntaxHighlighter.function_def!(color_scheme, Crayons.Crayon(foreground = :light_gray, bold=true))

	# Function call 
	OhMyREPL.Passes.SyntaxHighlighter.call!(color_scheme, Crayons.Crayon(foreground = :254, bold=true))

	# Error 
	OhMyREPL.Passes.SyntaxHighlighter.error!(color_scheme, Crayons.Crayon(foreground = :196, bold=true))

	return color_scheme
end


function colorscheme_wuye()
	color_scheme = OhMyREPL.Passes.SyntaxHighlighter.ColorScheme()

	# Keyword 
	OhMyREPL.Passes.SyntaxHighlighter.keyword!(color_scheme, Crayons.Crayon(foreground = :086, bold=true))

	# Number 
	OhMyREPL.Passes.SyntaxHighlighter.number!(color_scheme, Crayons.Crayon(foreground = :051, bold=true))

	# Text 
	OhMyREPL.Passes.SyntaxHighlighter.text!(color_scheme, Crayons.Crayon(foreground = :252, bold=false))

	# Symbol 
	OhMyREPL.Passes.SyntaxHighlighter.symbol!(color_scheme, Crayons.Crayon(foreground = :199, bold=true))

	# String
	OhMyREPL.Passes.SyntaxHighlighter.string!(color_scheme, Crayons.Crayon(foreground = :199, bold=true))

	# Operators 
	OhMyREPL.Passes.SyntaxHighlighter.op!(color_scheme, Crayons.Crayon(foreground = :51, bold=false))

	# Macros 
	OhMyREPL.Passes.SyntaxHighlighter.macro!(color_scheme, Crayons.Crayon(foreground = :163, bold=true))

	# Comment
	OhMyREPL.Passes.SyntaxHighlighter.comment!(color_scheme, Crayons.Crayon(foreground = :244, bold=false))

	# Argument definitions 
	OhMyREPL.Passes.SyntaxHighlighter.argdef!(color_scheme, Crayons.Crayon(foreground = :039, bold=false))

	# Function definitions 
	OhMyREPL.Passes.SyntaxHighlighter.function_def!(color_scheme, Crayons.Crayon(foreground = :254, bold=true))

	# Function call 
	OhMyREPL.Passes.SyntaxHighlighter.call!(color_scheme, Crayons.Crayon(foreground = :051, bold=true))

	# Error 
	OhMyREPL.Passes.SyntaxHighlighter.error!(color_scheme, Crayons.Crayon(foreground = :196, bold=true))

	return color_scheme
end

function apply_colorscheme(cs)
	
	# Apply colorscheme
	OhMyREPL.Passes.SyntaxHighlighter.add!("cs", cs)
	OhMyREPL.colorscheme!("cs")

	# Set bracket highlighting
	c = Crayons.Crayon(background = :black, foreground=:black, bold = true)
	OhMyREPL.Passes.BracketHighlighter.setcrayon!(c)

	# Bracket autocompletion off
	OhMyREPL.enable_autocomplete_brackets(true)

	# Prompt
	OhMyREPL.input_prompt!(">", :light_green)
	#OhMyREPL.output_prompt!("", :white)
end

# Apply colorscheme
# One can view the available colors with > Crayons.test_256_colors()
#cs = colorscheme_Mustang()
cs = colorscheme_wuye()
apply_colorscheme(cs)
