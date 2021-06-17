py_files = ['conversionsTools.py',
	'MAIN_oscrouter.py',
	'osccomcenter.py',
	'rendererclass.py',
	'soundobjectclass.py',
	'str_keys_conventions.py']

install_data(py_files, install_dir: get_option('datadir') / 'seamless' / 'OscRouter')

meson.add_install_script(
    'sh', '-c',
    'ln -s @0@ @1@'.format(
        get_option('prefix') / get_option('datadir') / 'seamless' / 'OscRouter' / 'MAIN_oscrouter.py',
        get_option('prefix') / get_option('bindir') / 'OscRouter'))
