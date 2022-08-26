import os
from setuptools import setup

setup(
  name='dbcurtain',
  version=os.environ.get('version_number'),
  description='DBCurtain is a Python package for hiding the details of databases.',
  packages=[
    'dbcurtain'
  ],
  package_data={
    '': [
      '*.yaml'
    ]
  },
  package_dir={'': 'src', }
)