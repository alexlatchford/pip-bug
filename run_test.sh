#!/bin/bash

set -x

echo ">>> Starting..."
python3 --version
python3 -m venv env
source env/bin/activate

echo ">>> Setting up environment..."
pip install -U pip==20.1.1 wheel==0.34.2

echo ">>> Building packages..."
cd transitive-a && python3 setup.py bdist_wheel
cd ../transitive-b && python3 setup.py bdist_wheel
cd .. && python3 setup.py bdist_wheel

echo ">>> Installing transitive dependency at bad version..."
pip list
pip install google-auth==1.11.3 --force-reinstall
pip list
read -r -a gauth <<< $(pip list | grep "google-auth")

echo ">>> Installing test package to see if we can resolve it..."
while [ "${gauth[1]}" == "1.11.3" ]; do
    pip install "dist/alexla_test_package-0.0.1-py3-none-any.whl" --upgrade -f transitive-a/dist -f transitive-b/dist
    pip list
    read -r -a gauth <<< $(pip list | grep "google-auth")
    echo ">>> Updated, got google-auth==${gauth[1]}"
done

echo ">>> Cleaning up..."
deactivate
rm -rf *.egg-info build dist env transitive-*/dist transitive-*/build transitive-*/*.egg-info
echo ">>> Finished"
