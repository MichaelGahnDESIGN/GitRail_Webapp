# Architektur – GitRail

## Zielbild
Flutter Web / Dart → statischer Web-Build → all-inkl-Webspace. Kein Backend und kein MySQL nötig.

## Schichten
- **UI**: Flutter-Material-3-Widgets, mobile-first und responsiv.
- **Lerninhalte**: strukturierte Lektionen, Begriffe, Quizoptionen und Erklärungen.
- **Spielsitzung**: aktuell lokaler Widget-State; bleibt nicht über Reloads erhalten.
- **Später**: optional lokaler Speicher (z. B. shared_preferences / Browser-Storage) für dauerhaften Fortschritt.
- **Simulation**: Git-Aktionen als sichere Spielwelt modellieren, niemals ungefragt echte Repositories manipulieren.

## Datenschutz und Speicher
- MVP: keine Registrierung, keine Datenbank, keine Telemetrie.
- Kein externer Dienst für Spiellogik nötig.
- Bei künftigem lokalem Speichern: Transparenz in Datenschutzhinweisen und Löschfunktion.
- Kein `dart:io` in Web-Code.

## Technische Grenzen
GitRail simuliert reale Konzepte didaktisch. Eine WebApp ohne Backend kann keine lokalen Git-Repositories der Besucher auslesen oder ändern. Echte Git-Integration nur als spätere optionale Funktion mit gesonderter Sicherheit und Einwilligung.

## Weiterentwicklung
Datengetriebene Levels (JSON/Modelle), Routing, lokale Fortschrittsspeicherung, visuelle Gleisbausimulation, Accessibility-Tests, PWA-Modus, weitere Sprachen.
