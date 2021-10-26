# Prepare cmake builddir

```bash
cmake -Bbuilddir -GNinja -DCMAKE_BUILD_TYPE=Release
```

# Build and install

```bash
cd builddir
ninja
```

# Clean rebuild

```bash
cmake --build builddir/ --clean-first
```
