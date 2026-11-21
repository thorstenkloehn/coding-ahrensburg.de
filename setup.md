# Setup: Zola und mdBook installieren

Alles auf einmal installieren und den Status unten aktualisieren:

```bash
./install.sh
```

## Voraussetzungen

- Rust-Toolchain (`cargo`), z. B. über [rustup](https://rustup.rs):

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
```

- `~/.cargo/bin` muss im `PATH` liegen:

```bash
export PATH="$HOME/.cargo/bin:$PATH"
```

## mdBook

```bash
cargo install mdbook
mdbook --version
```

```bash
mdbook init mein-buch   # neues Buch anlegen
mdbook serve --open     # lokaler Server mit Live-Reload
mdbook build            # statische Seite nach book/ bauen
```

## Zola

Über Cargo (kompiliert aus dem Quellcode, dauert einige Minuten):

```bash
cargo install --locked --git https://github.com/getzola/zola
zola --version
```

Alternativen: `sudo snap install zola --edge` oder ein fertiges Binary von den
[GitHub-Releases](https://github.com/getzola/zola/releases).

```bash
zola serve   # lokaler Server mit Live-Reload (http://127.0.0.1:1111)
zola build   # statische Seite nach public/ bauen
```

## Startseite (Zola + Bootstrap)

Dieses Verzeichnis ist eine Zola-Seite:

- `zola.toml`: Konfiguration (vor dem Livegang `base_url` auf die echte Domain setzen)
- `content/_index.md`: Inhalt der Startseite
- `templates/base.html`, `templates/index.html`: Templates
- `static/bootstrap/`: Bootstrap 5.3.9 (CSS und JS-Bundle), lokal eingebunden

## Aktueller Stand auf diesem Rechner

| Tool   | Status |
|--------|--------|
| mdBook | installiert (v0.4.52) |
| Zola   | installiert (v0.23.6) |
