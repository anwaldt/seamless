# Setting up the System


## Python Dependencies

    pip3 install oscpy


## SuperCollider

1: Build and install SC


2: Build a headless version of SC:

Follow https://github.com/supercollider/supercollider/blob/develop/README_LINUX.md but call cmake:

    cmake -DCMAKE_BUILD_TYPE=Release -DNATIVE=ON -DSC_EL=no -DSC_ABLETON_LINK=off -NO_X11=ON -DSC_QT=OFF ..

Install SC3-Plugins:

    https://github.com/supercollider/sc3-plugins

Install SC-HOA classes:

    Quarks.install("https://github.com/florian-grond/SC-HOA")


## Build Faust Reverb

Faust code for the Ambisonics reverb is located in `Faust/reverb`. The install script builds and installs the SuperCollider class and objects to the user extensions directory. Make sure install ruby before using the Faust to SC compiler.


## Developer Mode

The scripts `supercollider_gui.sh` and `supercollider_nogui.sh`
allow to switch between the standard SC install
and the headless version by setting symlinks in `/usr/local/bin`

Once the standard version is lionked, `scide` can be started for
development and debugging.

## Seamless installation

For the installation of SeamLess the Meson build system is used.

Create build directory:
```bash
meson builddir
```

Set SeamLess location (e.g. EN325, HUFO):
```bash
cd builddir
meson configure -Dlocation=HUFO
```

Installation:
```bash
sudo meson install
```

Create symlink to specific snapshot:
```bash
cd /etc/seamless
ln -s snapshots/wfs1.snap aj_snapshot_config.xml
```

## Disable Automatic Updates


Automatic updates are not desired, since they can change the
system behavior. In addition can disable the DANTE drivers.

Edit:

	/etc/apt/apt.conf.d/20auto-upgrades

It needs to be:

	APT::Periodic::Update-Package-Lists "0";
	APT::Periodic::Download-Upgradeable-Packages "0";
	APT::Periodic::AutocleanInterval "0";
	APT::Periodic::Unattended-Upgrade "1";
