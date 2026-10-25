# Game Design Document – GitRail

## High Concept
**Ein Git-Lernspiel im Eisenbahn-Universum**. Der Spieler wird Fahrdienstleiter. Er baut ein Schienennetz und lernt, wie Quellcode-Versionen, parallele Arbeit und Veröffentlichungen funktionieren. Zielgruppe: Menschen mit Website-Erfahrung, aber ohne Git-Routine.

## Lernprinzipien
- Erst Handlung, dann Fachbegriff, dann die reale Bedeutung.
- Immer `Fachbegriff (Bahn-Metapher)`.
- Sofortiges Feedback ohne Bestrafung, wiederholbare Aufgaben.
- Metaphern dürfen das tatsächliche Git-Verhalten nicht verfälschen.
- Barrierearm: Farben nie allein als Informationsträger.

## Visuelle Richtung
Dunkles Petrol / Nachtblau, türkise Hauptstrecke, goldene Abzweige, reduzierte 2D-Vektorgrafiken, klar lesbare Schilder, charmante Züge. Nicht wie eine komplizierte IDE. Flaches 2D mit hochwertiger UI.

## Spielschleife
Auftrag → Entscheidung → Simulation → Ergebnis → Begriff verstehen → Punkte sammeln → nächste Station.

## Kampagne (erste 11 Lernstationen)
1. main – Die Hauptstrecke
2. Commit – Der Speicherpunkt
3. Branch – Die Abzweigung
4. Push – Zur Zentrale
5. Pull – Die neuen Pläne
6. Pull Request – Die Streckenprüfung
7. Merge – Gleise verbinden
8. Worktree – Zwei Bautrupps
9. Merge-Konflikt – Rotes Signal
10. Deploy – Bahnhofseröffnung
11. .gitignore – Die Sperrliste

## MVP – umgesetzt
- Deutsches Flutter-Interface mit responsive-zentriertem Layout
- Visualisierte Gleisstrecke als Flutter-CustomPainter
- 11 interaktive Quiz-Lektionen und unmittelbares Feedback
- Punkte/XP und Fortschrittsanzeige innerhalb einer Sitzung
- Glossar und Rücksprung ins Spiel
- Keine Anmeldung und keine Datenbank

## Roadmap
### V0.2 – didaktische Gleisbau-Simulation
Züge / Weichen direkt bedienen, Commit-Punkte platzieren, Branch erstellen, Merge-Konflikte sichtbar lösen; erklärende Git-Kommandos.
### V0.3 – Langzeitmotivation
Lokal gespeicherter Fortschritt, Kapitelkarte, Sterne, Erfolge, mehrere Schwierigkeitsgrade.
### V0.4 – Team-Modus als Simulation
Zwei Bauhöfe/Agents auf Worktrees, Dateien als Ressourcen, Überschneidungen als Aufgaben.
### V1.0
Accessibility-Audit, umfassende Git-Fachprüfung, strukturierte Übersetzungen, optional PWA/offline.

## Korrektheit der Metaphern
| Git | Bahn | Technisch korrekt erklärt |
|---|---|---|
| Repository | gesamtes Bahnnetz | Versionsgeschichte und Projekt |
| main | Hauptstrecke | Konventioneller Branchname |
| Branch | Abzweigung | Unabhängige Entwicklungslinie |
| Commit | Speicherpunkt | Snapshot versionierter Änderungen |
| Push | Baupläne hochladen | Übertragung lokaler Commits |
| Pull | Pläne holen | Fetch und anschließende Integration |
| Pull Request | Prüf-/Anschlussantrag | Änderungsvorschlag zur Review |
| Merge | Zusammenführen | Integration zweier Entwicklungsstände |
| Worktree | eigener Bauhof | Separates Arbeitsverzeichnis |
| Deploy | Strecke eröffnen | Veröffentlichung des Builds |
| .gitignore | Ausschlussliste | Ignoriert unversionierte passende Dateien |
