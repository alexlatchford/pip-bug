# Transitive dependency installation bug

If a package is installed within a virtual environment with a version range compatible with
some, but not all of the ranges another package that is installed later requires it will not be
uninstalled and upgraded.

## How to recreate

Execute `./run_test.sh` until it fails, it seems indeterminate.
