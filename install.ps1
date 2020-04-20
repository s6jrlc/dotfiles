#echo "Touch the script?"

$prof_repo = "https://github.com/s6jrlc/dotfiles/archive/master.zip"
$prof_file = Split-Path $uri.AbsolutePath -Leaf
$prof_path = Join-Path $env:USERPROFILE $file
$repo_uri = New-Object System.Uri($prof_repo)

$cli = New-Object System.Net.WebClient
$cli.DownloadFile($repo_uri, $prof_path)
#Expand-Archive -Path $file_path -DestinationPath 

echo $repo_uri
echo $prof_file
echo $prof_path
