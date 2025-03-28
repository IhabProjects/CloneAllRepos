# CloneAllRepos

This PowerShell script allows you to authenticate and clone all repositories from a given GitHub user. The script will work for both public and private repositories, provided you authenticate with a GitHub Personal Access Token (PAT).

## Prerequisites

- **Git**: Make sure Git is installed and added to your system `PATH`.
- **PowerShell**: The script is intended to run on Windows, using PowerShell 5+.
- **GitHub Personal Access Token (PAT)**: A GitHub token with `repo` permissions is required for accessing private repositories.

## Usage

1. **Clone the Repository**:

    ```bash
    git clone https://github.com/yourusername/CloneAllRepos.git
    cd CloneAllRepos
    ```

2. **Run the Script**:

    Open PowerShell in the directory where you cloned the repository, and run the following command:

    ```powershell
    .\CloneAllRepos.ps1
    ```

    The script will prompt for the **GitHub username** and **GitHub Personal Access Token**.

3. **Cloning Repositories**:

    The script will automatically create a folder with the username's name and start cloning all repositories into that folder.

4. **Access the Repositories**:

    After cloning, all repositories will be available in the directory named after the GitHub username.

## Authentication

The script uses a GitHub Personal Access Token (PAT) to authenticate with GitHub. If you don't have one yet, follow these steps to generate a PAT:

1. Go to [GitHub Tokens](https://github.com/settings/tokens).
2. Click on "Generate New Token".
3. Select `repo` scope to access private repositories.
4. Save the token securely.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

