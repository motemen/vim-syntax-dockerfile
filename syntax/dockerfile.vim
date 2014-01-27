" Vim syntax file for Dockerfile
" Maintainer:	motemen <http://motemen.github.io/>
" Last Change:	Mon Jan 27 23:56:25 JST 2014

if exists('b:current_syntax')
    finish
endif

syntax case ignore

setlocal iskeyword+=-

syntax include @sh syntax/sh.vim

syntax match   dockerfileLineStart   /^\s*/ nextgroup=dockerfileInstruction
syntax keyword dockerfileInstruction FROM MAINTAINER CMD ENV ADD ENTRYPOINT VOLUME USER WORKDIR contained
syntax keyword dockerfileInstruction RUN contained nextgroup=dockerfileRunCommand skipwhite
syntax keyword dockerfileInstruction EXPOSE contained nextgroup=dockerfilePorts skipwhite

syntax match   dockerfileRunCommand  /.*/ contained contains=@sh
syntax match   dockerfilePorts       /\(\s\|\d\)\+/ contains=dockerfileNumber

syntax match   dockerfileComment     /#.*/
syntax match   dockerfileNumber      /\d\+/ contained

" acutually a JSON string in an array
syntax region dockerfileString start=+"+ end=+"+ skip=+\\"+

highlight link dockerfileInstruction Function
highlight link dockerfileComment     Comment
highlight link dockerfileString      String
highlight link dockerfileNumber      Constant

let b:current_syntax = 'dockerfile'
