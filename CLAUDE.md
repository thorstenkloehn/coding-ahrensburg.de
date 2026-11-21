# Projekt: coding-thorsten.de

Statische Zola-Seite (Deutsch) mit Bootstrap. Ziel: Mit Claude Code programmieren lernen und den Code verstehen.

## Arbeitsweise

- Texte, Commit-Nachrichten und Antworten auf Deutsch.
- Nicht committen oder pushen, solange der Nutzer es nicht verlangt.
- Dateien erst nach Rückfrage ändern, wenn nur Vorschläge oder Prüfungen verlangt sind.
- Nichts erfinden: keine Fakten, Zahlen, Versionen oder Quellen ohne Beleg.
- Bei `zola serve` den Server danach wieder beenden.

## Struktur

- `content/`: Inhalte (Markdown mit Front Matter `title`, `description`, `path`)
- `templates/`, `static/`, `sass/`, `zola.toml`: Aufbau der Seite
- `public/`: erzeugt, nicht bearbeiten und nicht einchecken
- `.claude/skills/`: Skills, Beschreibungen kurz halten (etwa 200 bis 260 Zeichen)

Skills, Installation und Tokenverbrauch stehen in `README.md` und `setup.md`.
