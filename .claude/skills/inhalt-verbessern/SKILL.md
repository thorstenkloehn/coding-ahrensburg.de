---
name: inhalt-verbessern
description: Liest einen bereits geschriebenen deutschen Text und zeigt konkrete Verbesserungsvorschläge für den Inhalt, jeweils mit einem Textvorschlag zum Vergleich (alt und neu). Ändert die Datei nur nach Rückfrage. Verwenden, wenn der Nutzer einen vorhandenen Text verbessern lassen will und Formulierungen sehen möchte (z. B. "verbessere den Inhalt", "zeig mir Textvorschläge", "wie könnte der Absatz besser lauten").
---

# Inhalt verbessern (Deutsch)

Lies den Text, den der Nutzer geschrieben hat (Datei, markierte Zeilen oder eingefügter Text), und zeige, **was inhaltlich besser werden kann**. Zu jedem Vorschlag gehört ein **Textvorschlag**, damit der Nutzer die Wirkung sieht und entscheiden kann.

Ist unklar, welcher Text gemeint ist, kurz nachfragen. Bei markierten Zeilen nur diese betrachten.

## Worauf geachtet wird

1. **Inhalt:** Fehlende Erklärungen, Beispiele oder Schritte, Unklares, Zu-Allgemeines, Widersprüche, Wiederholungen.
2. **Verständlichkeit:** Lange oder verschachtelte Sätze, unerklärte Fachbegriffe, unklare Bezüge.
3. **Aufbau:** Reihenfolge, Überschriften, Einstieg mit Kernaussage, Listen oder Tabellen, wo sie helfen.
4. **Suchmaschinen und Leser:** Beantwortet der Text die Suchfrage früh und vollständig? Passen Titel und Beschreibung? Hilfreich vor keywordlastig.

## Regeln für die Textvorschläge

- Nur umformulieren, was im Text schon steht oder sich eindeutig daraus ergibt. **Keine neuen Fakten, Zahlen, Zitate oder Quellen erfinden.** Wo eine Angabe fehlt, einen Platzhalter wie `[hier Beleg ergänzen]` setzen und sagen, was zu klären ist.
- Ton und Anrede des Nutzers beibehalten.
- Keine fremden Texte übernehmen oder nachbauen.
- Rechtschreibung nur nebenbei übernehmen, keine eigene Fehlerliste (dafür `satz-pruefen` und `text-pruefen`).

## Ausgabe

Höchstens 5 bis 8 Vorschläge, nach Wirkung sortiert. Je Vorschlag:

1. **Problem** in einem Satz (mit Zeilennummer, wenn bekannt).
2. **Vorher:** die betroffene Stelle, kurz zitiert.
3. **Vorschlag:** der verbesserte Text.
4. **Warum:** ein Halbsatz.

Am Ende fragen, welche Vorschläge übernommen werden sollen. **Die Datei erst nach ausdrücklicher Zustimmung ändern** und dann nur die ausgewählten Stellen.

Antworte auf Deutsch, knapp und ohne Floskeln.
