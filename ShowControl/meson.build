showcontrol_files = ['showcontrol.py']

install_data(showcontrol_files, install_mode: 'rwxr-xr-x', install_dir: get_option('datadir') / 'seamless' / 'ShowControl')

meson.add_install_script(
    'sh', '-c',
    'ln -s -f @0@ @1@'.format(
        get_option('prefix') / get_option('datadir') / 'seamless' / 'ShowControl' / 'showcontrol.py',
        get_option('prefix') / get_option('bindir') / 'showcontrol'))
