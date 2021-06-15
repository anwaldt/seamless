install_data('aj-snapshot@.service', install_dir: get_option('libdir') / 'systemd' / 'system' )
install_data('ambdec_3rd@.service', install_dir: get_option('libdir') / 'systemd' / 'system' )
install_data('ambdec_rev@.service', install_dir: get_option('libdir') / 'systemd' / 'system' )
install_data('oscrouter@.service', install_dir: get_option('libdir') / 'systemd' / 'system' )

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
install_data('seamless_jack@.service', install_dir: get_option('libdir') / 'systemd' / 'system' )
