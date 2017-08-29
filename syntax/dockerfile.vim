" Vim syntax file for Dockerfile
" Maintainer:	motemen <https://motemen.github.io/>
" Last Change:	Tue Aug 29 09:46:47 JST 2017

if exists('b:current_syntax')
    finish
endif

syntax case ignore

setlocal iskeyword+=-
setlocal iskeyword+=/

syntax include @sh syntax/sh.vim

syntax match   dockerfileLineStart   /^\s*/ nextgroup=dockerfileInstruction
syntax keyword dockerfileInstruction FROM MAINTAINER CMD ENV ADD COPY ENTRYPOINT VOLUME USER WORKDIR contained
syntax keyword dockerfileInstruction RUN contained nextgroup=dockerfileRunCommand skipwhite
syntax keyword dockerfileInstruction EXPOSE contained nextgroup=dockerfilePorts skipwhite

syntax region  dockerfileRunCommand  start=// skip=/\\\n/ end=/$/ contained contains=@sh extend
syntax match   dockerfilePorts       /\(\s\|\d\)\+/ contains=dockerfileNumber

syntax match   dockerfileComment     /^\s*#.*$/
syntax match   dockerfileNumber      /\d\+/ contained

" acutually a JSON string in an array
syntax region dockerfileString start=+"+ end=+"+ skip=+\\"+

highlight link dockerfileInstruction Function
highlight link dockerfileComment     Comment
highlight link dockerfileString      String
highlight link dockerfileNumber      Constant

let b:current_syntax = 'dockerfile'
