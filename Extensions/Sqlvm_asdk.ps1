param([string]$username = "u", [string]$pwd = "p")
try{
Write-Host "Initiazlizing Sql...."
.\initSql.ps1 --u $username -p $pwd
Write-Host "....Initiazlizing Sql done"

Write-Host "Initiazlizing Doc DB...."
.\docDbInit.ps1 -u "asd" -p "1111"
Write-Host "....Initiazlizing Doc DB done"

Write-Host "Setting up Ibiza...."
.\IbizaSetup.ps1 -packageLocation "" -certSubjectName ""
Write-Host "....Set up Ibiza done"
}
 catch{
Write-Host $_.Exception
throw $_.Exception
 }
