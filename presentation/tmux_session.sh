function tmux_session() {
    if [ -z "$TMUX" ]; then
        echo "This command must run in a tmux session"
        return 1
    fi
    a=${TMUX##*/}
    echo "\$${a##*,}"
}