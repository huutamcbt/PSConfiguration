# Check the existence of oh-my-posh application
# And set the tokyonight theme as the oh-my-posh default theme
try {
    if (Get-Command oh-my-posh.exe -ErrorAction Stop) {
        oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/tokyonight_storm.omp.json" | Invoke-Expression
    }
}
catch {
   
}