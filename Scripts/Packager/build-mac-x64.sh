#!/bin/bash

arch=x64
configuration=Release  
os_platform=osx
log_prefix=MAC-BUILD
build_directory=$(dirname $(dirname "$PWD"))
release_directory="/tmp/x1/${log_prefix}"
node_directory=$build_directory/x1-blockcore/src/X1/X1Daemon

# exit if error
set -o errexit

# print out a few variables
echo "current environment variables:"
echo "OS name:" $os_platform
echo "Build directory:" $build_directory
echo "Architecture:" $arch
echo "Configuration:" $configuration

dotnet --info

# Initialize dependencies
echo $log_prefix STARTED restoring dotnet and npm packages
cd $build_directory
git submodule update --init --recursive

cd $build_directory/src

echo $log_prefix Running npm install
sudo npm install --verbose

echo $log_prefix FINISHED restoring dotnet and npm packages

# dotnet publish
echo $log_prefix running 'dotnet publish'
cd $node_directory
sudo dotnet restore
sudo dotnet publish -c $configuration -r $os_platform-$arch -v m -o $build_directory/src/daemon

echo $log_prefix chmoding the Redstone.RedstoneFullNodeD file
sudo chmod +x $build_directory/src/daemon/Daemon*

# node packaging
echo $log_prefix Building and packaging src
cd $build_directory/src
sudo npm run package:mac --$arch
echo $log_prefix finished packaging

echo $log_prefix contents of build_directory
cd $build_directory
ls

echo $log_prefix contents of the app-builds folder
cd $build_directory/src/app-builds/
# replace the spaces in the name with a dot as CI system have trouble handling spaces in names.
for file in *.{tar.gz,deb}; do mv "$file" `echo $file | tr ' ' '.'` 2>/dev/null || : ; done

ls -al -h

# Move files to release directory
sudo rm -rf $release_directory
sudo mkdir -p $release_directory
sudo cp -r $build_directory/src/app-builds/* $release_directory

#Clear previous builds
sudo rm -rf $build_directory/src/app-builds
sudo rm -rf $build_directory/src/daemon
sudo rm -rf $build_directory/src/dist

echo $log_prefix FINISHED build

echo $log_prefix FINISHED build
