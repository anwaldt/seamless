# Backup with Timeshift

TimeShift offers a command line interface, but using the GUI is recommended.
As TimeShit must be run as root and you are usually logged in via SSH, you have
to enable X11 forwarding for root before running `timeshift-gtk`:

```bash
$ xauth list $DISPLAY
host/unix:10  MIT-MAGIC-COOKIE-1  742d024faeb3d29a15ff06f1b8c3b21e
$ echo $DISPLAY
localhost:10.0
$ sudo -s
# xauth add host/unix:10  MIT-MAGIC-COOKIE-1  742d024faeb3d29a15ff06f1b8c3b21e
# export DISPLAY=localhost:10.0
# timeshift-gtk
```

## Booting different EFI entries

Every machine has a ~Playback~ and a ~Development~ (~Entwicklung~) installation.
They are on separate drives.
On PS-1 you can repeatedly press F12 on startup to get to the EFI boot menu.

```
efibootmgr -v
efibootmgr -c -d /dev/sda -p 1 -L 'SATA Entwicklung' -l '\EFI\ubuntu\shimx64.efi'
efibootmgr -c -d /dev/nvme0n1 -p 1 -L 'NVME Playback' -l '\EFI\ubuntu\shimx64.efi'
efibootmgr -n 0001
efibootmgr -o 0002,0004,0008,0009,000A,000B
```
