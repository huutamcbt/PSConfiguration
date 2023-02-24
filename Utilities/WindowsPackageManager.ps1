# This class is used to manage the method related to WPM actions such as install, uninstall, search,...
class WindowsPackageManager{
    # Install method is responsible for package installing 
    static [void] Install([string]$IOpt, [string]$Package) {
        try {
            
            If($IOpt -eq "--name"){
                switch ($Package) {
                    "scoop" 
                    {  
                        If((Get-Command scoop.ps1 -ErrorAction SilentlyContinue) -or (Get-Command scoop.cmd -ErrorAction SilentlyContinue)){
                            Write-Host "The scoop application is already installed"
                        #    return true 
                        }
                        Else{
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
                    "chocolatey"
                    {

                    }
                    Default {}
                }
            }Elseif(($IOpt -eq "--help") -or($IOpt -eq "-?")){
                [WindowsPackageManager]::ShowInstallInstruction()
               
            }Else{
                [WindowsPackageManager]::ShowLackInstallInstruction()    
            }
        }
        catch {

        }
    }

    # Uninstall method is responsible for package uninstalling
    static [void] Uninstall([string]$IOpt, [string]$Package){
        try {
            If($IOpt -eq "--name"){
                switch ($Package) {
                    "scoop" 
                    {  
                        If((-Not (Get-Command scoop.ps1 -ErrorAction SilentlyContinue)) -and  (-Not (Get-Command scoop.cmd -ErrorAction SilentlyContinue))){
                            Write-Host "The scoop application is already uninstalled"
                        }
                        Else{
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
                    "chocolatey"
                    {

                    }
                    Default {}
                }
            }
        }
        catch {
            
        }
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
    
    static [void] ShowVersion(){
        Write-Host "v1.0"
    }

    static [void] ShowInfo(){
        Write-Host "Customizable Windows Package Manager v1.0"
        Write-Host "Copyright (c) huutamcbt `n"
        Write-Host "Windows: Windows.Desktop"
        Write-Host "System Architecture: X64"
    }

}