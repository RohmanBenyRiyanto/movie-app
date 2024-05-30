#!/bin/bash

# Define ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to display help information
show_help() {
    # print custom Flutter Command by Beny
    echo -e "${PURPLE}==================================================== Custom Flutter Command ====================================================${NC}"
    echo ""
    echo -e "${GREEN}Usage: execute <command>${NC}"
    echo ""
    echo -e "${BLUE}Available commands:${NC}"
    echo -e "${YELLOW}  pub:get${NC}                                              Run the flutter pub get dependencies"
    echo -e "${YELLOW}  pub:clean${NC}                                            Run the flutter clean dependencies"
    echo -e "${YELLOW}  pub:clean-get${NC}                                        Run both clean and get dependencies"
    echo -e "${YELLOW}  test${NC}                                                 Run the flutter test with coverage report"
    echo -e "${YELLOW}  analyze${NC}                                              Run the flutter analyze"
    echo -e "${YELLOW}  format${NC}                                               Run the flutter format"
    echo -e "${YELLOW}  generate:build${NC}                                       Run the build generation"
    echo -e "${YELLOW}  generate:clean${NC}                                       Run the clean generation"
    echo -e "${YELLOW}  generate:localization${NC}                                Run the localization generation"
    echo ""
    echo -e "${YELLOW}  generate:build ${YELLOW}--select-package=<package>${NC}            Run the build generation, for a specific module"
    # echo -e "${YELLOW}  test ${YELLOW}--select-package=<package>${NC}                      Run the flutter test for a specific package"
    # echo -e "${YELLOW}  fix ${YELLOW}--dry-run${NC}                                        Run the flutter format with dry-run"
    # echo -e "${YELLOW}  fix ${YELLOW}--apply${NC}                                          Run the flutter format with dry-run and apply"
    # echo -e "${YELLOW}  analyze ${YELLOW}--select-package=<package>${NC}                   Run the flutter analyze for a specific package"
    # echo -e "${YELLOW}  format ${YELLOW}--select-package=<package>${NC}                    Run the flutter format for a specific package"
    echo ""
    echo -e "${BLUE}Options:${NC}"
    echo -e "${YELLOW}  -h, -help${NC}                                            Show this help message"
    echo ""
    echo -e "${PURPLE}=======================================> Creator: https://github.com/RohmanBenyRiyanto <========================================${NC}"
}
