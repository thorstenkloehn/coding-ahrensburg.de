# coding-thorsten.de

Persönliche Wissensseite rund um Programmieren und Webentwicklung. Hier lernen wir, mit Claude Code zu programmieren und den entstehenden Code zu verstehen.

Die Seite ist eine statische [Zola](https://www.getzola.org)-Seite mit [Bootstrap](https://getbootstrap.com) 5.3.9 (lokal eingebunden). Zum Schreiben und Prüfen der Texte gibt es mehrere Claude-Code-Skills.

## Inhalt dieses Repositories

| Pfad | Zweck |
|------|-------|
| `zola.toml` | Konfiguration (Titel, `base_url`, Menü, Code-Highlighting) |
| `content/` | Inhalte als Markdown (`_index.md` ist die Startseite) |
| `templates/` | Zola-Templates (`base.html`, `index.html`, `page.html`) |
| `static/` | Statische Dateien (Bootstrap, `robots.txt`) |
| `sass/` | Sass-Dateien (werden bei `compile_sass = true` kompiliert) |
| `public/` | Gebaute Seite (wird erzeugt, nicht eingecheckt) |
| `install.sh` | Installiert Rust, mdBook und Zola |
| `setup.md` | Ausführlichere Installationsnotizen |
| `.claude/skills/` | Claude-Code-Skills für Texte |

## Installation

### Voraussetzungen

- Linux oder macOS mit Terminal, `curl` und `git`
- Internetverbindung

### Schnell: alles mit einem Skript

```bash
git clone https://github.com/thorstenkloehn/coding-thorstende.git
cd coding-thorstende
./install.sh
```

Das Skript macht der Reihe nach:

1. Installiert Rust über `rustup`, falls `cargo` fehlt.
2. Installiert mdBook mit `cargo install mdbook`, falls es fehlt.
3. Installiert Zola mit `cargo install --locked --git https://github.com/getzola/zola`, falls es fehlt. Das kompiliert aus dem Quellcode und dauert einige Minuten.
4. Schreibt den Abschnitt „Aktueller Stand“ in `setup.md` neu.

Vorhandene Programme werden nicht erneut installiert. Danach muss `~/.cargo/bin` im `PATH` liegen:

```bash
export PATH="$HOME/.cargo/bin:$PATH"
zola --version
```

### Manuell nur Zola

Wer nur die Seite bauen will, braucht nur Zola. Alternativen zu Cargo:

- `sudo snap install zola --edge`
- ein fertiges Binary von den [GitHub-Releases](https://github.com/getzola/zola/releases)

Mehr dazu steht in [`setup.md`](setup.md). Zuletzt getestet mit Zola 0.23.6.

## Seite lokal ansehen und bauen

```bash
zola serve   # lokaler Server mit Live-Reload: http://127.0.0.1:1111
zola build   # baut die statische Seite nach public/
zola check   # prüft Konfiguration und interne Links
```

Vor dem Livegang muss `base_url` in `zola.toml` auf die echte Domain zeigen (aktuell `https://coding-thorsten.de`).

## Neue Seite anlegen

Lege unter `content/` eine Markdown-Datei mit Front Matter an, zum Beispiel `content/meine-seite.md`:

```markdown
+++
title = "Titel der Seite"
description = "Kurze Beschreibung für Suchmaschinen (ca. 70 bis 160 Zeichen)."
path = "meine-seite"
+++

Text der Seite.
```

Für das Menü trägst du die Seite in `zola.toml` unter `[extra]` bei `menu` ein.

## Claude-Code-Skills

Die Skills liegen in `.claude/skills/<name>/SKILL.md` und sind nur in diesem Projekt aktiv.

### Voraussetzung und Aufruf

1. [Claude Code](https://claude.com/claude-code) installieren und anmelden.
2. Im Projektordner starten:

   ```bash
   cd coding-thorstende
   claude
   ```

3. Einen Skill aufrufen mit `/skillname`, zum Beispiel `/text-pruefen content/impressum.md`. Oft reicht auch ein passender Satz („Prüfe diesen Satz“, „Was fehlt im Artikel?“), dann wählt Claude den Skill selbst.

### Übersicht

| Skill | Wofür | Ändert Dateien? |
|-------|-------|-----------------|
| `satz-pruefen` | Rechtschreibung, Grammatik und Zeichensetzung **nur für markierte Zeilen** | Nur nach Rückfrage |
| `text-pruefen` | Ganze Texte oder Dateien: Rechtschreibung, Grammatik, Zeichensetzung, mögliche Urheberrechtsverletzungen, Duplicate Content und Google-SEO | Nur nach Rückfrage |
| `vorschlag-artikel` | Bauplan für einen **neuen** Artikel: Titel, Beschreibung, Überschriften, was in jedem Abschnitt steht | Nein |
| `schreibvorschlaege` | Tipps, wie du an einem Text **weiterschreibst** (Inhalt, Gliederung, Stil, Suchintention), ohne eigene Formulierungen | Nein |
| `artikel-luecken` | Was dem Artikel **fehlt** und was genau dazu geschrieben werden soll (Stelle, Inhalt, Umfang) | Nein |
| `inhalt-verbessern` | Verbesserungen für **vorhandenen** Text, jeweils mit Textvorschlag (vorher und nachher) | Nur nach ausdrücklicher Zustimmung |

### Die Skills im Einzelnen

**`satz-pruefen`**
Prüft ausschließlich den markierten Satz oder Zeilenbereich auf Rechtschreibung, Grammatik und Zeichensetzung. Kein Urheberrecht, kein SEO, keine Stilkritik. Ausgabe: pro Fehler eine Zeile `alt → neu (Grund)` und danach der korrigierte Text. Ist alles richtig, steht dort „Keine Fehler gefunden.“

Beispiel: `Prüfe Zeile 12 bis 14 in content/impressum.md`

**`text-pruefen`**
Der umfassende Check für eine Datei. Er korrigiert nur eindeutige Fehler, ohne Inhalt dazuzudichten oder Stil umzuschreiben. Front Matter, Links, Code und Pflichtangaben bleiben unverändert. Zusätzlich prüft er auf wörtliche Übernahmen, enge Paraphrasen, Übersetzungen und doppelte Inhalte sowie auf Title, Meta-Description, Überschriften, URLs, Links, Bilder und technische SEO-Punkte. Ergebnisse werden je Punkt mit `OK`, `Verbessern` oder `Fehlt` angegeben. Das ist keine Rechtsberatung, und ein Ranking kann niemand garantieren.

Beispiel: `/text-pruefen content/datenschutz.md`

**`vorschlag-artikel`**
Du nennst ein Thema, der Skill liefert den Plan: Ausrichtung (Zielgruppe, Suchintention), Titel- und Description-Vorschläge, Gliederung mit Stichpunkten je Abschnitt, wichtige Begriffe, Links, nötige Recherche und passender Schreibstil. Er schreibt keinen Fließtext.

Beispiel: `/vorschlag-artikel Zola-Templates verstehen`

**`schreibvorschlaege`**
Für einen Text, den du gerade schreibst. Liefert 5 bis 8 Vorschläge nach Wirkung sortiert und optional eine Liste möglicher nächster Überschriften. Keine fertigen Absätze.

Beispiel: `Wie schreibe ich in content/meine-seite.md weiter?`

**`artikel-luecken`**
Findet offene Leserfragen, fehlende Bausteine (Definition, Beispiel, Schritte, Fazit, Quellen), nicht eingelöste Versprechen aus Titel und Beschreibung und dünne Stellen. Zu jeder Lücke: was fehlt, wo es hinkommt, was genau zu schreiben ist, grober Umfang und was du vorher recherchieren musst.

Beispiel: `Was fehlt in content/meine-seite.md noch?`

**`inhalt-verbessern`**
Zeigt zu jedem Vorschlag das Problem, die Stelle vorher, einen verbesserten Text und eine kurze Begründung. Er erfindet keine Fakten, sondern setzt Platzhalter wie `[hier Beleg ergänzen]`. Übernommen wird nur, was du ausdrücklich bestätigst.

Beispiel: `Verbessere den Inhalt von content/meine-seite.md und zeig mir Textvorschläge`

### Welcher Skill wann?

```
Neuer Artikel geplant        → vorschlag-artikel
Text halb geschrieben        → schreibvorschlaege
Text fertig, was fehlt?      → artikel-luecken
Formulierungen verbessern    → inhalt-verbessern
Einzelnen Satz korrigieren   → satz-pruefen
Vor der Veröffentlichung     → text-pruefen
```

### Eigene Skills hinzufügen

Lege `.claude/skills/<name>/SKILL.md` an. Die Datei beginnt mit Front Matter aus `name` und `description` (Beschreibung, wann der Skill verwendet wird), danach folgen die Anweisungen. Als Vorlage eignet sich `.claude/skills/satz-pruefen/SKILL.md`.

## Rechtliches

Impressum und Datenschutzerklärung stehen unter `content/impressum.md` und `content/datenschutz.md`. Die selbst erstellten Inhalte stehen, sofern nicht anders angegeben, unter [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).
