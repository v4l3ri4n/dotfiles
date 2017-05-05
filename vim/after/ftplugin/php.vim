" Syntastic ______________________________________

let g:syntastic_php_checkers = ["php", "phpcs", "phpmd"]

" If php is not present on system, fallback to docker

let phptools = "php56-tools"
let docker_image = system("docker images -q " . phptools)
let g:syntastic_php_phpcs_args = "--standard=PSR2" " default standard for phpcs

if (executable("php")<1 && strlen(docker_image)>0)
    let g:syntastic_php_php_exec = "~/dotfiles/bin/" . phptools
    let g:syntastic_php_php_args = "php"
    let g:syntastic_php_phpcs_exec = "~/dotfiles/bin/" . phptools
    let g:syntastic_php_phpcs_args = "phpcs --standard=PSR2"
    let g:syntastic_php_phpmd_exec = "~/dotfiles/bin/" . phptools
    let g:syntastic_php_phpmd_args = "phpmd"
endif

" PHP-Indenting-for-VIm __________________________

:let g:PHP_removeCRwhenUnix = 1             "automatically remove '\r' characters when the 'fileformat' is set to Unix
:let g:PHP_vintage_case_default_indent = 1  " indent 'case:' and 'default:' statements in switch() blocks

" neocomplete ____________________________________

let g:neocomplete#sources#omni#input_patterns.php = '\h\w*\|[^.\t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

