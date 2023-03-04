class SystemFunction {
    static [void] SetStatusOfPackage(){
        [string]$local:path = Split-Path -Parent $PSScriptRoot
        [PSCustomOBject]$local:packages = [PSCustomObject](Get-Content -Path "$local:path\Data\wpm_packages.json" | ConvertFrom-Json)
        # The for loop is used to set the Installed property for the installed package
        for ($i = 0; $i -lt $local:packages.Count; $i++) {
            If(Get-Command $local:packages[$i].Command -ErrorAction SilentlyContinue ){
                $local:packages[$i].Installed  = $true
            }
            Else{
                $local:packages[$i].Installed = $false
            }
        }
        
        Out-File -InputObject ( $local:packages |ConvertTo-Json) -FilePath "$local:path\Data\wpm_packages.json"
    }
}

