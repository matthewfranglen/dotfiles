set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

HUB_FOLDER="${HOME}/.hub"

install () {
    git clone https://github.com/github/hub.git "${HUB_FOLDER}"
    (
        cd "${HUB_FOLDER}"
        ./script/build
    )

    (
        cd "${HOME}/.local/bin"
        ln -s "${HUB_FOLDER}/bin/hub"
    )

    return ${STATUS_OK}
}

install
