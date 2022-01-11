# Prepare cmake builddir
Plugins are built separately. The cmake build depends on
FRUT. So first FRUT needs to be build.

## First Install Homebrew and CMake and Ninja
Install Homebrew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)". #Follow the directions in the terminal to finish installation
```

Install cmake: 

```bash
brew install cmake
```
Install Ninja 

```bash
pip install ninja
```

## Prepare submodules (JUCE, FRUT)
First all git submodules need to be initialized:
```bash
git submodule update --init --recursive
```

From FRUT's README.rst:

We first build and install FRUT with CMake:

```bash 

cd FRUT

mkdir build && cd build/

cmake .. -DCMAKE_INSTALL_PREFIX="../prefix" -DJUCE_ROOT="../../JUCE"
...
-- Configuring done
-- Generating done
-- Build files have been written to: <root>/FRUT/build

cmake --build . --target install
# or
cmake --build . --target install --parallel  # with CMake 3.12 or later
...
```
## Prepare and build Plugin

Build and installation example for SeamLess_Client: 
```bash
cd SeamLess_Client
cmake -Bbuilddir -GNinja -DCMAKE_BUILD_TYPE=Release
cmake --build builddir --parallel
```
Build and installation example for SeamLess_Main:
```bash
cd SeamLess_Main
cmake -Bbuilddir -GNinja -DCMAKE_BUILD_TYPE=Release
cmake --build builddir --parallel
```
# Open in Reaper
If you use a Mac with M1 chip you need to install the ARM-Version.

# Clean rebuild

```bash
cmake --build builddir/ --clean-first
```
