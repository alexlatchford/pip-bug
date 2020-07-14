import os
import setuptools


setuptools.setup(
    name='alexla-test-package',
    version='0.0.1',
    install_requires=[
        'alexla-transitive-a>=0.0.1',
        'alexla-transitive-b>=0.0.1'
    ],
    dependency_links=[
        os.path.join(os.getcwd(), 'transitive-a', 'dist', 'alexla_transitive_a-0.0.1-py3-none-any.whl'),
        os.path.join(os.getcwd(), 'transitive-b', 'dist', 'alexla_transitive_b-0.0.1-py3-none-any.whl')
    ]
)
