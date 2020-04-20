#echo "Touch the script?"

$prof_repo = "https://github.com/s6jrlc/dotfiles/archive/master.zip"
$repo_uri = New-Object System.Uri($prof_repo)
$prof_file = Split-Path $repo_uri.AbsolutePath -Leaf
$prof_path = Join-Path $env:USERPROFILE $file

echo $prof_repo
echo $prof_file
echo $prof_path

$cli = New-Object System.Net.WebClient
$cli.DownloadFile($repo_uri, $prof_path)
#Expand-Archive -Path $file_path -DestinationPath 
