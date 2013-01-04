$semver_file_name = ".\.semver"

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

    major: 1
    minor: 0
    patch: 0
    .EXAMPLE
    Invoke-Semver -Increment major
    Increments the major version number by 1.  If the version number was previously 1.0.0, it will now be 2.0.0
    .LINK
    https://github.com/bahrens/poshsemver
    #>
    param(
        [Parameter(Position=0,Mandatory=0,HelpMessage="Options are major, minor, patch")]
        [ValidateSet("major", "minor", "patch")]
        [string]
        $Increment,
        [Parameter(Position=0,Mandatory=0,HelpMessage="Options are %M, %m, %p")]
        [ValidateSet("%M", "%m", "%p")]
        [string]
        $Format)

    New-IfSemverNotExist

    $semver_content = (Get-Content $semver_file_name)

    if ($Increment -eq "major") {
        Save-Version $semver_content 0
    }
    elseif ($Increment -eq "minor") {
        Save-Version $semver_content 1
    }
    elseif ($Increment -eq "patch") {
        Save-Version $semver_content 2
    }

    $semver_content
}

function Save-Version($semver_content, $index) {
    $semver_content[$index] = Get-Version $Increment $semver_content[$index]
    $semver_content | Out-File -filepath $semver_file_name
}

function Get-Version($version_part, $version_line) {
    [void]($version_line -match "$version_part`:(\s+)?(?<number>\d+)")
    $number = [int]$matches['number']
    $number = $number + 1
    $new_version_line = "$version_part`: $number"
    return $new_version_line
}

function New-IfSemverNotExist {
    if (!(Test-Path $semver_file_name)) {
        New-SemverFile
    }
}

function New-SemverFile {
    $contents = 
@"
major: 0
minor: 0
patch: 0
"@

    $contents | Out-File -filepath $semver_file_name
}
