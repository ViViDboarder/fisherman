function __fisher_key_bindings_enable -a plugin user_key_bindings
    __fisher_key_bindings_update $plugin >> $fisher_key_bindings

    if test ! -s $user_key_bindings
        command mkdir -p (dirname $user_key_bindings)

        printf "%s\n" \
            "function fish_user_key_bindings" \
            "   __fisher_key_bindings" \
            "end" > $user_key_bindings

        source $user_key_bindings
    end

    functions fish_user_key_bindings \
        | __fisher_key_bindings_update_user > $user_key_bindings
end
