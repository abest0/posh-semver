posh-semver
==========

Is a simple PowerShell script for managing semantic versioning.

### What is semantic versioning?

Semantic versioning is a specification written by Tom Preston-Werner. Semantic versioning is a set of rules on how to version software and to avoid "dependency hell". Here is a quick summary of the semantic versioning rules, however, I encourage you to read the full spec at [semver.org](http://semver.org).

Consider a version number with the scheme X.Y.Z (Major.Minor.Patch). The rules are as follows:

* Patch should be incremented when any non-breaking bugfixes occur.
* Minor should be incremented when any non-breaking changes and/or additions occur.
* Major should be incremented when any breaking changes occur.

Usage
-----

The following command will create a new .semver file with major, minor, and patch set to 0. If a .semver file does exist, it will read the file and output the current version number to the terminal as a string in the format of v%M.%m.%p

	Invoke-Semver

To increment a version number part, use the Invoke-Semver command with -Increment switch and one of the following options: major, minor, patch

	Invoke-Semver -Increment major

To set the special string, use the Invoke-Semver command with -Special and the string you wish to use.

	Invoke-Semver -Special alpha

To format the version number, you can use the following special format characters: %M (for major), %m (for minor), %p (for patch), $s (for special)

	Invoke-Semver -Format %M.%m.%p%s

You can also combine -Increment, -Special, -Format in any combination with the Invoke-Semver command.

License
-------

The MIT License (MIT)
 
Copyright © 2013 Nebula Applications, LLC

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.