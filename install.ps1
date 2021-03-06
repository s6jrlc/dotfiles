#
# install.ps1
#

$prof_repo = "https://github.com/s6jrlc/dotfiles/archive/master.zip"
$repo_uri = New-Object System.Uri($prof_repo)
$prof_zip = Split-Path $repo_uri.AbsolutePath -Leaf
$zip_path = Join-Path $env:USERPROFILE $prof_zip
$prof_path = Join-Path $env:USERPROFILE "_dotfiles"
$vim_prof_path = Join-Path $prof_path ".vim"

$cli = New-Object System.Net.WebClient
$cli.DownloadFile($repo_uri, $zip_path)
Expand-Archive -Path $zip_path -DestinationPath $env:USERPROFILE -Force
If (Test-Path $prof_path) {
	Remove-Item $prof_path -Recurse -Force
}
Rename-Item (Join-Path $env:USERPROFILE "dotfiles-master") -newName $prof_path -Force
New-Item -Value $vim_prof_path -Path $env:USERPROFILE -Name "vimfiles" -ItemType SymbolicLink -Force
