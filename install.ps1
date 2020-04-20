#echo "Touch the script?"

$prof_repo = "https://github.com/s6jrlc/dotfiles/archive/master.zip"
$repo_uri = New-Object System.Uri($prof_repo)
$prof_zip = Split-Path $repo_uri.AbsolutePath -Leaf
$zip_path = Join-Path $env:USERPROFILE $prof_zip
$prof_path = Join-Path $env:USERPROFILE "_dotfiles"
$vim_prof_path = Join-Path $prof_path ".vim"

echo $prof_repo
echo $prof_file
echo $prof_path

$cli = New-Object System.Net.WebClient
$cli.DownloadFile($repo_uri, $zip_path)
Expand-Archive -Path $zip_path -DestinationPath $env:USERPROFILE -Force
Rename-Item (Join-Path $env:USERPROFILE "dotfiles-master") -newName $prof_path -Force
New-Item -Value $vim_prof_path -Path $env:USERPROFILE -Name "_vimfiles" -ItemType SymbolicLink
