#echo "Touch the script?"

$uri_string = "https://github.com/s6jrlc/dotfiles/archive/master.zip"
$uri = New-Object System.Uri($uri_string)
$file = Split-Path $uri.AbsolutePath -Leaf
$file_path = Join-Path $env:USERPROFILE $file

$cli = New-Object System.Net.WebClient
#$cli.DownloadFile($uri, $file_path)
#Expand-Archive -Path $file_path -DestinationPath 

echo $uri_string
echo $file
echo $file_path
