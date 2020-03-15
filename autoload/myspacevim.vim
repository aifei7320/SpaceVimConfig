func! myspacevim#before() abort
  let g:ale_linters_explicit = 1
  let g:ale_completion_enabled = 0 "已经有ycm来作为补全了
  let g:ale_completion_delay = 100
  let g:ale_echo_delay = 20
  let g:ale_lint_delay = 500
  let g:ale_echo_msg_format = '[%linter%] %code: %%s'
  let g:ale_lint_on_text_changed = 'normal'
  let g:ale_lint_on_insert_leave = 0
  let g:ale_lint_on_save = 1
  let g:airline#extensions#ale#enabled = 1
  let g:ale_set_loclist = 0
  let g:ale_set_quickfix = 1
  let g:ale_open_list = 0 
  let g:ale_keep_list_window_open = 0
  let g:ale_fix_on_save = 1

  let g:ale_c_gcc_options = '-Wall -O3 -std=c++11'
  let g:ale_cpp_gcc_options = '-Wall -O3 -std=c++11'
  let g:ale_c_cppcheck_options = ''
  let g:ale_cpp_cppcheck_options = ''
  let g:ale_c_clangformat_options = '--style=Google'


  let g:ale_linters = {
        \   'c++': ['clangd'],
        \   'cpp': ['clangd'],
        \   'c': ['clangd'],
        \   'cmake': ['cmakelint'],
        \   'json': ['jsonlint'],
        \   'cuda': ['nvcc'],
        \   'python': ['flake8'],
        \}

  let g:ale_fixers = {
        \   '*': ['remove_trailing_lines', 'trim_whitespace'],
        \   'c++': ['clangtidy', 'clang-format'],
        \   'cpp': ['clangtidy', 'clang-format'],
        \   'c': ['clangtidy', 'clang-format'],
        \   'python': ['yapf', 'black', 'isort', 'reorder-python-imports', 'autopep8'],
        \}

  let g:mapleader = ';'
  let $GTAGSLABEL = 'native-pygments'
  let $GTAGSCONF = '/home/hero/.globalrc'
  let g:gutentags_define_advanced_commands = 1
  " gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
  let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

  " 所生成的数据文件的名称
  let g:gutentags_ctags_tagfile = '.tags'

  " 同时开启 ctags 和 gtags 支持：
  let g:gutentags_modules = []
  if executable('ctags')
    let g:gutentags_modules += ['ctags']
  endif
  if executable('gtags-cscope') && executable('gtags')
    let g:gutentags_modules += ['gtags_cscope']
  endif

  " 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
  let g:gutentags_cache_dir = expand('~/.cache/tags')


  " 配置 ctags 的参数
  let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extras=+q']
  let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
  let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

  " 如果使用 universal ctags 需要增加下面一行
  let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

  " 禁用 gutentags 自动加载 gtags 数据库的行为
  let g:gutentags_auto_add_gtags_cscope = 0 

  " change focus to quickfix window after search (optional).
  let g:gutentags_plus_switch = 1

  " 自动打开 quickfix window ，高度为 6
  let g:asyncrun_open = 6

  " 任务结束时候响铃提醒
  let g:asyncrun_bell = 1

  "python高亮
  let python_highlight_all=1

  nnoremap <F6> :call myspacevim#runmake()<cr>
endfunction

func  myspacevim#runmake() abort

  " 设置 F10 打开/关闭 Quickfix 窗口
  call asyncrun#quickfix_toggle(6)
endfunc

" denite option
func! myspacevim#after() abort
  " Define mappings


  let g:ycm_add_preview_to_completeopt = 0
  let g:ycm_show_diagnostics_ui = 0 
  let g:ycm_server_log_level = 'info'
  let g:ycm_min_num_identifier_candidate_chars = 2
  let g:ycm_collect_identifiers_from_comments_and_strings = 1
  let g:ycm_complete_in_strings=1
  let g:ycm_key_invoke_completion = '<c-x>'
  let g:ycm_python_binary_path = '/usr/bin/python3'
  let g:ycm_server_python_interpreter = "/usr/bin/python3"
  let g:ycm_auto_trigger = 1
  set completeopt=menu,menuone

  let g:ycm_semantic_triggers =  {
        \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
        \ 'cs,lua,javascript': ['re!\w{2}'],
        \ }

  function! s:CustomizeYcmQuickFixWindow()
  " Move the window to the top of the screen.
  wincmd K
  " Set the window height to 5.
  5wincmd _
endfunction

autocmd User YcmQuickFixOpened call s:CustomizeYcmQuickFixWindow()

function! s:CustomizeYcmLocationWindow()
  " Move the window to the top of the screen.
  wincmd K
  " Set the window height to 5.
  5wincmd _
  " Switch back to working window.
  wincmd p
endfunction

autocmd User YcmLocationOpened call s:CustomizeYcmLocationWindow()

endfunction
