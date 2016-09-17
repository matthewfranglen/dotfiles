set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

readonly HASKELL_FOLDER="${DOTFILES_FOLDER}/haskell"
readonly GHCI_FILE="${HASKELL_FOLDER}/ghci.symlink"

install () {
    if [ ! -e "${GHCI_FILE}" ]
    then
        echo "Unable to fix haskell... You must run the bootstrap command first" >&2
        return ${STATUS_ERROR}
    fi

    change_ghci_rc_permissions || return ${STATUS_ERROR}

    return ${STATUS_OK}
}

change_ghci_rc_permissions () {
    chmod 600 "${GHCI_FILE}" && chmod go-w "${HASKELL_FOLDER}"
}

install
