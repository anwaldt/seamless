install_data('*.py', install_dir: get_option('datadir') / 'seamless' / 'OscRouter')
meson.add_install_script(
    'sh', '-c',
    'ln -fs OscRouter @0@@1@'.format(
        get_option('prefix') / get_option('bindir'),
        get_option('prefix') / get_option('datadir') / 'seamless' / 'OscRouter' / 'MAIN_oscrouter.py'))
