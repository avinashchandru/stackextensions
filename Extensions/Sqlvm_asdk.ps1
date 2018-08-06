Write-Host "Initiazlizing Sql...."
.\initSql.ps1
Write-Host "....Initiazlizing Sql done"

Write-Host "Initiazlizing Doc DB...."
.\docDbInit.ps1
Write-Host "....Initiazlizing Doc DB done"

Write-Host "Setting up Ibiza...."
.\IbizaSetup.ps1
Write-Host "....Set up Ibiza done"