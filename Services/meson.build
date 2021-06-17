install_subdir('system', install_dir: '/usr/lib/systemd/')
if get_option('location') == 'HUFO'
	conf_data = configuration_data()
	conf_data.set('share_dir', get_option('prefix') / get_option('datadir') / 'seamless')
	configure_file(input : 'sc_mix@.service.in',
		       output : 'sc_mix@.service',
		       configuration : conf_data,
		       install_dir : '/usr/lib/systemd/system')

	conf_data = configuration_data()
	conf_data.set('share_dir', get_option('prefix') / get_option('datadir') / 'seamless')
	configure_file(input : 'sc_wfs@.service.in',
		       output : 'sc_wfs@.service',
		       configuration : conf_data,
		       install_dir : '/usr/lib/systemd/system')
endif
