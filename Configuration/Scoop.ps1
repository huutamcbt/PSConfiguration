[string]$scoopPackages = @("ntop", "touch", "sudo");
try {
    If(Get-Command scoop -ErrorAction Stop){
        foreach($package in $scoopPackages){
            If(-Not(Get-Command $package -ErrorAction SilentlyContinue)){
                scoop install $package
            }
        }
    }
}
catch {
    
}