# GitRail – Anweisungen für KI-Entwicklungsagenten

## Mission
Baue eine verständliche, zugängliche deutschsprachige Flutter-WebApp, die Git und GitHub mit Eisenbahnmetaphern vermittelt.

## Unverhandelbare Regeln
- Flutter/Dart-first. Keine MySQL-Datenbank, kein verpflichtendes Backend, keine kostenpflichtigen Dienste.
- Webhosting muss auf einfachem all-inkl-Webspace als **statischer Flutter-Web-Build** funktionieren.
- Niemals Zugangsdaten in Code, Doku oder Git committen.
- Hauptbegriffe immer zusammen erklären: `Branch (Abzweigung)`, `Merge (Zusammenführen)`, `Worktree (eigener Arbeitsordner)`.
- Metapher und tatsächliches Git-Verhalten auseinanderhalten. Push ist **kein** Deploy; Merge ist **nicht** physisches Verbinden von Schienen.
- Keine destruktiven Änderungen; neue Features auf eigenen Branches, Tests vor Merge.
- Neue Spielmechanik braucht passende Lernzielbeschreibung und mindestens einen nachvollziehbaren Test.
- `flutter analyze`, `flutter test` und `flutter build web` vor Freigabe ausführen.
- Responsiv, Tastaturbedienung, ausreichender Kontrast, reduced motion berücksichtigen.
- Datensparsam; vorerst keine Accounts oder externe Trackingdienste.

## Definition of Done
1. Deutsche Benutzertexte und klare Erläuterungen.
2. Funktioniert ohne Server-API.
3. Tests grün und Web-Build erfolgreich.
4. Dokumentation in `docs/` aktualisiert.
5. Neue Features auf all-inkl als statische Dateien auslieferbar.

Siehe `docs/ARCHITEKTUR.md`, `docs/SPIELDESIGN.md` und `docs/HOSTING_ALL_INKL.md`.
