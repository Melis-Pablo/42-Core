#!/bin/bash

# Define colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Define repository mapping (format: "repo_name|destination_directory")
declare -a repos=(
  "project-calculator|Extras"
  "42_Exam|Extras"
  "ft_transcendence|Circle06"
  "cpp_modules_pt2|Circle05"
  "inception|Circle05"
  "webserv|Circle05"
  "cpp_modules|Circle04"
  "minirt|Circle04"
  "net_practice|Circle04"
  "philosophers|Circle03"
  "minishell|Circle03"
  "push_swap|Circle02"
  "pipex|Circle02"
  "fract-ol|Circle02"
  "born2beRoot|Circle01"
  "ft_printf|Circle01"
  "get_next_line|Circle01"
  "libft|Circle00"
  "42-testing-container|Extras"
  "2022-Piscine|Extras"
)

# GitHub username
GH_USERNAME="Melis-Pablo"

# Set the base URL for repositories
BASE_URL="https://github.com/${GH_USERNAME}"

# Function to add a submodule
add_submodule() {
  local repo_name=$1
  local dest_dir=$2
  local repo_url="${BASE_URL}/${repo_name}.git"

  # Check if destination directory exists, create it if it doesn't
  if [ ! -d "$dest_dir" ]; then
    echo -e "${YELLOW}📁 Directory ${BLUE}${dest_dir}${YELLOW} doesn't exist. Creating it...${NC}"
    mkdir -p "$dest_dir"
    if [ $? -eq 0 ]; then
      echo -e "${GREEN}✅ Created directory ${BLUE}${dest_dir}${GREEN}.${NC}"
    else
      echo -e "${RED}❌ Failed to create directory ${BLUE}${dest_dir}${RED}. Skipping this submodule.${NC}"
      return 1
    fi
  fi

  echo -e "\n${CYAN}➡️  Adding ${YELLOW}${repo_name}${CYAN} to ${BLUE}${dest_dir}${CYAN}...${NC}"
  git submodule add "${repo_url}" "${dest_dir}/${repo_name}"

  if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Successfully added ${YELLOW}${repo_name}${GREEN} as a submodule in ${BLUE}${dest_dir}${GREEN}.${NC}"
  else
    echo -e "${RED}❌ Failed to add ${YELLOW}${repo_name}${RED} as a submodule in ${BLUE}${dest_dir}${RED}.${NC}"
  fi
  echo -e "${CYAN}----------------------------------------${NC}"
}

# Main script
echo -e "${YELLOW}🚀 Starting to add submodules...${NC}"
echo -e "${CYAN}----------------------------------------${NC}"

for repo_info in "${repos[@]}"; do
  # Split the string by '|' to get repo_name and dest_dir
  IFS='|' read -r repo_name dest_dir <<< "$repo_info"

  # Add the submodule
  add_submodule "$repo_name" "$dest_dir"
done

echo -e "\n${GREEN}🎉 All submodules have been added!${NC}"
echo -e "${YELLOW}To complete the process, commit the changes:${NC}"
echo -e "${BLUE}git commit -m \"Add all 42 school projects as submodules\"${NC}"
echo -e "${BLUE}git push origin main${NC}"
echo -e ""
echo -e "${YELLOW}Note: If you encounter any issues, you can remove a submodule using:${NC}"
echo -e "${BLUE}git submodule deinit <path/to/submodule>${NC}"
echo -e "${BLUE}git rm <path/to/submodule>${NC}"
echo -e "${BLUE}rm -rf .git/modules/<path/to/submodule>${NC}"