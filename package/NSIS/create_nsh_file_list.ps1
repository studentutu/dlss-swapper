
# Build temp file for installer script to know what files are getting installed.
$FileListFile = "NSIS/FileList.nsh"

# Delete the original file if it exists
if (Test-Path -Path $FileListFile)
{
    Remove-Item -Path $FileListFile
}
'; Auto-generated by create_nsh_file_list.ps1, do not commit' | Out-File -FilePath $FileListFile -Append
 

$FilesPath = "..\src\bin\publish\unpackaged\"
$AbsoluteFilesPath = Resolve-Path (Join-Path $PWD $FilesPath)


$Files = Get-ChildItem -Path $AbsoluteFilesPath -Recurse -Directory
foreach ($File in $Files)
{
    $FullPath = $File.FullName;
    $RelativePath = $FullPath.Replace($AbsoluteFilesPath, "")
    #Write-Host "!insertmacro CreateDirectoryToInstaller `"$RelativePath`"
    "!insertmacro CreateDirectoryToInstaller `"$RelativePath`"" | Out-File -FilePath $FileListFile -Append
}

$Files = Get-ChildItem -Path $AbsoluteFilesPath -Recurse -File
foreach ($File in $Files)
{
    $FullPath = $File.FullName;
    $RelativePath = $FullPath.Replace($AbsoluteFilesPath, "")
    #Write-Host "!insertmacro AddFileToInstaller `"$RelativePath`" `"$FullPath`"" 
    "!insertmacro AddFileToInstaller `"$RelativePath`" `"$FullPath`"" | Out-File -FilePath $FileListFile -Append
}


