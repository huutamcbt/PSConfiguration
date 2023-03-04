If (($IsWindows -eq $true) -or (Get-Command powershell.exe -ErrorAction SilentlyContinue)) {
    # Get the current directory of this powershell file
    [string]$local:currentLocation = Split-Path -Parent $MyInvocation.MyCommand.Definition
    # import some essential files
    . "$currentLocation\Utilities\SystemFunction.ps1"
    . "$currentLocation\Utilities\WindowsPackageManager.ps1"
    . "$currentLocation\Utilities\Alias.ps1"
    

    # Add JAVA_HOME to the Path environment variable
    $Env:Path += ';$JAVA_HOME\bin'

    # Check the existence of oh-my-posh application
    # And set the tokyonight theme as the oh-my-posh default theme
    try {
        if (Get-Command oh-my-posh.exe -ErrorAction Stop) {
            oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/tokyonight_storm.omp.json" | Invoke-Expression
        }
    }
    catch {
       
    }

    
    
    # Reset the Installed property of all packages which are used in wpm command
    [SystemFunction]::SetStatusOfPackage()
    
    #########################################################################################################################
    # This is a customizable Windows Package Manager Function
    Function wpm {
        [CmdletBinding()]
        Param(
            # [Parameter(Mandatory)]
            [string]$Command,
            # [Parameter(Mandatory)]
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
                    [SystemFunction]::SetStatusOfPackage()
                }
                "uninstall" { 
                    [WindowsPackageManager]::Uninstall($Options, $Package);
                    [SystemFunction]::SetStatusOfPackage() 
                }
                "list" { [WindowsPackageManager]::List($Options, $Package) }
                "search" { [WindowsPackageManager]::Search($Options, $Package) }
                "show" { [WindowsPackageManager]::Show($Options, $Package) }
                #"-v" { [WindowsPackageManager]::ShowVersion() }
                "--version" { [WindowsPackageManager]::ShowVersion() }
                "--info" { [WindowsPackageManager]::ShowInfo() }
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

    
    
}

