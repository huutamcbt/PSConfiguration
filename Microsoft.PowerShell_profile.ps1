# Check the existence of oh-my-posh application
# And set the tokyonight theme as the oh-my-posh default theme
try {
    if (Get-Command oh-my-posh.exe) {
        oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/tokyonight_storm.omp.json" | Invoke-Expression
    }
}
catch {
    <#Do this if a terminating exception happens#>
}

#########################################################################################################################
# This is a customizable Windows Package Manager Function
Function wpm {
    [CmdletBinding()]
    Param(
        # [Parameter(Mandatory)]
        [string]$Command,
        # [Parameter(Mandatory)]
        [string]$Options,
        [string]$Package = ""
    )   
    [string[]]$local:commandArray = "install", "show", "list", "search", "uninstall"
    [string[]]$local:optionArray = "-v", "--version", "--info", "-?", '--help'
    #$commandDictionary = @{ install = "Install"; show = "Show"; list = "List"; search  = "Search"; uninstall = "Uninstall"}

    If (($Command -in $local:commandArray) -or ($Command -in $local:optionArray)) {
        switch ($Command) {
            "install" { [WindowsPackageManager]::Install($Options, $Package) }
            Default {}
        }
    }
    else {
        [WindowsPackageManager]::ShowWPMInfo()
    }
}

class WindowsPackageManager{
    static [bool] Install([string]$IOpt, [string]$Package) {
        try {
            If($IOpt -eq "--name"){
                switch ($Package) {
                    "scoop" 
                    {  
                        If((Get-Command scoop.ps1) -or (Get-Command scoop.cmd)){
                            Write-Host "The scoop application is already installed"
                           return true 
                        }
                        Else{
                            try {
                                Set-ExecutionPolicy RemoteSigned -Scope CurrentUser;
                                Invoke-RestMethod get.scoop.sh | Invoke-Expression 
                                return true
                            }
                            catch {
                                return false
                            }
                        }
                    }
                    "chocolatey"
                    {

                    }
                    Default {}
                }
            }
            return true
        }
        catch {
            
        }
        return false
    }
    
    static [void] ShowInstallInfo() {
        Write-Host "Customizable Windows Package Manager v1.0 `n"
        Write-Host "Installs the selected package. By default, the query must case-insensitively match the name. Other 
        fields can be used by passing their appropriate option `n"
        Write-Host "usage: wpm  install [<options>] `n"
        Write-Host "The following options are available:"
        Write-Host "  --name" -ForegroundColor White -NoNewline; Write-Host "`t Filter results by name"
        Write-Host "  -?,--help" -ForegroundColor White -NoNewline; Write-Host "`t Shows help about the selected command `n"
    }
    
    static [void] ShowWPMInfo() {
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
}


#########################################################################################################################

