try {
    [string[]]$local:extensions = @("enkia.tokyo-night","ms-vscode.powershell","PKief.material-icon-theme", 
                                    "pustelto.bracketeer", "shd101wyy.markdown-preview-enhanced", "tomoki1207.pdf", 
                                    "zhuangtongfa.material-theme", "ritwickdey.LiveServer", "ryuta46.multi-command"
                                    )
                                    # Comment this background extension which is not used in current setting
                                    # "shalldie.background"
    [string[]]$local:installedExtensions = code.cmd --list-extensions
    
    If(Get-Command code.cmd -ErrorAction Stop){
        foreach($local:extension in $local:extensions){
            If(-Not $local:installedExtensions.Contains($local:extension)){
                code.cmd --install-extension $local:extension
            }
        }
    }
}
catch {
    
}