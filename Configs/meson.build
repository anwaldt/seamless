install_data('jack.conf', install_dir: '/etc/seamless')

if get_option('location') == EN325
	install_subdir('EN325', strip_directory: true, install_dir: '/etc/seamless')
else if get_option('location') == HUFO
	install_subdir('HUFO', strip_directory: true, install_dir: '/etc/seamless')
endif
