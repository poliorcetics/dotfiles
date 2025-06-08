# Completions for `rnr`: <https://github.com/ismaelgv/rnr>
#
# Version: 0.4.2

def color_categories [] { return ["always", "auto", "never"] }

# RnR is a command-line tool to rename multiple files and directories that supports regular expressions
export extern rnr [
    --backup(-b),       # Generate file backups before renaming
    --dry-run(-n),      # Only show what would be done (default mode)
    --dump              # Force dumping operations into a file even in dry-run mode
    --force(-f),        # Make actual changes to files
    --help(-h),         # Prints help information
    --hidden(-x),       # Include hidden files and directories
    --include-dirs(-D), # Rename matching directories
    --no-dump           # Do not dump operations into a file
    --recursive(-r),    # Recursive mode
    --silent(-s),       # Do not print any information
    --version(-V),      # Prints version information

    --color: string@color_categories, # Set color output mode [default: auto]  [possible values: always, auto, never]
    --max-depth(-d): int              # Set max depth in recursive mode
    --replace-limit(-l): int          # Limit of replacements, all matches if set to 0 [default: 1]

    expression: string,  # Expression to match (can be a regex)
    replacement: string, # Expression replacement
    ...paths: glob,      # Target paths
]

# Read operations from a dump file
export extern "rnr from-file" [
    --backup(-b),       # Generate file backups before renaming
    --dry-run(-n),      # Only show what would be done (default mode)
    --dump              # Force dumping operations into a file even in dry-run mode
    --force(-f),        # Make actual changes to files
    --help(-h),         # Prints help information
    --no-dump           # Do not dump operations into a file
    --silent(-s),       # Do not print any information
    --undo(-u),         # Undo the operations from the dump file
    --version(-V),      # Prints version information

    --color: string@color_categories, # Set color output mode [default: auto]  [possible values: always, auto, never]

    dumpfile: glob # Dumpfile to read
]

def subcommand_categories [] { return ["from-file", "to-ascii"] }

# Prints base help message or the help of the given subcommand(s)
export extern "rnr help" [
    subcommand?: string@subcommand_categories # Print the help of the given subcommand
]

export extern "rnr to-ascii" [
    --backup(-b),       # Generate file backups before renaming
    --dry-run(-n),      # Only show what would be done (default mode)
    --dump              # Force dumping operations into a file even in dry-run mode
    --force(-f),        # Make actual changes to files
    --help(-h),         # Prints help information
    --hidden(-x),       # Include hidden files and directories
    --include-dirs(-D), # Rename matching directories
    --no-dump           # Do not dump operations into a file
    --recursive(-r),    # Recursive mode
    --silent(-s),       # Do not print any information
    --version(-V),      # Prints version information

    --color: string@color_categories, # Set color output mode [default: auto]  [possible values: always, auto, never]
    --max-depth(-d): int              # Set max depth in recursive mode

    ...paths: glob,      # Target paths
]
