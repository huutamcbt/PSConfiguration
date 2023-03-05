class GetSize {
    static [void] CalculateTheSize([string]$Path, [string]$Unit){
        switch ($Unit.ToLower()) {
            "kb" {
                Write-Host "Name: $Path";
                Write-Host "Size: " -NoNewline;
                (Get-Item  $Path | Measure-Object -Property Length -Sum).sum / 1KB ;
            }
            "mb" {
                Write-Host "Name: $Path";
                Write-Host "Size: " -NoNewline;
                Get-Item  $Path  
            }
            "gb" {
                Write-Host "Name: $Path";
                Write-Host "Size: " -NoNewline;
                (Get-Item $Path| Measure-Object -Property Length -Sum).sum / 1GB 
            }
            "tb" {
                Write-Host "Name: $Path";
                Write-Host "Size: " -NoNewline;
                (Get-Item  $Path| Measure-Object -Property Length -Sum).sum / 1TB 
            }
            "pb" {
                Write-Host "Name: $Path";
                Write-Host "Size: " -NoNewline;
                (Get-Item $Path| Measure-Object -Property Length -Sum).sum / 1PB 
            }
            Default {}
        }
    }
}