#!/bin/bash

# Define ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print a message with color
printColorMessage() {
    local message="$1"
    local color="$2"

    echo -e "${color}${message}${NC}"
}

# Function to print a progress bar
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

# Get the path to the project root directory
PROJECT_ROOT="$(pwd)"

# Find pubspec.yaml files in the project
FILES=$(find . -name 'pubspec.yaml')

# Store the total number of files found
TOTAL_FILES=$(echo "$FILES" | wc -l)

# Show message before starting the pub get process
printColorMessage "=------------------------------------------------=" "$PURPLE"
printColorMessage "=-------> START PUB GET FLUTTER PROJECTS <-------=" "$PURPLE"
printColorMessage "=------------------------------------------------=" "$PURPLE"
echo

# Set initial value for the counter
CURRENT_FILE=0

# Loop through each found file
for FILE in $FILES; do
    # Increment the counter
    CURRENT_FILE=$((CURRENT_FILE + 1))

    # Show message indicating the file being processed
    printColorMessage "Pub get project for: $FILE" "$CYAN"

    # Navigate to the directory containing the pubspec.yaml file
    cd "$(dirname "$FILE")" || { printColorMessage "Error: Unable to navigate to directory." "$RED"; exit 1; }

    # Run the flutter clean command
    printColorMessage "-> Start Running flutter pub get..." "$YELLOW"
    flutter pub get || { printColorMessage "Error: Failed to pub get project." "$RED"; exit 1; }

    # Return to the project root directory
    cd "$PROJECT_ROOT" || { printColorMessage "Error: Unable to navigate back to project root directory." "$RED"; exit 1; }

    # Calculate progress percentage
    PROGRESS=$((CURRENT_FILE * 100 / TOTAL_FILES))

    # Print the progress
    printColorMessage "" "$NC"
    printf "\r${BLUE}Progress: ${PURPLE}%3d%% ${NC}[${CYAN}%d/${TOTAL_FILES}${NC}] ${CYAN}[${GREEN}%s${CYAN}] " "$PROGRESS" "$CURRENT_FILE" "$(percentBar "$PROGRESS" 50)"
    printColorMessage "" "$NC"
    echo

    # Show message indicating the file has been processed
    printColorMessage "Project pub get successfully for: $FILE" "$GREEN"
    echo
done

# Print a new line after all files are processed
printColorMessage "=-------------------------------------------------=" "$PURPLE"
printColorMessage "=-------> FINISH PUB GET FLUTTER PROJECTS <-------=" "$PURPLE"
printColorMessage "=-------------------------------------------------=" "$PURPLE"
echo
