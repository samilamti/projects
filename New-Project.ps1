<#
New-Project Urls
- Creates a new "Project" wherein you can be creative

Dependencies:
- Requires git (https://git-scm.com/)
- Requires a GitHub account (https://github.com)
- Requires GitHub CLI (https://github.com/cli/cli)
#>

param(
[Parameter(Mandatory)][string]$Name
)

# Config 
$Script:ProjectsRoot = "C:\Projects"  
$Script:GitHubUser = "samilamti"  

# Create local root folder
$Root = Join-Path $Script:ProjectsRoot $Name
New-Item -Type Directory -Path $Root
Set-Location -Path $Root

# Create git repository and readme file
git init
Set-Content -Path "$Root\README.md" -Value @"
# Project $Name

Created $( Get-Date )
"@

# Set up our .gitignore
$VisualStudioGitIgnore = Invoke-WebRequest -Uri "https://github.com/github/gitignore/raw/master/VisualStudio.gitignore"

Set-Content -Path "$Root\.gitignore" -Value @"
$VisualStudioGitIgnore
"@

# Push our first version
git add .
git commit --message "Project $Name"
git branch --move main
gh repo create "$GitHubUser/$Name" --public --confirm
git push --set-upstream origin main
