rmdir .\bin -force -recursemkdir .\bin\nuget\toolsgci -path .\source | cp -destination .\bin\nuget\toolsgci -path .\nuget | cp -destination .\bin\nuget\.\nuget pack .\bin\nuget\posh-semver.nuspec -outputdirectory .\bin\nuget