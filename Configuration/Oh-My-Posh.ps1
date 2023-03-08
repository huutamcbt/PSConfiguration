# Check the existence of oh-my-posh application
# And set the tokyonight theme as the oh-my-posh default theme
[string]$themePath = "$env:POSH_THEMES_PATH/tokyonight_storm.omp.json";
# [string]$themePath = "E:\Temp_Folder\newtheme.omp.json"
try {
    if (Get-Command oh-my-posh.exe -ErrorAction Stop) {
        If(Get-Command powershell.exe -ErrorAction SilentlyContinue){
            oh-my-posh init powershell --config $themePath | Invoke-Expression
        }
        If(Get-Command pwsh.exe -ErrorAction SilentlyContinue){
            oh-my-posh init pwsh --config $themePath | Invoke-Expression
        }
    }
}
catch {
   
}