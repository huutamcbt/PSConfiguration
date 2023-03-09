class GetSize {
    static [void] CalculateTheSize([string]$Path, [string]$Unit) {
        switch ($Unit.ToLower()) {
                "b" {
                    Write-Host "Name:`t" -ForegroundColor Green -NoNewline; 
                    Write-Host $Path;
                    Write-Host "Size:`t" -ForegroundColor Green -NoNewline;
                    Write-Host "$((Get-ChildItem  $Path -Recurse -Force| Measure-Object -Property Length -Sum).sum)" -NoNewline;
                    Write-Host "B" -ForegroundColor Red
                }
                "kb" {
                    Write-Host "Name:`t" -ForegroundColor Green -NoNewline; 
                    Write-Host $Path;
                    Write-Host "Size:`t" -ForegroundColor Green -NoNewline;
                    Write-Host "$((Get-ChildItem  $Path -Recurse -Force| Measure-Object -Property Length -Sum).sum / 1KB)" -NoNewline;
                    Write-Host "KB" -ForegroundColor Red
                }
                "mb" {
                    Write-Host "Name:`t" -ForegroundColor Green -NoNewline; 
                    Write-Host $Path;
                    Write-Host "Size:`t" -ForegroundColor Green -NoNewline;
                    Write-Host "$((Get-ChildItem  $Path  -Force -Recurse| Measure-Object -Property Length -Sum).sum / 1MB)" -NoNewline;
                    Write-Host "MB" -ForegroundColor Red
                }
                "gb" {
                    Write-Host "Name:`t" -ForegroundColor Green -NoNewline; 
                    Write-Host $Path;
                    Write-Host "Size:`t" -ForegroundColor Green -NoNewline;
                    Write-Host "$((Get-ChildItem  $Path -Force -Recurse| Measure-Object -Property Length -Sum).sum / 1GB)" -NoNewline;
                    Write-Host "GB" -ForegroundColor Red
                }
                "tb" {
                    Write-Host "Name:`t" -ForegroundColor Green -NoNewline; 
                    Write-Host $Path;
                    Write-Host "Size:`t" -ForegroundColor Green -NoNewline;
                    Write-Host "$((Get-ChildItem  $Path -Force -Recurse| Measure-Object -Property Length -Sum).sum / 1TB)" -NoNewline;
                    Write-Host "TB" -ForegroundColor Red
                }
                "pb" {
                    Write-Host "Name:`t" -ForegroundColor Green -NoNewline; 
                    Write-Host $Path;
                    Write-Host "Size:`t" -ForegroundColor Green -NoNewline;
                    Write-Host "$((Get-ChildItem  $Path -Recurse -Force| Measure-Object -Property Length -Sum).sum / 1PB)" -NoNewline;
                    Write-Host "PB" -ForegroundColor Red
                }
                Default {}
            }
    }
}