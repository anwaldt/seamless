config_dir = '/etc/seamless'

if not fs.exists('/etc/seamless/jack.conf')
	install_data('jack.conf', install_dir: config_dir)
else
	message('/etc/seamless/jack.conf already exists.')
endif

if get_option('location') == 'EN325'
	install_subdir('EN325', strip_directory: true, install_dir: config_dir)
elif get_option('location') == 'HUFO'
	install_subdir('HUFO', strip_directory: true, install_dir: config_dir)
endif

summary({'Location': get_option('location'), 'Directory': config_dir})
