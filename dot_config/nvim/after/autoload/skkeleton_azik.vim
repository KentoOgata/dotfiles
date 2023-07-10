" ORIGINAL:
"   SOURCE: https://github.com/shg-eo/skkeleton-azik/blob/master/plugin/skkeleton-azik.vim
"   LICENSE: https://github.com/shg-eo/skkeleton-azik/blob/master/LICENSE.md

" Summary:
"   `azik`という名前の仮名テーブルを作成し、いくつかのキーバインドを定義する。
" Remarks:
"   skkeleton#configに相当する処理は実行しないが、
"   'skkeleton-config-kanaTable'に"azik"を
"   設定したい場合はskkeleton#configよりも先に実行する必要がある。
function! skkeleton_azik#setup(config = {}) abort
  const azik_kanatable =
        \ [expand('<script>')->fnamemodify(':h'), 'azik-kanaTable.json']->join('/')
        \ ->readfile()->join()->json_decode()

  call skkeleton#register_kanatable('azik', azik_kanatable, v:true)

  const config = a:config->deepcopy()->extend(skkeleton_azik#get_default_config(), 'keep')

  " input stateのマッピングはregister_keymapではなくてregister_kanatableでやるのがよさそう
  " kanatable毎にマッピングを定義できたり、lexima的なことも少しはできる
  " 例: "xl" -> "しょん", "l" -> "disable" を両立させる
  call skkeleton#register_kanatable('azik', {
        \ 'l':        'disable',
        \ "\<SPACE>": 'henkanFirst',
        \ config.keys.katakana: 'katakana',
        \})

  call skkeleton#register_kanatable('azik', { ':': 'henkanPoint' })
  augroup _skkeleton_azik_
    autocmd!
    autocmd User skkeleton-enable-post inoremap <buffer> : <Cmd>call skkeleton#handle('handleKey', { 'key': ':' })<CR><Cmd>call skkeleton#handle('handleKey', { 'key': ';' })<CR>
  augroup END
endfunction

function! skkeleton_azik#get_default_config() abort
  return {
        \  'keys': {
        \    'katakana': '[',
        \  },
        \}
endfunction
