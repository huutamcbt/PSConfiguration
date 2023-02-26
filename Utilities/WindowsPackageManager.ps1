# This class is used to manage the method related to WPM actions such as install, uninstall, search,...
class WindowsPackageManager {
    hidden [string]$currentDir =  (Split-Path -Parent $MyInvocation.MyCommand.Definition)
    # Install method is responsible for package installing 
    static [void] Install([string]$IOpt, [string]$Package) {
        try {
            
            If ($IOpt -eq "--name") {
                switch ($Package) {
                    "scoop" {  
                        If ((Get-Command scoop.ps1 -ErrorAction SilentlyContinue) -or (Get-Command scoop.cmd -ErrorAction SilentlyContinue)) {
                            Write-Host "The scoop application is already installed"
                            #    return true 
                        }
                        Else {
                            try {
                                Write-Host "The scoop is installing ..."
                                Set-ExecutionPolicy RemoteSigned -Scope CurrentUser;
                                Invoke-RestMethod get.scoop.sh | Invoke-Expression | Out-Host
                                #Write-Host "Scoop application is installed successfully"
                            }
                            catch {
                                Write-Host "Oops, something went wrong!"
                            }
                        }
                    }
                    "chocolatey" {
                        If ((Get-Command choco.exe -ErrorAction SilentlyContinue) -or (Get-Command chocolatey.exe -ErrorAction SilentlyContinue)) {
                            Write-Host "The chocolatey application is already installed"
                        }
                        Else {
                            try {
                                Write-Host "The chocolatey is installing ..."
                                # Set directory for installation - Chocolatey does not lock
                                # down the directory if not the default
                                $InstallDir = 'C:\ProgramData\chocoportable'
                                $env:ChocolateyInstall = "$InstallDir"

                                # If your PowerShell Execution policy is restrictive, you may
                                # not be able to get around that. Try setting your session to
                                # Bypass.
                                Set-ExecutionPolicy Bypass -Scope Process -Force;

                                # All install options - offline, proxy, etc at
                                # https://chocolatey.org/install
                                Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) | Out-Host
                            }
                            catch {
                                Write-Host "Oops, something went wrong!"
                            }
                        }
                    }
                    "winget" {
                        If(Get-Command winget.exe -ErrorAction SilentlyContinue){
                            Write-Host "The winget application is already installed"
                        }
                        Else{
                            try {
                                Write-Host "The winget is installing ..."
                                powershell.exe Invoke-WebRequest -Uri "https://github.com/microsoft/winget-cli/releases/download/v1.4.10173/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" `
                                -OutFile "~/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -Method Get| Out-Host
                                Start-Process -FilePath ~/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle |Out-Host
                                Remove-Item -Force ~/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
                            }
                            catch {
                                Write-Host "Oops, something went wrong!"
                            }
                        }
                    }
                    "oh-my-posh" {
                        If(Get-Command oh-my-posh.exe -ErrorAction SilentlyContinue){
                            Write-Host "The oh-my-posh application is already installed"
                        }
                        Else{
                            try {
                                Write-Host "The oh-my-posh is installing ..."
                                Set-ExecutionPolicy Bypass -Scope Process -Force; 
                                Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1')) | Out-Host
                            }
                            catch {
                                Write-Host "Oops, something went wrong!"
                            }
                        }
                    }
                    Default {}
                }
            }
            Elseif (($IOpt -eq "--help") -or ($IOpt -eq "-?")) {
                [WindowsPackageManager]::ShowInstallInstruction()
               
            }
            Else {
                [WindowsPackageManager]::ShowLackInstallInstruction()    
            }
        }
        catch {

        }
    }

    # Uninstall method is responsible for package uninstalling
    static [void] Uninstall([string]$IOpt, [string]$Package) {
        try {
            If ($IOpt -eq "--name") {
                switch ($Package) {
                    "scoop" {  
                        If ((-Not (Get-Command scoop.ps1 -ErrorAction SilentlyContinue)) -and (-Not (Get-Command scoop.cmd -ErrorAction SilentlyContinue))) {
                            Write-Host "The scoop application is already uninstalled"
                        }
                        Else {
                            try {
                                Write-Host "The scoop is uninstalling ..."
                                Remove-Item -Force -Recurse ~/scoop
                                Write-Host "The scoop is uninstalled"
                            }
                            catch {
                                Write-Host "Oops, something went wrong!"
                            }
                        }
                    }
                    "chocolatey" {
                        If ((-Not (Get-Command choco.exe -ErrorAction SilentlyContinue)) -and (-Not (Get-Command chocolatey.exe -ErrorAction SilentlyContinue))) {
                            Write-Host "The chocolatey application is already uninstalled"
                        }
                        Else {
                            try {
                                Write-Host "The chocolatey is uninstalling ..."
                                Remove-Item -Force -Recurse $env:ChocolateyInstall
                                Remove-Item -Force -Recurse 'C:\ProgramData\chocoportable'
                                Write-Host "The chocolatey is uninstalled"
                            }
                            catch {
                                Write-Host "Oops, something went wrong!"
                            }
                        }
                    }
                    "winget" {
                        If(-Not (Get-Command winget.exe -ErrorAction SilentlyContinue)){
                            Write-Host "The winget application is already uninstalled"
                        }
                        Else{
                            try {
                                Write-Host "The winget is uninstalling ..."
                                Remove-AppPackage (Get-AppPackage -Name Microsoft.DesktopAppInstaller).PackageFullName | Out-Host
                                Write-Host "The winget is uninstalled"
                            }
                            catch {
                                Write-Host "Oops, something went wrong!"
                            }
                        }
                    }
                    "oh-my-posh" {
                        If(-Not (Get-Command oh-my-posh.exe -ErrorAction SilentlyContinue)){
                            Write-Host "The oh-my-posh application is already uninstalled"
                        }
                        Else{
                            try {
                                Write-Host "The oh-my-posh is uninstalling ..."
                                Remove-Item -Recurse -Force "C:\Users\vboxuser\AppData\Local\Programs\oh-my-posh\"
                                Write-Host "The oh-my-posh is uninstalled"
                            }
                            catch {
                                Write-Host "Oops, something went wrong!"
                            }
                        }
                    }
                    Default {}
                }
            }
        }
        catch {
            
        }
    }
    
    static [void] List([string]$IOpt, [string]$Package){
        
    }

    # Show lack installing instruction
    static [void] ShowLackInstallInstruction() {
        Write-Host "Customizable Windows Package Manager v1.0 `n"
        Write-Host "No package selection argument was provided, see the help for details about finding a package `n" -ForegroundColor Red
        Write-Host "Installs the selected package. By default, the query must case-insensitively match the name. Other 
        fields can be used by passing their appropriate option `n"
        Write-Host "usage: wpm  install [<options>] `n"
        Write-Host "The following options are available:"
        Write-Host "  --name" -ForegroundColor White -NoNewline; Write-Host "`t Filter results by name"
        Write-Host "  -?,--help" -ForegroundColor White -NoNewline; Write-Host "`t Shows help about the selected command `n"
    }

    static [void] ShowInstallInstruction() {
        Write-Host "Customizable Windows Package Manager v1.0 `n"
        # Write-Host "No package selection argument was provided, see the help for details about finding a package `n"
        Write-Host "Installs the selected package. By default, the query must case-insensitively match the name. Other 
        fields can be used by passing their appropriate option `n"
        Write-Host "usage: wpm  install [<options>] `n"
        Write-Host "The following options are available:"
        Write-Host "  --name" -ForegroundColor White -NoNewline; Write-Host "`t Filter results by name"
        Write-Host "  -?,--help" -ForegroundColor White -NoNewline; Write-Host "`t Shows help about the selected command `n"
    }
    
    static [void] ShowWPMInstruction() {
        Write-Host "Customizable Windows Package Manager v1.0 `n"
        Write-Host "The wpm command line utility enables installing applications and other packages from the command line `n"
        Write-Host "usage: wpm  [<command>] [<options>] `n"
        Write-Host "The following commands are available:"
        Write-Host "  install" -ForegroundColor White -NoNewline; Write-Host "`t Installs the given package"
        Write-Host "  show" -ForegroundColor White -NoNewline; Write-Host "`t`t Shows infomation about a package"
        Write-Host "  list" -ForegroundColor White -NoNewline; Write-Host "`t`t Display installed packages"
        Write-Host "  search" -ForegroundColor White -NoNewline; Write-Host "`t Find and show basic info of packages"
        Write-Host "  uninstall" -ForegroundColor White -NoNewline; Write-Host "`t Uninstalls the given package `n"
        Write-Host "For more details on a specific command, pass it the help argument. [-?] `n"
        Write-Host "The following options are available:"
        Write-Host "  -v,--version" -ForegroundColor White -NoNewline; Write-Host "`t Display the version of the tool"
        Write-Host "  --info" -ForegroundColor White -NoNewline; Write-Host "`t Display the gereral info of the tool"
        Write-Host "  -?,--help" -ForegroundColor White -NoNewline; Write-Host "`t Shows help about the selected command `n"
        Write-Host "More help can be found at : https://archlinux.org/"
    }
    
    static [void] ShowVersion() {
        Write-Host "v1.0"
    }

    static [void] ShowInfo() {
        Write-Host "Customizable Windows Package Manager v1.0"
        Write-Host "Copyright (c) huutamcbt `n"
        Write-Host "Windows: Windows.Desktop"
        Write-Host "System Architecture: X64"
    }

}