" See :help new-filetype-scripts for details.
if did_filetype()
    finish
endif

if getline(1) =~ '^#!.*\<pyro\>'
    setfiletype pyro
elseif getline(1) =~? '\<foobar\>'
    setfiletype foobar
endif
