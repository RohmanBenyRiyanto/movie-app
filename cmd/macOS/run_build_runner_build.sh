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

# Function to check if build_runner is defined in pubspec.yaml
checkBuildRunner() {
    local yaml_file="$1"
    local build_runner=$(grep -c "build_runner" "$yaml_file")

    if [ "$build_runner" -gt 0 ]; then
        return 0
    else
        return 1
    fi
}

# Get the path to the project root directory
PROJECT_ROOT="$(pwd)"

# Array of directories to iterate over
DIRECTORIES=("app" "module")

# Get module argument from command line
MODULE=$1

#  jika module tidak kosong. DIRECTORIES akan diubah isinya hanya ada MODULE
if [ -n "$MODULE" ]; then
    MODULE=${MODULE#--select-package=}
    if [ "$MODULE" == "app" ]; then
        DIRECTORIES=("app")
    elif [ "$MODULE" == "module" ]; then
        DIRECTORIES=("module")
    else
        DIRECTORIES=("module/$MODULE")
    fi
fi

# Show message before starting the process
printColorMessage "=------------------------------------------------=" "$PURPLE"
printColorMessage "=-------> START BUILDING FLUTTER MODULES <-------=" "$PURPLE"
printColorMessage "=------------------------------------------------=" "$PURPLE"

# Loop through each directory
for dir in "${DIRECTORIES[@]}"; do
    # Find all pubspec.yaml files in the directory and its subdirectories
    yaml_files=$(find "$dir" -name "pubspec.yaml")

    # Loop through found YAML files
    while IFS= read -r yaml_file; do
        # Check if build_runner dependency is defined in pubspec.yaml
        if checkBuildRunner "$yaml_file"; then
            # Extract the directory containing pubspec.yaml
            module_dir=$(dirname "$yaml_file")

            # Show message indicating the directory being processed
            printColorMessage "" "$NC"
            printColorMessage "Module to build: $module_dir" "$BLUE"

            # Navigate to the directory
            cd "$module_dir" || { printColorMessage "Error: Unable to navigate to directory." "$RED"; exit 1; }

            # Run the build_runner command
            printColorMessage "-> Start Running build_runner build..." "$YELLOW"
            dart run build_runner build --delete-conflicting-outputs || { printColorMessage "Error: Failed to build module." "$RED"; exit 1; }

            # Return to the project root directory
            cd "$PROJECT_ROOT" || { printColorMessage "Error: Unable to navigate back to project root directory." "$RED"; exit 1; }

            # Show message indicating the directory has been processed
            printColorMessage "" "$NC"
            printColorMessage "Module built successfully: $module_dir" "$GREEN"
        fi
    done <<< "$yaml_files"
done

# Print a new line after all modules are built
printColorMessage "" "$NC"
printColorMessage "=-------------------------------------------------=" "$PURPLE"
printColorMessage "=-------> FINISH BUILDING FLUTTER MODULES <-------=" "$PURPLE"
printColorMessage "=-------------------------------------------------=" "$PURPLE"
