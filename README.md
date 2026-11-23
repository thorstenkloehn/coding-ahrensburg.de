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

- `sudo snap install zola --edge` (liefert derzeit nur Zola 0.22.1 und ist damit älter als die getestete Version)
- ein fertiges Binary von den [GitHub-Releases](https://github.com/getzola/zola/releases)

Mehr dazu steht in [`setup.md`](setup.md). Zuletzt getestet mit Zola 0.23.6 (Stand: November 2026). `install.sh` installiert mdBook über Cargo in der neuesten Version, derzeit 0.5.x. Eine vorhandene Installation aktualisierst du mit `cargo install --locked mdbook`.

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
| `bild-alt-text` | Alt-Texte für Bilder prüfen und vorschlagen (Barrierefreiheit, Bildersuche) | Nur nach Rückfrage |
| `code-erklaeren` | Code für Einsteiger erklären (Zweck, Ablauf, Zeile für Zeile, typische Fehler) | Nein |
| `neue-seite` | Neue Seite unter `content/` mit Front Matter anlegen, auf Wunsch Menüeintrag | Legt Datei an, Menü nur auf Wunsch |
| `veroeffentlichen` | Prüfung vor dem Push: `zola check`, Testbuild, Front Matter, Menü, Technik | Nein, Commit und Push nur nach Rückfrage |
| `themen-vorschlaege` | Welche weiteren Artikel der **ganzen Seite** fehlen und in welcher Reihenfolge sie sinnvoll sind | Nein |
| `skill-vorschlaege` | Welche **Skills** dem Projekt noch fehlen | Nein |
| `uebungen-erstellen` | Übungen und Kontrollfragen mit Tipp und Lösung zu einem Artikel | Nur nach Zustimmung |
| `fehlermeldung-erklaeren` | Fehlermeldung (Zola, Cargo, Git, Claude Code) erklären, Ursache und Lösungsschritte | Nein |
| `artikel-aktualisieren` | Veraltetes (Versionen, Befehle, Links) in Artikeln, README und `setup.md` finden | Nur nach Rückfrage |
| `lesbarkeit-pruefen` | Verständlichkeit für Einsteiger prüfen (Sätze, Fachwörter, Aufbau), nur Hinweise | Nein |
| `querweise` | Hochwertige externe Links auf seriöse Quellen für einen Artikel vorschlagen, vorhandene Links prüfen | Nur nach Rückfrage |

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

**`bild-alt-text`**
Sucht Bilder in Markdown und Templates, liest den Kontext und bewertet jeden Alt-Text mit `OK`, `Verbessern` oder `Fehlt`. Die Vorschläge sind kurz (höchstens etwa 125 Zeichen), beginnen nicht mit „Bild von“ und beschreiben bei Screenshots die Kernaussage. Dekorative Bilder bekommen `alt=""`, Linkbilder beschreiben das Ziel. Er erfindet keine Details. Zusätzlich weist er auf Dateinamen, `width` und `height` sowie unklare Lizenzen hin.

Beispiel: `/bild-alt-text content/meine-seite.md`

**`code-erklaeren`**
Erklärt einen Code-Abschnitt in sechs Teilen: Worum es geht, Überblick, Block für Block mit dem „Warum“, Zusammenspiel, kleine Änderungen zum Ausprobieren und typische Fehler. Er erklärt nur, was der Code tatsächlich tut, kennzeichnet Unverifiziertes als Annahme und ändert den Code nicht ungefragt.

Beispiel: `/code-erklaeren templates/base.html`

**`neue-seite`**
Legt `content/<pfad>.md` mit `title`, `description` und `path` und einem Platzhaltertext an. Den `path` leitet er aus dem Titel ab (kleingeschrieben, Bindestriche, Umlaute umgeschrieben). Das Menü in `zola.toml` ergänzt er nur auf Wunsch. Danach prüft er mit `zola check`. Bestehende Dateien überschreibt er nicht, den Artikeltext schreibst du selbst.

Beispiel: `/neue-seite Zola-Templates verstehen`

**`veroeffentlichen`**
Die Prüfung vor dem Push: Stand mit `git status`, dann `zola check` und ein Testbuild in ein anderes Verzeichnis als `public/`. Er prüft das Front Matter geänderter Seiten, das Menü, `base_url`, `robots.txt` und `.gitignore` und weist auf Bilder ohne Alt-Text hin. Ergebnis: je Schritt `OK`, `Warnung` oder `Fehler` und ein Fazit „bereit“ oder „noch nicht“. Committen und Pushen nur nach deiner Zustimmung. Rechtschreibung und SEO der Texte prüft `text-pruefen`.

Beispiel: `/veroeffentlichen`

**`themen-vorschlaege`**
Liest alle Seiten unter `content/`, das Menü und das Ziel der Startseite und schlägt 5 bis 8 neue Themen vor, nach Priorität sortiert. Je Thema: Arbeitstitel, Suchintention, Begründung, Aufwand und Verknüpfung mit vorhandenen Seiten, dazu eine empfohlene Schreibreihenfolge. Er nennt keine erfundenen Suchvolumen und schreibt keine Artikel. Im Gegensatz zu `artikel-luecken` (ein Artikel) betrachtet er die ganze Seite.

Beispiel: `/themen-vorschlaege`

**`skill-vorschlaege`**
Liest die vorhandenen Skills, die README, die Konfiguration und die letzten Commits, geht den Ablauf von der Idee bis zur Pflege durch und nennt 3 bis 6 fehlende Skills mit Zweck, Beispielaufruf, Aufwand und Angabe, ob der Skill Dateien ändert. Er legt selbst keine Skills an.

Beispiel: `/skill-vorschlaege`

**`uebungen-erstellen`**
Schlägt 3 bis 5 Aufgaben zu einem Artikel vor, vom Leichten zum Schweren: Kontrollfrage, Lesen, Ändern, Fehler finden und gegebenenfalls selbst bauen. Zu jeder Aufgabe gibt es erwartetes Ergebnis, Tipp und Lösung getrennt. Er übt nur, was im Artikel steht, und fügt nichts in die Datei ein, bevor du zustimmst.

Beispiel: `/uebungen-erstellen content/meine-seite.md`

**`fehlermeldung-erklaeren`**
Erklärt eine vollständige Fehlermeldung in einfachen Worten, ordnet die wahrscheinlichste Ursache ein (belegt oder vermutet) und nennt nummerierte Lösungsschritte. Gefährliche Befehle wie `git reset --hard` oder `git push --force` schlägt er nicht als Standard vor. Er führt selbst nichts aus.

Beispiel: `/fehlermeldung-erklaeren` und danach die Meldung einfügen

**`artikel-aktualisieren`**
Sucht Versionsnummern, Befehle, Links und zeitabhängige Aussagen und gleicht sie mit offiziellen Quellen ab. Jeder Fund bekommt `OK`, `Veraltet`, `Unsicher` oder `Nicht prüfbar`, mit Quelle und Abrufdatum. Was nicht geprüft werden kann, meldet er als solches, statt zu raten. Änderungen erst nach deiner Zustimmung.

Beispiel: `/artikel-aktualisieren README.md setup.md`

**`lesbarkeit-pruefen`**
Beurteilt, wie gut Einsteiger den Text verstehen: Satzlänge, Schachtelsätze, unerklärte Fachwörter, Absatzlänge, roter Faden, vage Aussagen und Anrede. Er gibt höchstens 8 Hinweise und schreibt nichts um. Formulierungsvorschläge liefert danach `inhalt-verbessern`.

Beispiel: `/lesbarkeit-pruefen content/meine-seite.md`

**`querweise`**
Sucht im Artikel Stellen, an denen ein externer Link eine Aussage belegt oder echten Mehrwert bietet, und schlägt dafür seriöse Quellen vor (offizielle Dokumentation, Behörden, Hochschulen, Fachmedien). Er arbeitet sparsam (Richtwert: 2 bis 5 externe Links pro Artikel), verlinkt nie auf Spam oder unsichere Seiten und prüft jede URL, statt sie zu erfinden. Normale redaktionelle Links bleiben ohne `nofollow`, `sponsored` und `ugc` sind nur für Werbung und Nutzerinhalte gedacht. Vorhandene externe Links prüft er ebenfalls. Änderungen erst nach deiner Zustimmung. Ein besseres Ranking kann er nicht garantieren.

Beispiel: `/querweise content/voraussetzungen.md`

### Tokenverbrauch der Skills (Schätzung)

Die Werte sind **geschätzt**: Zeichenzahl geteilt durch 3,5 für deutschen Text, gerundet. Der echte Verbrauch weicht davon ab. Stand: November 2026.

- **Dauerhaft:** Claude kennt in jeder Sitzung von jedem Skill nur Name und Beschreibung. Das kostet Tokens, auch wenn du den Skill nie aufrufst.
- **Beim Aufruf:** Erst dann wird die ganze Anleitung (`SKILL.md`) geladen.
- **Zusätzlich:** Was ein Skill beim Arbeiten liest oder ausgibt, kommt on top und hängt vom Text ab.

| Skill | Dauerhaft | Beim Aufruf | Zusätzlich beim Arbeiten |
|-------|----------:|------------:|--------------------------|
| `satz-pruefen` | ca. 60 | ca. 480 | markierter Text |
| `text-pruefen` | ca. 60 | ca. 1.880 | ganzer Text, Websuchen |
| `vorschlag-artikel` | ca. 65 | ca. 720 | vorhandene Artikel unter `content/` |
| `schreibvorschlaege` | ca. 60 | ca. 690 | der Text |
| `artikel-luecken` | ca. 60 | ca. 660 | der Artikel, ggf. weitere Artikel |
| `inhalt-verbessern` | ca. 60 | ca. 600 | der Text |
| `bild-alt-text` | ca. 60 | ca. 850 | Texte und die Bilder selbst |
| `code-erklaeren` | ca. 50 | ca. 700 | der Code |
| `neue-seite` | ca. 55 | ca. 680 | `content/` und `zola.toml` |
| `veroeffentlichen` | ca. 60 | ca. 740 | Ausgaben von `git` und `zola` |
| `themen-vorschlaege` | ca. 60 | ca. 730 | **alle** Seiten unter `content/` |
| `skill-vorschlaege` | ca. 55 | ca. 650 | **alle** Skills, README, Konfiguration, Commits |
| `uebungen-erstellen` | ca. 50 | ca. 630 | der Artikel |
| `fehlermeldung-erklaeren` | ca. 60 | ca. 810 | die Fehlermeldung, ggf. Dateien |
| `artikel-aktualisieren` | ca. 65 | ca. 730 | alle geprüften Dateien, Websuchen |
| `lesbarkeit-pruefen` | ca. 55 | ca. 770 | der Text |
| `querweise` | ca. 65 | ca. 910 | der Artikel, Websuchen und Abrufe der Quellen |
| **Summe aller 17** | **ca. 1.000** | **ca. 13.200** | |

Die 1.000 Tokens fallen in jeder Sitzung an. Die 13.200 Tokens entstehen nur, wenn du **alle** Skills in einer Sitzung aufrufst. Ein einzelner Aufruf kostet meist unter 1.000 Tokens für die Anleitung. Teurer werden Skills, die viele Dateien lesen (`themen-vorschlaege`, `skill-vorschlaege`, `artikel-aktualisieren`) oder im Web suchen (`text-pruefen`, `artikel-aktualisieren`, `querweise`), vor allem wenn die Seite wächst.

Die Beschreibungen in `SKILL.md` sind bewusst kurz gehalten (etwa 200 bis 260 Zeichen), um den dauerhaften Verbrauch zu senken. Beim Anlegen neuer Skills sollte die Beschreibung ebenfalls kurz bleiben, aber weiterhin sagen, wann der Skill zu verwenden ist, sonst findet Claude ihn nicht zuverlässig.

### Welcher Skill wann?

```
Welche Themen fehlen?        → themen-vorschlaege
Neue Seite anlegen           → neue-seite
Neuer Artikel geplant        → vorschlag-artikel
Text halb geschrieben        → schreibvorschlaege
Text fertig, was fehlt?      → artikel-luecken
Formulierungen verbessern    → inhalt-verbessern
Bilder einbinden             → bild-alt-text
Code im Artikel erklären     → code-erklaeren
Übungen zum Artikel          → uebungen-erstellen
Ist der Text verständlich?   → lesbarkeit-pruefen
Fehlermeldung verstehen      → fehlermeldung-erklaeren
Sind die Inhalte aktuell?    → artikel-aktualisieren
Quellen verlinken            → querweise
Einzelnen Satz korrigieren   → satz-pruefen
Text prüfen (Fehler, SEO)    → text-pruefen
Vor dem Push                 → veroeffentlichen
Welche Skills fehlen?        → skill-vorschlaege
```

### Eigene Skills hinzufügen

Lege `.claude/skills/<name>/SKILL.md` an. Die Datei beginnt mit Front Matter aus `name` und `description` (Beschreibung, wann der Skill verwendet wird), danach folgen die Anweisungen. Als Vorlage eignet sich `.claude/skills/satz-pruefen/SKILL.md`.

## Rechtliches

Impressum und Datenschutzerklärung stehen unter `content/impressum.md` und `content/datenschutz.md`. Die selbst erstellten Inhalte stehen, sofern nicht anders angegeben, unter [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).
