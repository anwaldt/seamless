showcontrol_files = ['showcontrol.py',
		     'schedcontrol.py',
		     'webcontrol/auth.py',
		     'webcontrol/db.py',
		     'webcontrol/__init__.py',
		     'webcontrol/showcontrol.py',
		     'webcontrol/schema.sql',
		     'webcontrol/static/style.css',
		     'webcontrol/templates/auth/change_password.html',
		     'webcontrol/templates/auth/login.html',
		     'webcontrol/templates/auth/register.html',
		     'webcontrol/templates/auth/users.html',
		     'webcontrol/templates/showcontrol/pause.html',
		     'webcontrol/templates/base.html']

install_data(showcontrol_files, install_mode: 'rwxr-xr-x', install_dir: get_option('datadir') / 'seamless' / 'ShowControl')

meson.add_install_script(
    'sh', '-c',
    'ln -s -f @0@ @1@'.format(
        get_option('prefix') / get_option('datadir') / 'seamless' / 'ShowControl' / 'showcontrol.py',
        get_option('prefix') / get_option('bindir') / 'showcontrol'))
