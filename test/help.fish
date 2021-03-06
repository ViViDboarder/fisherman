set -l path $DIRNAME/.$TESTNAME.test
set -l sections 1 5 7

function -S setup
    set -gx MANPATH $path/man

    for i in $sections
        if not mkdir -p $MANPATH/man$i
            return
        end

        printf "%s\n" foo > $MANPATH/man$i/fisher-foo.$i
    end
end

function -S teardown
    rm -rf $path
end

test "$TESTNAME - Show both available guides and command with `help --all`"
    ! -z (fisher help --all | grep -E 'Available Commands:$|Other Documentation:$' | xargs)
end

test "$TESTNAME - Show available guides/tutorials with `--guides`"
    ! -z (fisher help --guides | grep -E 'Other Documentation:$' | xargs)
end

test "$TESTNAME - Show usage help with `--usage=command`"
    (fisher help --usage=help) = (fisher help -h)
end

for i in $sections
    test "$TESTNAME - Read fisher-<name> man pages"
        (fisher help foo | xargs) = foo
    end
end

test "$TESTNAME - Display usage help for every command"
    (cat $DIRNAME/fixtures/help/usage.txt) = (fisher help --commands=bare | fisher help --usage)
end
