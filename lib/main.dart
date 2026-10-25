import 'package:flutter/material.dart';

void main() => runApp(const GitRailApp());

const navy = Color(0xFF101E30);
const mint = Color(0xFF49D8BA);
const amber = Color(0xFFFFBE65);
const paper = Color(0xFFF3F6F8);

class Lesson {
  final String title;
  final String term;
  final String translation;
  final String scenario;
  final List<String> answers;
  final int correct;
  final String explanation;
  const Lesson(this.title, this.term, this.translation, this.scenario,
      this.answers, this.correct, this.explanation);
}

const lessons = <Lesson>[
  Lesson('Die Hauptstrecke', 'main', 'Hauptstrecke',
      'Die stabile Version deiner Website soll erhalten bleiben. Wo liegt sie im Gleisnetz?',
      ['Auf main', 'Im Papierkorb', 'Im Browser-Cache'], 0,
      'main ist in vielen Projekten die Hauptentwicklungslinie – nicht automatisch die Live-Website.'),
  Lesson('Der Speicherpunkt', 'Commit', 'Baufortschritt festhalten',
      'Du hast die Navigation verbessert und möchtest diesen Stand nachvollziehbar sichern.',
      ['Deploy', 'Commit', 'Merge'], 1,
      'Ein Commit hält eine Auswahl deiner Änderungen in der lokalen Git-Geschichte fest.'),
  Lesson('Die Abzweigung', 'Branch', 'Abzweig',
      'Du möchtest einen neuen Header entwickeln, ohne den aktuellen Hauptstand zu verändern.',
      ['Neuen Branch erstellen', 'Live veröffentlichen', 'Alle Dateien ignorieren'], 0,
      'Ein Branch ist eine eigene Entwicklungslinie mit eigenen Commits.'),
  Lesson('An die Zentrale', 'Push', 'Commits hochladen',
      'Deine lokalen Commits sollen auf dem gemeinsamen GitHub-Repository ankommen.',
      ['Pull', 'Push', 'Deploy'], 1,
      'Push überträgt Commits zum entfernten Repository. Dadurch wird die Website nicht automatisch live.'),
  Lesson('Die neuen Pläne', 'Pull', 'Änderungen holen und integrieren',
      'Claude hat neue Commits auf GitHub veröffentlicht. Du willst sie in deine lokale Strecke übernehmen.',
      ['Commit', 'Pull', 'gitignore'], 1,
      'Pull holt entfernte Änderungen und integriert sie üblicherweise in deinen lokalen Branch.'),
  Lesson('Die Streckenprüfung', 'Pull Request', 'Antrag zum Zusammenführen',
      'Dein neuer Header ist fertig. Das Team soll ihn erst prüfen.',
      ['Pull Request eröffnen', 'Direkt löschen', 'Dateien verstecken'], 0,
      'Ein Pull Request schlägt Änderungen zur Prüfung und Zusammenführung vor.'),
  Lesson('Gleise verbinden', 'Merge', 'Zusammenführen',
      'Die geprüfte Abzweigung soll wieder in die Hauptstrecke integriert werden.',
      ['Branch umbenennen', 'Merge durchführen', 'Browser schließen'], 1,
      'Ein Merge führt Entwicklungslinien zusammen. Konflikte können eine Entscheidung erfordern.'),
  Lesson('Zwei Bautrupps', 'Worktree', 'eigener Arbeitsordner',
      'Claude und Codex entwickeln parallel am selben Projekt. Wie vermeidest du direkte Dateiüberschreibungen?',
      ['Beide im selben Ordner arbeiten lassen', 'Getrennte Worktrees verwenden', 'Commits abschalten'], 1,
      'Worktrees sind getrennte Arbeitsverzeichnisse eines Git-Repositories. Logische Merge-Konflikte bleiben möglich.'),
  Lesson('Rotes Signal', 'Merge-Konflikt', 'widersprüchliche Baupläne',
      'Zwei Branches ändern dieselben CSS-Zeilen gegensätzlich. Was passiert möglicherweise?',
      ['Git wählt immer die beste Variante', 'Konflikt muss aufgelöst werden', 'Website geht sofort live'], 1,
      'Git kann manche Änderungen automatisch vereinen. Widersprüche müssen geprüft und aufgelöst werden.'),
  Lesson('Bahnhofseröffnung', 'Deploy', 'für Besucher veröffentlichen',
      'Der Code ist getestet und in main. Wie gelangt die Version nun auf deinen all-inkl-Webspace?',
      ['Mit einem Deployment', 'Allein durch den Commit', 'Mit gitignore'], 0,
      'Deploy ist ein separater Veröffentlichungsschritt; er kann automatisiert sein, muss es aber nicht.'),
  Lesson('Die Sperrliste', '.gitignore', 'bestimmte Dateien auslassen',
      'Cache-Dateien sollen nicht versehentlich neu in Git aufgenommen werden.',
      ['.gitignore definieren', 'Merge erzwingen', 'Branch löschen'], 0,
      '.gitignore verhindert das neue Erfassen passender unversionierter Dateien. Bereits erfasste Dateien bleiben weiterhin versioniert.'),
];

class GitRailApp extends StatelessWidget {
  const GitRailApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'GitRail',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: mint, brightness: Brightness.dark),
          scaffoldBackgroundColor: navy,
          fontFamily: 'Roboto',
        ),
        home: const RailHome(),
      );
}

class RailHome extends StatefulWidget {
  const RailHome({super.key});
  @override
  State<RailHome> createState() => _RailHomeState();
}

class _RailHomeState extends State<RailHome> {
  int index = 0;
  int? selected;
  bool checked = false;
  int score = 0;
  final Set<int> completed = {};
  bool glossary = false;

  void checkAnswer() {
    if (selected == null || checked) return;
    setState(() {
      checked = true;
      if (selected == lessons[index].correct && !completed.contains(index)) {
        completed.add(index);
        score += 100;
      }
    });
  }

  void next() {
    setState(() {
      index = (index + 1) % lessons.length;
      selected = null;
      checked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lesson = lessons[index];
    final isCorrect = selected == lesson.correct;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  Row(children: [
                    const Icon(Icons.train_rounded, color: mint, size: 36),
                    const SizedBox(width: 10),
                    const Text('GitRail', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900)),
                    const Spacer(),
                    Text('⭐ $score XP', style: const TextStyle(color: amber, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 14),
                    TextButton.icon(
                      onPressed: () => setState(() => glossary = !glossary),
                      icon: Icon(glossary ? Icons.route : Icons.menu_book),
                      label: Text(glossary ? 'Spiel' : 'Glossar'),
                    ),
                  ]),
                  const SizedBox(height: 14),
                  LinearProgressIndicator(value: completed.length / lessons.length,
                    minHeight: 7, backgroundColor: Colors.white12,
                    color: mint, borderRadius: BorderRadius.circular(10)),
                  const SizedBox(height: 18),
                  Expanded(child: SingleChildScrollView(
                    child: glossary ? _glossary() : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _routeCard(),
                        const SizedBox(height: 20),
                        Text('MISSION ${index + 1} / ${lessons.length}',
                          style: const TextStyle(color: mint, letterSpacing: 2, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 8),
                        Text(lesson.title, style: const TextStyle(fontSize: 31, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 4),
                        Text('${lesson.term} (${lesson.translation})',
                          style: const TextStyle(color: amber, fontSize: 17)),
                        const SizedBox(height: 16),
                        Text(lesson.scenario, style: const TextStyle(fontSize: 19, height: 1.5)),
                        const SizedBox(height: 18),
                        for (var i = 0; i < lesson.answers.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: OutlinedButton(
                              onPressed: checked ? null : () => setState(() => selected = i),
                              style: OutlinedButton.styleFrom(
                                alignment: Alignment.centerLeft,
                                minimumSize: const Size.fromHeight(56),
                                backgroundColor: selected == i ? mint.withValues(alpha: .19) : Colors.white.withValues(alpha: .04),
                                side: BorderSide(color: selected == i ? mint : Colors.white24),
                              ),
                              child: Text('${String.fromCharCode(65 + i)}   ${lesson.answers[i]}',
                                style: const TextStyle(fontSize: 16)),
                            ),
                          ),
                        if (checked) Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: (isCorrect ? mint : amber).withValues(alpha: .12),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(isCorrect ? '✅ Grünes Signal! +100 XP' : '🚧 Rotes Signal – probiere es erneut!',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                            const SizedBox(height: 8),
                            Text(lesson.explanation),
                          ]),
                        ),
                        const SizedBox(height: 18),
                        FilledButton.icon(
                          onPressed: checked ? (isCorrect ? next : () => setState(() {checked = false; selected = null;})) : (selected == null ? null : checkAnswer),
                          icon: Icon(checked && isCorrect ? Icons.arrow_forward : Icons.check),
                          label: Text(checked ? (isCorrect ? 'Nächster Bahnhof' : 'Noch einmal versuchen') : 'Antwort prüfen'),
                          style: FilledButton.styleFrom(backgroundColor: mint, foregroundColor: navy,
                            minimumSize: const Size.fromHeight(54)),
                        ),
                      ],
                    ),
                  )),
                  const SizedBox(height: 8),
                  const Text('Lernsimulation · keine echten Git-Befehle · Fortschritt nur für diese Sitzung',
                    style: TextStyle(color: Colors.white54, fontSize: 11)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _routeCard() => Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: const LinearGradient(colors: [Color(0xFF1B3A4F), Color(0xFF163444)]),
      border: Border.all(color: Colors.white24),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(children: [
        Icon(Icons.alt_route, color: mint), SizedBox(width: 8),
        Text('DEIN STRECKENNETZ', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.4)),
      ]),
      const SizedBox(height: 4),
      SizedBox(height: 125, width: double.infinity, child: CustomPaint(painter: RailMapPainter(index: index))),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text('main (Hauptstrecke)', style: TextStyle(color: Colors.white70, fontSize: 12)),
        Text('${completed.length} / ${lessons.length} Stationen', style: const TextStyle(color: mint, fontSize: 12)),
      ]),
    ]),
  );

  Widget _glossary() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('Das Bahnhofswörterbuch', style: TextStyle(fontSize: 29, fontWeight: FontWeight.w900)),
    const SizedBox(height: 8),
    const Text('Offizieller Git-Begriff + einfache Bedeutung', style: TextStyle(color: Colors.white70)),
    const SizedBox(height: 18),
    for (final l in lessons)
      Card(
        color: Colors.white.withValues(alpha: .065),
        child: ListTile(
          leading: const Icon(Icons.train, color: mint),
          title: Text(l.term, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('(${l.translation})\n${l.explanation}'),
          isThreeLine: true,
        ),
      ),
  ]);
}

class RailMapPainter extends CustomPainter {
  final int index;
  RailMapPainter({required this.index});
  @override
  void paint(Canvas canvas, Size size) {
    final y = size.height * .57;
    final line = Paint()..color = Colors.white54..strokeWidth = 4..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    final branch = Paint()..color = amber..strokeWidth = 4..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(12, y), Offset(size.width - 12, y), line);
    final p = Path()..moveTo(size.width * .2, y)..quadraticBezierTo(size.width * .34, y - 65, size.width * .49, y - 65)
      ..lineTo(size.width * .69, y - 65)..quadraticBezierTo(size.width * .78, y - 65, size.width * .85, y);
    canvas.drawPath(p, branch);
    for (var i = 0; i < 6; i++) {
      final x = size.width * (.13 + i * .145);
      canvas.drawCircle(Offset(x, y), 8, Paint()..color = i <= index % 6 ? mint : const Color(0xFF557080));
      canvas.drawCircle(Offset(x, y), 3, Paint()..color = navy);
    }
    final x = size.width * (.13 + (index % 6) * .145);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(x - 20, y - 32, 40, 24), const Radius.circular(5)),
      Paint()..color = mint);
    canvas.drawRect(Rect.fromLTWH(x - 13, y - 27, 9, 9), Paint()..color = navy);
    canvas.drawRect(Rect.fromLTWH(x + 3, y - 27, 9, 9), Paint()..color = navy);
  }
  @override
  bool shouldRepaint(covariant RailMapPainter oldDelegate) => oldDelegate.index != index;
}
