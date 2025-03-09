# Function to display help message
function usage() {
    echo "Usage: $0 [-i] [-n] -f <file> -p <pattern>"
    echo "  -i          Perform a case-insensitive search"
    echo "  -n          Display line numbers in the output"
    echo "  -f <file>   Specify the file to search"
    echo "  -p <pattern> Specify the pattern to search for (regular expression)"
    echo "  -h          Show this help message"
    exit 1
}

# Initialize variables
case_insensitive=""
show_line_numbers=""
file=""
pattern=""

# Parse options
while getopts ":inf:p:h" opt; do
    case $opt in
        i) case_insensitive="-i" ;;
        n) show_line_numbers="-n" ;;
        f) file="$OPTARG" ;;
        p) pattern="$OPTARG" ;;
        h) usage ;;
        *) echo "Invalid option: -$OPTARG" >&2; usage ;;
    esac
done

# Validate input
if [[ -z "$file" || -z "$pattern" ]]; then
    echo "Error: Both -f (file) and -p (pattern) options are required."
    usage
fi

if [[ ! -f "$file" ]]; then
    echo "Error: File '$file' does not exist."
    exit 1
fi

# Perform the search using grep
grep $show_line_numbers $case_insensitive -E "$pattern" "$file"
