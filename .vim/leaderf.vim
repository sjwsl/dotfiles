let g:Lf_GtagsAutoGenerate = 1
let g:Lf_UseCache = 0
let g:Lf_PythonVersion = 3
let g:Lf_Gtagslabel = 'native-pygments'
let g:Lf_RgConfig = [
      \ "--hidden", 
      \ "--max-columns=150",
      \ "--no-ignore"
				\ ]
let g:Lf_ExternalCommand = 'rg --files --no-ignore --hidden "%s"'
let g:Lf_PreviewInPopup = 1
let g:Lf_ShowHidden = 1 
