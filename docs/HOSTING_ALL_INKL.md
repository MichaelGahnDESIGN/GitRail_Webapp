# Deployment auf all-inkl – ohne MySQL

## Ergebnis
Die Flutter-WebApp wird zu statischen HTML-, JavaScript-, WASM- und Asset-Dateien kompiliert. Diese lassen sich über normale all-inkl-Webspaces ausliefern. MySQL ist für GitRail nicht erforderlich.

## Voraussetzungen
- Flutter SDK auf lokalem Mac oder in GitHub Actions
- Webdomain oder Subdomain bei all-inkl
- Zugang zum Webspace (z. B. SFTP/FTP), **niemals Zugangsdaten ins Repository committen**

## Build
```bash
flutter create . --platforms web
flutter pub get
flutter analyze
flutter test
flutter build web --release
```
Der auszuliefernde Inhalt befindet sich in `build/web/`. Den **Inhalt** dieses Ordners ins Zielverzeichnis des all-inkl-Webspaces kopieren.

## Domain und Unterverzeichnis
Bei Bereitstellung auf einer eigenen (Sub-)Domain mit Webroot direkt im Zielverzeichnis bleibt der Basis-Pfad `/`.
Bei `https://example.org/gitrail/` stattdessen:
```bash
flutter build web --release --base-href /gitrail/
```

## Hosting-Konfiguration
- HTTPS im KAS für die Domain aktivieren.
- Bei Routing innerhalb einer Flutter-App ggf. passende Rewrite-Regeln einrichten. Der MVP benötigt keine serverseitigen Anwendungsrouten.
- Statische Dateitypen durch den Webserver korrekt ausliefern lassen; insbesondere WebAssembly, wenn der jeweilige Flutter-Renderer es ausliefert.
- Browsercache bei neuen Builds beachten.

## GitHub Actions
Der Workflow `.github/workflows/flutter-web.yml` baut und testet automatisch. Das Ergebnis kann als Actions-Artefakt heruntergeladen werden. **Es gibt bewusst kein automatisches Live-Deployment** und keine erforderlichen FTP-Secrets.

## Datenschutz
Ohne Accounts, Tracking und Backend bleibt die technische Basis schlank. Eine öffentliche Website benötigt trotzdem passende Betreiberangaben und eine Prüfung der tatsächlich eingebundenen Drittressourcen. Mit dem MVP werden keine Nutzerkonten angelegt.
