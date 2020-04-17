### TLC's dotfiles

#### installation
``` installation
$ sh -c "$(curl -L raw.github.com/s6jrlc/dotfiles/master/install.sh)"
```
or
``` installation (other)
$ sh -c "$(curl -L s6jr.com/dot)"
```

#### TO-DO
[ ] Prepare for installation on Windows PowerShell by the following command:
``` installation on Windows
PS > iex ((new-object net.webclient).DownloadString('http://example.com/url'))
```
or on Windows Cmd Prompt as Administrator:
``` installation on Windows Cmd Prompt
> @powershell -NoProfile -ExecutionPolicy Bypass -Command "echo 'PowerShell script above'"
```
