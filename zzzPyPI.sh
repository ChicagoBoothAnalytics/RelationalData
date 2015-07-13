#!/usr/bin/env bash
pip install -e .
# or:
# python setup.py develop
python setup.py sdist bdist_wheel --universal
python setup.py register
twine upload dist/*
# or:
# python setup.py sdist bdist_wheel upload
