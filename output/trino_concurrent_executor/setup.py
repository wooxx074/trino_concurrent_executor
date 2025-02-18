import setuptools

with open("README.md", "r") as fh:
    long_description = fh.read()


class BinaryDistribution(setuptools.Distribution):
    def has_ext_modules(_):
        return True


setuptools.setup(
    name="trino_concurrent_executor",
    version="0.1.0",
    author="Calvin Woo",
    author_email="calvin.woo@gusto.com",
    description="",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/wooxx074/trino_concurrent_executor",
    packages=setuptools.find_packages(),
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: BSD License",
        "Operating System :: OS Independent",
    ],
    include_package_data=True,
    distclass=BinaryDistribution,
)
