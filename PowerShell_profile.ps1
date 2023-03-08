If (($IsWindows -eq $true) -or (Get-Command powershell.exe -ErrorAction SilentlyContinue)) {
    # Get the current directory of this powershell file
    [string]$local:currentLocation = Split-Path -Parent $MyInvocation.MyCommand.Definition
    # import some essential files
    . "$currentLocation\Utilities\SystemFunction.ps1"
    . "$currentLocation\Utilities\WindowsPackageManager.ps1"
    . "$currentLocation\Utilities\Alias.ps1"
    . "$currentLocation\Utilities\GetSize.ps1"
    # Configuration
    . "$currentLocation\Configuration\EnvironmentVariable.ps1"    
    . "$currentLocation\Configuration\Oh-My-Posh.ps1"    
    . "$currentLocation\Configuration\PSReadLine.ps1"    
    . "$currentLocation\Configuration\VSCode.ps1"
    . "$currentLocation\Configuration\Scoop.ps1"
    #########################################################################################################################
    # This is a customizable Windows Package Manager Function
    # Reset the Installed property of all packages which are used in wpm command
    [SystemFunction]::SetStatusOfPackage()
    
    Function WindowsPackageManager {
        <#
        .SYNOPSIS
            
        .DESCRIPTION
            WindowsPackageManager is a function that help a user easily manages some essential packages.
            It can be used to install, uninstall package. Beside user can list all installed packages, show information of specific package,
            search the existence of specific package in the system, check the version of this utility  
            
        .EXAMPLE
             wpm install --name Scoop
             To install scoop application 
            
        .EXAMPLE
             wpm uninstall --id Scoop.Scoop
             To uninstall scoop application
            
        .EXAMPLE
             wpm list 
             To list all installed packages
            
        .INPUTS
            String
            
        .OUTPUTS
            None
            
        .NOTES
            Author:  Nguyen Huu Tam
            Website: http://mikefrobbins.com
        #>

        [CmdletBinding()]
        Param(
            [Parameter(Mandatory)]
            [ValidateSet("install", "show", "list", "search", "uninstall", "--version", "--info", "--help")]
            [string]$Command,
            [ValidateSet("--version", "--info", "--help","--name", "--id")]
            [string]$Options,
            [string]$Package
        )   
        [string[]]$local:commandArray = "install", "show", "list", "search", "uninstall"
        [string[]]$local:optionArray = "-v", "--version", "--info", "-?", '--help'
        #$commandDictionary = @{ install = "Install"; show = "Show"; list = "List"; search  = "Search"; uninstall = "Uninstall"}
        
        If (($Command -in $local:commandArray) -or ($Command -in $local:optionArray)) {
            
            switch ($Command) {
                "install" { 
                    [WindowsPackageManager]::Install($Options, $Package) ;
                    [SystemFunction]::SetStatusOfPackage();
                    # Reload the profile to install some essential pakages
                    . $PROFILE.CurrentUserCurrentHost;
                }
                "uninstall" { 
                    [WindowsPackageManager]::Uninstall($Options, $Package);
                    [SystemFunction]::SetStatusOfPackage();
                    . $PROFILE.CurrentUserCurrentHost;
                }
                "list" { [WindowsPackageManager]::List($Options, $Package) }
                "search" { [WindowsPackageManager]::Search($Options, $Package) }
                "show" { [WindowsPackageManager]::Show($Options, $Package) }
                #"-v" { [WindowsPackageManager]::ShowVersion() }
                "--version" { [WindowsPackageManager]::ShowVersion() }
                "--info" { [WindowsPackageManager]::ShowWPMInfo() }
                #"-?" { [WindowsPackageManager]::ShowWPMInstruction() }
                "--help" { [WindowsPackageManager]::ShowWPMInstruction() }
                Default {}
            }
        }
        else {
            [WindowsPackageManager]::ShowWPMInstruction()
        }
    }
    
    #########################################################################################################################

    Function Get-Size {
        <#
        .SYNOPSIS
            
        .DESCRIPTION
            Get-Size is a function that help a user get the size (length) of specific file or 
            folder with specific unit. This function will list name and size of an item 
                
        .EXAMPLE
             Get-Size -Path [String] -Unit GB 
             To show the size of the file or folder
            
        .INPUTS
            String, Unit
            
        .OUTPUTS
            [PSCustomObject]@{
                "Name" = [string],
                "Size" = [double]Unit
            }
        
        .NOTES
            Author:  Nguyen Huu Tam
            Website: http://mikefrobbins.com
        #>
        [CmdletBinding()]
        Param(
            #[Paramameter(Mandatory)]
            [string]$Path,
            [string]$Unit
        )
        If ((-Not ($Path -eq "")) -and (-Not ($null -eq $Path))) {
            $fullPath = (Get-ChildItem -Path $Path).FullName
            [GetSize]::CalculateTheSize($fullPath, $Unit)
        }
        Else {
            Write-Host "Oops, Something went wrong!"
        }
    }
}

