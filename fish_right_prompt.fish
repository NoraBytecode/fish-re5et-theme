function fish_right_prompt -d "Write out the right prompt"
    set -l last_status $status

    if test $last_status -ne 0
        set_color --bold red
        echo -ns $last_status ' :( '
        set_color normal
    end

    set -l realhome ~
    set directory (echo $PWD | sed -e "s|^$realhome|~|")

    set line "$(whoami)@$(hostname| cut -d . -f 1):$directory"

    # tmux, screen title
    switch $TERM

        case xterm'*' vte'*'

            printf "\033]0;$line\007"

        case screen'*'

            printf "\033k$line\033\\"

    end

    echo -n (date "+%a %d.%m.%4Y %T")
end
