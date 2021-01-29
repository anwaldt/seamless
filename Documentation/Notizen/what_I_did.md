# WFS / Ambisonics System aufsetzen
- UbuntuStudio 20.04 installiert
- Installation: git, meson, build-essential, scons, qt5-default, libxml++2.6-dev, libjack-jackd2-dev, liblo-dev
- Wonder Lite geklont (https://gitlab.tubit.tu-berlin.de/TU_Studio/wonder-lite)
- meson --buildtype release builddiir; ninja -C builddir
- sudo mkdir -p /opt/wonder/wonderWinter
- scons -c all=1
- scons cwonder=1 twonder=1 installto=/opt/wonder/wonderWinter
- sudo scons install cwonder=1 twonder=1 installto=/opt/wonder/wonderWinter
- find /opt/wonder/wonderWinter/scripts -type f -name "*.sh" -exec sudo chmod ugo+x -- {} +
- sudo ln -s wonderWinter/ current

## Config
cp -r configs_tuberlin /opt/wonder/current/
mv configs configs_HAW
ln -s configs_tuberlin/ configs

cd /opt/wonder/current/scripts/
mv configs configs_HAW
root@riviera:/opt/wonder/wonderWinter/scripts# cp -r /home/studio/Development/wonder_backup/wonder/current/scripts/configs/ .

## Hostnames
An /etc/hosts anhängen:

n101 localhost
n102 wintermute.ak.tu-berlin.de

# Riviera 27.01.
- panoramix ins home verzeichnis kopiert
- Reaper in /opt installiert inkl symlinks

## git clone supercollider
- sudo apt-get install build-essential cmake libjack-jackd2-dev libsndfile1-dev libfftw3-dev libxt-dev libavahi-client-dev
- sudo apt-get install git libasound2-dev libicu-dev libreadline6-dev libudev-dev pkg-config libncurses5-dev
- sudo apt-get install qt5-default qt5-qmake qttools5-dev qttools5-dev-tools qtdeclarative5-dev qtwebengine5-dev libqt5svg5-dev libqt5websockets5-dev
- git submodule init
- git submodule update
- mkdir build; cd build
- cmake -DCMAKE_BUILD_TYPE=Release -DNATIVE=ON -DSC_EL=no -DSC_ABLETON_LINK=off ..
- make -j 16
- sudo make install
- sudo ldconfig

## git clone ssr
- sudo apt install libasio-dev libwebsocketpp-dev libmysofa-dev
- git submodule update --init
- ./autogen.sh
- ./configure --disable-ecasound
- Abhängigkeiten sind schwer aufzulösen

## Services
[*] Jack mit RT Priorities

