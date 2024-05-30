#!/bin/bash

# Define ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print progress bar
percentBar() {
    local percent="$1"
    local width="$2"
    local char="█"
    local numChars=$((percent * width / 100))
    local bar=""

    for ((i = 0; i < numChars; i++)); do
        bar+="█"
    done

    printf "%-${width}s" "$bar"
}

# Function to print a message with color
printColorMessage() {
    local message="$1"
    local color="$2"

    echo -e "${color}${message}${NC}"
}

# Get the path to the project root directory
PROJECT_ROOT="$(pwd)"

# Find l10n.yaml files in the resources module
FILES=$(find "$PROJECT_ROOT/module/resources/" -name 'l10n.yaml')

# Store the total number of files found
TOTAL_FILES=$(echo "$FILES" | wc -l)

# Show message before starting the localization generation process
printColorMessage "=-----------------------------------------------------=" "$PURPLE"
printColorMessage "=-------> START GENERATE FLUTTER LOCALIZATION <-------=" "$PURPLE"
printColorMessage "=-----------------------------------------------------=" "$PURPLE"
echo

# Set initial value for the counter
CURRENT_FILE=1

# Loop through each found file
for FILE in $FILES; do
    # Show message indicating the file being processed
    printColorMessage "Generating localizations for: $FILE" "$CYAN"
    echo

    # Navigate to the directory containing the l10n.yaml file
    cd "$(dirname "$FILE")" || { printColorMessage "Error: Unable to navigate to directory." "$RED"; exit 1; }

    # Run the flutter gen-l10n command
    printColorMessage "-> Start Running flutter gen-l10n..." "$YELLOW"
    flutter gen-l10n || { printColorMessage "Error: Failed to generate localizations." "$RED"; exit 1; }
    # dart fix --dry-run
    dart fix --dry-run || { printColorMessage "Error: Failed to generate localizations." "$RED"; exit 1; }
    dart fix --apply || { printColorMessage "Error: Failed to generate localizations." "$RED"; exit 1; }

    # Return to the project root directory
    cd "$PROJECT_ROOT" || { printColorMessage "Error: Unable to navigate back to project root directory." "$RED"; exit 1; }

    # Print the progress bar
    printColorMessage "" "$NC"
    printf "\r${BLUE}Progress: ${PURPLE}%3d%% ${NC}[${CYAN}%s${NC}] " "$((CURRENT_FILE * 100 / TOTAL_FILES))" "$(percentBar "$((CURRENT_FILE * 100 / TOTAL_FILES))" 50)"
    printColorMessage "" "$NC"
    echo

    # Show message indicating the file has been processed
    printColorMessage "Localizations generated successfully for: $FILE" "$GREEN"
    echo

    # Increment the counter
    CURRENT_FILE=$((CURRENT_FILE + 1))
done

# Print a new line after all files are processed
printColorMessage "=------------------------------------------------------=" "$PURPLE"
printColorMessage "=-------> FINISH GENERATE FLUTTER LOCALIZATION <-------=" "$PURPLE"
printColorMessage "=------------------------------------------------------=" "$PURPLE"
echo
