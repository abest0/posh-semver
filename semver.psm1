$semver_file_name = ".\.semver"

$MAJOR_LINE = 1
$MINOR_LINE = 2
$PATCH_LINE = 3
$SPECIAL_LINE = 4

function Invoke-Semver {
    <#
    .SYNOPSIS
    Provides semantic version tracking.
    .DESCRIPTION
    Invoke-Semver provides semantic version tracking. When invoking this command, if semantic versioning does
    not current exist, a new .semver file will be created to track semantic versioning.  It also provides commands
    to increment the version numbers, and the ability to format the versioning information in a string.
    .EXAMPLE
    Invoke-Semver
    Outputs the current version information:

    --------
    major: 1
    minor: 0
    patch: 0
    special: ''
    .EXAMPLE
    Invoke-Semver -Increment major
    Increments the major version number by 1.  If the version number was previously 1.0.0, it will now be 2.0.0
    .EXAMPLE
    Invoke-Semver -Special alpha
    Sets the special version suffix.

    --------
    major: 1
    minor: 0
    patch: 0
    special: 'alpha'
    .LINK
    https://github.com/bahrens/posh-semver
    #>
    param(
        [Parameter(Position=0,Mandatory=0,HelpMessage="Options are major, minor, patch")]
        [ValidateSet("major", "minor", "patch")]
        [string]
        $Increment,
        [Parameter(Position=0,Mandatory=0,HelpMessage="Set a special version suffix")]
        [string]
        $Special,
        [Parameter(Position=0,Mandatory=0,HelpMessage="Options are %M, %m, %p, %s")]
        [ValidateSet("%M", "%m", "%p", "%s")]
        [string]
        $Format)

    New-IfSemverNotExist

    $semver_content = (Get-Content $semver_file_name)

    if ($Increment -eq "major") {
        $version = Get-Version $semver_content $MAJOR_LINE
        Save-NewVersion $semver_content $MAJOR_LINE "major" $version
    }
    elseif ($Increment -eq "minor") {
        $version = Get-Version $semver_content $MINOR_LINE
        Save-NewVersion $semver_content $MINOR_LINE "minor" $version
    }
    elseif ($Increment -eq "patch") {
        $version = Get-Version $semver_content $PATCH_LINE
        Save-NewVersion $semver_content $PATCH_LINE "patch" $version
    }

    if ($Special -ne $null) {
        Save-NewVersion $semver_content $SPECIAL_LINE "special" "'$Special'"
    }

    if ($Format -ne $null) {
        Get-Format $
    }

    $semver_content
}

function Get-Version($semver_content, $index) {
    [void]($semver_content[$index] -match "(?<number>\d+)")
    $version = [int]$matches['number']
    return $version + 1
}

function Save-NewVersion($semver_content, $index, $version_part, $version) {
    $semver_content[$index] = "$version_part`: $version"
    $semver_content | Out-File -filepath $semver_file_name
}

function New-IfSemverNotExist {
    if (!(Test-Path $semver_file_name)) {
        New-SemverFile
    }
}

function New-SemverFile {
    $contents = 
@"
--------
major: 0
minor: 0
patch: 0
special: ''
"@

    $contents | Out-File -filepath $semver_file_name
}
