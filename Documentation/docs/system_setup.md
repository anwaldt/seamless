# Setting up the System


## Python Dependencies

    pip3 install oscpy


## SuperCollider

Build a headless version of SC:

Follow https://github.com/supercollider/supercollider/blob/develop/README_LINUX.md but call cmake:

    cmake -DCMAKE_BUILD_TYPE=Release -DNATIVE=ON -DSC_EL=no -DSC_ABLETON_LINK=off -NO_X11=ON -DSC_QT=OFF ..

Install SC3-Plugins:

    https://github.com/supercollider/sc3-plugins

Install SC-HOA classes:

    Quarks.install("https://github.com/florian-grond/SC-HOA")

## System Services

copy all services to:

    /usr/lib/systemd/system


# Disable Automatic Updates


Automatic updates are not desired, since they can change the 
system behavior. In addition can disable the DANTE drivers.

Edit:

	/etc/apt/apt.conf.d/20auto-upgrades

It needs to be:

	APT::Periodic::Update-Package-Lists "0";
	APT::Periodic::Download-Upgradeable-Packages "0";
	APT::Periodic::AutocleanInterval "0";
	APT::Periodic::Unattended-Upgrade "1";

