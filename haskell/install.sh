set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"
HASKELL_FOLDER="${DOTFILES_FOLDER}/haskell"
GHCI_FILE="${HASKELL_FOLDER}/ghci.symlink"

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
    chmod go-w "${HASKELL_FOLDER}"
}

install
