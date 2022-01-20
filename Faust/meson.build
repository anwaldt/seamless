if get_option('reverb')
	#faust2jackconsole = find_program('faust2jackconsole', required: true)
	faust2sc = find_program('faust2supercollider', required: true)

	#run_command(faust2jackconsole, 'reverb/FoaReverb.dsp', check: true)
	run_command(faust2sc, '-ks', '-sn', '-noprefix', 'reverb/FoaReverb.dsp', check: true)

	reverb_files = ['reverb/FoaReverb.sc',
			'reverb/FoaReverb.so',
			'reverb/FoaReverb_supernova.so',
			'reverb/FoaReverb.schelp'
			]
	install_data(reverb_files, install_dir: get_option('datadir') / 'SuperCollider' / 'Extensions' / 'Faust')
endif
