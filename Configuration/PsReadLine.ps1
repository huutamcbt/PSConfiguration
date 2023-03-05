# Check the existence of PSReadLine
try {
    If ((Get-Module).Name.Contains("PSReadLine") -eq $false) {
        Install-Module -Name "PSReadLine"    
    }
    
    Import-Module PSReadLine
    
    # Shows navigable menu of all options when hitting Tab
    Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
    
    # Autocompleteion for Arrow keys
    Set-PSReadLineOption -HistorySearchCursorMovesToEnd
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
    
    Set-PSReadLineOption -ShowToolTips
    Set-PSReadLineOption -PredictionSource History
    
}
catch {
    
}