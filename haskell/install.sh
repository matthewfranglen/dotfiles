. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"
GHCI_FILE="${DOTFILES_FOLDER}/haskell/ghci.symlink"

install () {
    change_ghci_rc_permissions
}

change_ghci_rc_permissions () {
    if [ ! -e "${GHCI_FILE}" ]
    then
        echo "You must run the bootstrap command first" >&2
        exit 1
    fi

    chmod 600 "${GHCI_FILE}"
}

install
