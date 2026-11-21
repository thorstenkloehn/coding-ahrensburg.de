#!/usr/bin/env bash
# Installiert Rust (falls nötig), mdBook und Zola und aktualisiert
# danach den Abschnitt "Aktueller Stand" in setup.md.
set -euo pipefail

cd "$(dirname "$0")"
SETUP_MD="setup.md"

export PATH="$HOME/.cargo/bin:$PATH"

# 1. Rust-Toolchain
if ! command -v cargo >/dev/null 2>&1; then
    echo ">> Installiere Rust (rustup) ..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    # shellcheck disable=SC1091
    source "$HOME/.cargo/env"
fi

# 2. mdBook
MDBOOK_VIA="bereits vorhanden"
if ! command -v mdbook >/dev/null 2>&1; then
    echo ">> Installiere mdBook ..."
    cargo install mdbook
    MDBOOK_VIA="über Cargo"
fi

# 3. Zola
ZOLA_VIA="bereits vorhanden"
if ! command -v zola >/dev/null 2>&1; then
    echo ">> Installiere Zola (kompiliert, dauert einige Minuten) ..."
    cargo install --locked --git https://github.com/getzola/zola
    ZOLA_VIA="über Cargo"
fi

# 4. Status ermitteln
status() { # $1 = Befehl, $2 = Installationsweg
    if command -v "$1" >/dev/null 2>&1; then
        local v
        v="$("$1" --version | awk '{print $NF}')"
        v="${v#v}"
        if [ "$2" = "bereits vorhanden" ]; then
            echo "installiert (v$v)"
        else
            echo "installiert (v$v, $2)"
        fi
    else
        echo "nicht installiert"
    fi
}

MDBOOK_STATUS="$(status mdbook "$MDBOOK_VIA")"
ZOLA_STATUS="$(status zola "$ZOLA_VIA")"

# 5. setup.md umschreiben: alles ab "## Aktueller Stand" ersetzen
tmp="$(mktemp)"
awk '/^## Aktueller Stand/ {exit} {print}' "$SETUP_MD" > "$tmp"
cat >> "$tmp" <<EOF
## Aktueller Stand auf diesem Rechner

| Tool   | Status |
|--------|--------|
| mdBook | $MDBOOK_STATUS |
| Zola   | $ZOLA_STATUS |
EOF
mv "$tmp" "$SETUP_MD"

echo ">> Fertig. $SETUP_MD aktualisiert:"
echo "   mdBook: $MDBOOK_STATUS"
echo "   Zola:   $ZOLA_STATUS"
