if exists('g:fvim_loaded')
    FVimCursorSmoothMove v:true
    FVimCursorSmoothBlink v:true
		FVimCustomTitleBar v:true

		if g:fvim_os == 'windows' || g:fvim_render_scale > 1.0
			set guifont=Consolas:h14
		else
			set guifont=Consolas:h28
		endif
endif
