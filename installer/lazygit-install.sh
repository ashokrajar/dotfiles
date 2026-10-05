#!/usr/bin/env bash

# Install lazygit (latest release) into ~/bin
if [[ -x "${HOME}/bin/lazygit" ]]; then
    echo -en "lazygit is already installed.\n"
    exit 0
fi

for cmd in curl tar; do
    if ! command -v "${cmd}" >/dev/null 2>&1; then
        echo -en "lazygit install needs ${cmd}, which was not found.\n" >&2
        exit 1
    fi
done

case "$(uname -m)" in
x86_64) LAZYGIT_ARCH="x86_64" ;;
aarch64 | arm64) LAZYGIT_ARCH="arm64" ;;
armv6l | armv7l) LAZYGIT_ARCH="armv6" ;;
*)
    echo -en "lazygit: unsupported architecture $(uname -m).\n" >&2
    exit 1
    ;;
esac

LAZYGIT_VERSION="$(curl -fsSL https://api.github.com/repos/jesseduffield/lazygit/releases/latest |
    sed -n 's/.*"tag_name": *"v\([^"]*\)".*/\1/p')"
if [[ -z "${LAZYGIT_VERSION}" ]]; then
    echo -en "lazygit: could not determine the latest release version.\n" >&2
    exit 1
fi

echo -en "Installing lazygit ${LAZYGIT_VERSION} .....\n"
LAZYGIT_TMP="$(mktemp -d)"
trap 'rm -rf "${LAZYGIT_TMP}"' EXIT
curl -fsSL -o "${LAZYGIT_TMP}/lazygit.tar.gz" \
    "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_linux_${LAZYGIT_ARCH}.tar.gz"
tar -zxf "${LAZYGIT_TMP}/lazygit.tar.gz" -C "${LAZYGIT_TMP}" lazygit
mkdir -p "${HOME}/bin"
install -m 0755 "${LAZYGIT_TMP}/lazygit" "${HOME}/bin/lazygit"
