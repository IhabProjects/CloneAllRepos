# CloneAllRepos.ps1

# Ensure Git is installed
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Error: Git is not installed. Please install Git and add it to PATH." -ForegroundColor Red
    Exit 1
}

# Prompt user for GitHub username and token
$GitHubUser = Read-Host "Enter GitHub username"
$GitHubToken = Read-Host "Enter your GitHub Personal Access Token" -AsSecureString

# Convert secure string to plain text
$GitHubTokenPlain = [System.Net.NetworkCredential]::new("", $GitHubToken).Password

# Set the headers for authentication
$Headers = @{
    "Authorization" = "token $GitHubTokenPlain"
    "User-Agent" = "PowerShell-Script"
}

# Fetch repositories from GitHub API using authentication
$ApiUrl = "https://api.github.com/users/$GitHubUser/repos?per_page=100"
try {
    $Repos = Invoke-RestMethod -Uri $ApiUrl -Headers $Headers
} catch {
    Write-Host "Error fetching repositories. Check your internet connection or GitHub username/token." -ForegroundColor Red
    Exit 1
}

# Check if the user has repositories
if ($Repos.Count -eq 0) {
    Write-Host "No repositories found for user $GitHubUser." -ForegroundColor Yellow
    Exit 1
}

# Create a folder for the user's repositories
$RepoDir = Join-Path -Path (Get-Location) -ChildPath $GitHubUser
if (-Not (Test-Path $RepoDir)) {
    New-Item -ItemType Directory -Path $RepoDir | Out-Null
}

# Clone each repository
Write-Host "Cloning repositories for user: $GitHubUser..." -ForegroundColor Cyan
foreach ($Repo in $Repos) {
    $CloneUrl = $Repo.clone_url
    $RepoName = $Repo.name
    $RepoPath = Join-Path -Path $RepoDir -ChildPath $RepoName

    if (Test-Path $RepoPath) {
        Write-Host "Skipping '$RepoName' (already exists)" -ForegroundColor Yellow
    } else {
        git clone $CloneUrl $RepoPath
    }
}

Write-Host "All repositories cloned successfully into $RepoDir" -ForegroundColor Green
