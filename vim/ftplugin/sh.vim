augroup Syntax
    autocmd!
    autocmd BufEnter *.sh call TextEnableCodeSnip('python', '#PY', '#/PY', 'SpecialComment' )
augroup END

