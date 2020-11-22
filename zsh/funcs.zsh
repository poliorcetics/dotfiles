function nk {
    res=`sk -q "$1"`
    if [ -e "$res" ]; then
        nvim "$res"
    fi
}
