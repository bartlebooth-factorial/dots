#!/bin/sh

binprint() {
    printf "\033[38;5;197;1m%s\033[0m\n\n" '- - Binary file' && \
    printf "\033[38;5;197;1m" && \
    figlet -f 'starwars' 'cat -v' && \
    printf "\033[0m" && cat -v "$1"
}

case "$1" in
  *.tar*)
    # bold lime
    printf "\033[38;5;112;1m%s\033[0m\n\n" '- - - Tar contents'
    tar tf  "$1"
    ;;
  *.zip)
    # bold lime
    printf "\033[38;5;112;1m%s\033[0m\n\n" '- - - Zip contents'
    unzip -l "$1"
    ;;
  *.pdf)
    # bold purple
    printf "\033[38;5;93;1m%s\033[0m\n\n" '- - - pdf to text'
    pdftotext "$1" -
    ;;
  *.mp3)
    # bold blue
    printf "\033[38;5;33;1m%s\033[0m\n\n" '- - - Audio info'
    mediainfo "$1"
    ;;
  *.flac)
    # bold blue
    printf "\033[38;5;33;1m%s\033[0m\n\n" '- - - Audio info'
    mediainfo "$1"
    ;;
  *.wav)
    # bold blue
    printf "\033[38;5;33;1m%s\033[0m\n\n" '- - - Audio info'
    mediainfo "$1"
    ;;
  *.png)
    # bold yellow
    printf "\033[38;5;184;1m%s\033[0m\n\n" '- - - Image info'
    file "$1" | tr ',' "\n" | sed '1s/.*: //' | sed '2,$s/^/-/'
    ;;
  *.jpg)
    # bold yellow
    printf "\033[38;5;184;1m%s\033[0m\n\n" '- - - Image info'
    file "$1" | tr ',' "\n" | sed '1s/.*: //' | sed '2,$s/^/-/'
    ;;
  *.asc)
    # bold orange
    printf "\033[38;5;208;1m%s\033[0m\n\n" '- - - Encrypted file'
    cat "$1"
    ;;
  *)
    # bold red for binaries
    isutf8 -q "$1" && bat -fpP "$1" || binprint "$1"
    ;;
esac
