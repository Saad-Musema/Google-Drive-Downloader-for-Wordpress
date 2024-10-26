#!/bin/bash

# Function to install drive
install_drive() {
    echo "Installing drive..."
    go install github.com/odeke-em/drive/cmd/drive@latest
    export PATH=$PATH:$(go env GOPATH)/bin
    echo "drive installed successfully."
}


# Check if drive is installed
if ! command -v drive &> /dev/null; then
    install_drive
fi

# Function to download a file from Google Drive
gdrive_download() {
    local service_account_file=$1
    local file_id=$2

    local script_dir=$(dirname "$0")

    local drive_dir="$script_dir/drive"

    if ! drive init --service-account-file "$service_account_file" "$drive_dir"; then
        echo "Error: Failed to initialize drive."
        return 1
    fi

    cd "$drive_dir" || { echo "Failed to change directory to $drive_dir"; return 1; }

    echo "Downloading file with ID: $file_id"

    if ! drive pull -id "$file_id"; then
        echo "Error: Failed to download the file."
        return 1
    fi

    echo "Download completed."
}



# Function to move files from the script's directory to a destination directory
move_files() {
    # local src_dir=/home/saad-musema/Desktop/Docker_Tutorial/docker-crash-course/api/drive/wp-content
    local src_dir="$(pwd)/wp-content" 
    local dest_dir=$1

    echo "Source Directory: $src_dir"
    echo "Destination Directory: $dest_dir"

    if [ -z "$dest_dir" ]; then
        echo "Please provide a destination directory."
        return 1
    fi

    if [ ! -d "$src_dir/plugins" ]; then
        echo "Source directory $src_dir/plugins does not exist."
        return 1
    fi

    if [ ! -d "$src_dir/themes" ]; then
        echo "Source directory $src_dir/themes does not exist."
        return 1
    fi

    if [ ! -d "$dest_dir" ]; then
        echo "Destination directory $dest_dir does not exist."
        return 1
    fi

    echo "Moving files from $src_dir/plugins to $dest_dir/plugins"
    mv "$src_dir/plugins"/* "$dest_dir/plugins/"

    echo "Moving files from $src_dir/themes to $dest_dir/themes"
    mv "$src_dir/themes"/* "$dest_dir/themes/"
}


# Check for required arguments
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "Usage: $0 <destination_directory> <service_account_file> <file_id>"
    exit 1
fi

dest_dir=$1
service_account_file=$2
file_id=$3

# Download the file and move files
gdrive_download "$service_account_file" "$file_id"
move_files "$dest_dir"
