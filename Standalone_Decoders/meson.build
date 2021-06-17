if get_option('location') == 'EN325'
	install_data('EN325_DOME1', rename: 'ambdec_rev',  install_dir: get_option('bindir'), install_mode: 'rwxr-xr-x')
	install_data('EN325_DOME3', rename: 'ambdec_3rd',  install_dir: get_option('bindir'), install_mode: 'rwxr-xr-x')
elif get_option('location') == 'HUFO'
	install_data('HUFO_HOA1', rename: 'ambdec_rev', install_dir: get_option('bindir'), install_mode: 'rwxr-xr-x')
	install_data('HUFO_HOA3', rename: 'ambdec_3rd', install_dir: get_option('bindir'), install_mode: 'rwxr-xr-x')
endif
