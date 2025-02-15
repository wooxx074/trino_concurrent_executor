from setuptools import setup, find_packages

setup(
    name='trino_concurrent_executor',
    version='0.1.0',
    packages=find_packages(),
    install_requires=[
        # List your dependencies here
    ],
    author='Calvin Woo',
    description='Use Go\'s concurrency to manage Trino queries.',
    long_description=open('README.md').read(),
    long_description_content_type='text/markdown',
    url='',
)