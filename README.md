# Google Drive File Downloader and Organizer

This Bash script automates the process of downloading files from Google Drive using a Service Account and the [drive](https://github.com/odeke-em/drive) command-line tool. It also organizes files by moving downloaded items to a specified directory structure, creating subdirectories as needed.

## Features

- Checks for the `drive` tool and installs it if not present.
- Validates inputs and initializes a Google Drive session using a Service Account JSON file.
- Downloads files from Google Drive by their file ID.
- Moves downloaded content to designated directories, creating required subdirectories if they do not exist.
- Performs cleanup after execution.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [How It Works](#how-it-works)
3. [Getting a Service Account and JSON Key](#getting-a-service-account-and-json-key)
4. [Usage](#usage)
5. [Cleanup](#cleanup)
6. [Example Execution](#example-execution)

---

## Prerequisites

1. **Golang**: Ensure [Golang](https://go.dev/) is installed for `drive` installation.
2. **Google Cloud Project**: You'll need a Google Cloud Project with Google Drive API enabled.
3. **Service Account JSON Key**: This key authenticates the script to access the Google Drive API.

## How It Works

1. **Installation of `drive` tool**: The script installs the `drive` tool if it's not already present.
2. **File Download**: The script uses a Service Account JSON file to authenticate with Google Drive, then downloads the specified file using its file ID.
3. **File Organization**: Files are moved to a designated destination directory, where `plugins` and `themes` subdirectories are created if they don’t already exist.
4. **Cleanup**: Temporary directories created during execution are removed after the process completes.

## Getting a Service Account and JSON Key

1. Go to the [Google Cloud Console](https://console.cloud.google.com/).
2. Create a new project or select an existing one.
3. Enable the **Google Drive API** for your project:
   - Go to **APIs & Services** > **Library**.
   - Search for **Google Drive API** and enable it.
4. Create a Service Account:
   - Go to **IAM & Admin** > **Service Accounts**.
   - Click **Create Service Account**, enter a name, and click **Create and Continue**.
   - Assign the **Viewer** or **Editor** role and proceed.
5. Create a JSON key:
   - Under **Keys**, select **Add Key** > **Create New Key**.
   - Choose **JSON** and download the key. This key will be used in the script as the Service Account JSON file.

## Usage

1. Clone this repository or download the script file.
2. Ensure you have the required permissions for executing the script:
   ```bash
   chmod +x script_name.sh
   ```
3. Run the script with the following arguments:
   ```bash
   ./script_name.sh <destination_directory> <service_account_file> <file_id>
   ```
   - `<destination_directory>`: The path where downloaded files will be organized.
   - `<service_account_file>`: The JSON file for the Google Service Account key.
   - `<file_id>`: The ID of the Google Drive file to download.

### Example

```bash
./script.sh /path/to/destination /path/to/service_account.json 1a2B3cD4EfGh5iJKL
```

### Notes

- **File ID**: You can find this in the Google Drive file URL. For example, in `https://drive.google.com/file/d/1a2B3cD4EfGh5iJKL/view?usp=sharing`, the file ID is `1a2B3cD4EfGh5iJKL`.
- **Destination Directory**: Ensure that the destination directory has the necessary permissions for moving files into `plugins` and `themes` subdirectories.

## Cleanup

The script automatically removes the `drive` directory used for temporary files after execution. No manual cleanup is needed.

## Example Execution

Below is an example of the expected output:

```plaintext
Installing drive...
drive installed successfully.
Directory /path/to/destination does not exist.
Creating /path/to/destination/plugins directory.
Creating /path/to/destination/themes directory.
Moving files from /wp-content/plugins to /path/to/destination/plugins
Moving files from /wp-content/themes to /path/to/destination/themes
Cleanup completed.
```

This completes the setup and execution for this Google Drive Downloader and Organizer script.