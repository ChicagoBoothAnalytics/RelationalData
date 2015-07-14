# References on Packaging & Distributing Python Packages
# ______________________________________________________
# https://packaging.python.org/en/latest/distributing.html
# http://peterdowns.com/posts/first-time-with-pypi.html
# http://stackoverflow.com/questions/6344076/differences-between-distribute-distutils-setuptools-and-distutils2

from setuptools import setup


setup(
    name='HelpyFun',
    version='0.0.0',
    packages=['HelpyFun'],
    url='https://github.com/ChicagoBoothAnalytics/HelpyFun',
    author='University of Chicago Booth School of Business Analytics Club',
    author_email='MBALearnsToCode@gmail.com',
    description='Miscellaneous Python "helper" functions',
    long_description='Miscellaneous Python "helper" functions',
    license='MIT License',
    install_requires=['FrozenDict', 'NumPy', 'SymPy', 'Theano'],
    classifiers=[],   # https://pypi.python.org/pypi?%3Aaction=list_classifiers
    keywords='help helper functions python chicago booth analytics club')
