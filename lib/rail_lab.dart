import 'package:flutter/material.dart';

/// Interaktive, rein lokale Git-Lernsimulation: keine echten Git-Operationen.
class RailLab extends StatefulWidget {
  const RailLab({super.key});
  @override
  State<RailLab> createState() => _RailLabState();
}

class _RailLabState extends State<RailLab> {
  static const dark = Color(0xFF101E30);
  static const mint = Color(0xFF49D8BA);
  static const gold = Color(0xFFFFBE65);
  bool branch = false;
  bool committed = false;
  bool merged = false;
  double switchPosition = .32;
  String message = 'Ziehe die Weiche am Hauptgleis nach oben, um einen Branch (Abzweigung) anzulegen.';
  int get stage => !branch ? 0 : !committed ? 1 : !merged ? 2 : 3;

  void makeBranch() => setState(() {
    branch = true;
    message = 'Super! Dein Branch (Abzweigung) heißt feature-header. main bleibt unverändert. Setze nun einen Commit.';
  });
  void commit() => setState(() {
    committed = true;
    message = 'Commit (Speicherpunkt) gesetzt! Deine Änderung ist auf feature-header dokumentiert. Führe sie nun zusammen.';
  });
  void merge() => setState(() {
    merged = true;
    message = 'Merge (Zusammenführen) erfolgreich! Die Änderung ist jetzt auf main – aber noch nicht auf einer Live-Website.';
  });
  void reset() => setState(() {
    branch = false;
    committed = false;
    merged = false;
    switchPosition = .32;
    message = 'Ziehe die Weiche am Hauptgleis nach oben, um einen Branch (Abzweigung) anzulegen.';
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const Text('WEICHENSTELLWERK · INTERAKTIV', style: TextStyle(color: mint, letterSpacing: 1.5, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      const Text('Baue deinen ersten Branch', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
      const SizedBox(height: 8),
      const Text('Ein Webprojekt: Du baust einen neuen Header, ohne den aktuellen Stand direkt zu verändern. Ziehe die Weiche oder benutze die Schaltflächen.'),
      const SizedBox(height: 18),
      Container(
        decoration: BoxDecoration(color: const Color(0xFF183649), borderRadius: BorderRadius.circular(18), border: Border.all(color: Colors.white24)),
        child: Column(children: [
          Padding(padding: const EdgeInsets.fromLTRB(16, 14, 16, 0), child: Row(children: [
            const Icon(Icons.alt_route, color: mint),
            const SizedBox(width: 8),
            const Expanded(child: Text('Gleisplan: Website-Header', style: TextStyle(fontWeight: FontWeight.bold))),
            Text('Schritt ${stage + 1}/4', style: const TextStyle(color: gold)),
          ])),
          LayoutBuilder(builder: (context, constraints) {
            final w = constraints.maxWidth;
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanUpdate: branch ? null : (details) {
                final p = (details.localPosition.dx / w).clamp(.16, .7);
                setState(() { switchPosition = p; });
                if (details.localPosition.dy < 104) makeBranch();
              },
              child: SizedBox(
                height: 220,
                width: double.infinity,
                child: CustomPaint(painter: RailLabPainter(branch: branch, committed: committed, merged: merged, switchPosition: switchPosition)),
              ),
            );
          }),
          Padding(padding: const EdgeInsets.fromLTRB(16, 0, 16, 15), child: Row(children: [
            Icon(stage == 3 ? Icons.check_circle : Icons.info_outline, color: stage == 3 ? mint : gold),
            const SizedBox(width: 10),
            Expanded(child: Text(message, style: const TextStyle(height: 1.35))),
          ])),
        ]),
      ),
      const SizedBox(height: 18),
      Wrap(spacing: 10, runSpacing: 10, children: [
        FilledButton.icon(onPressed: branch ? null : makeBranch, icon: const Icon(Icons.call_split), label: const Text('1. Branch (Abzweigung)'), style: FilledButton.styleFrom(backgroundColor: gold, foregroundColor: dark)),
        FilledButton.icon(onPressed: branch && !committed ? commit : null, icon: const Icon(Icons.save), label: const Text('2. Commit (Speicherpunkt)')),
        FilledButton.icon(onPressed: committed && !merged ? merge : null, icon: const Icon(Icons.merge), label: const Text('3. Merge (Zusammenführen)')),
        OutlinedButton.icon(onPressed: reset, icon: const Icon(Icons.refresh), label: const Text('Neustart')),
      ]),
      const SizedBox(height: 18),
      Card(color: Colors.white.withValues(alpha: .07), child: const Padding(
        padding: EdgeInsets.all(16),
        child: Text('🚦 Gut zu wissen: Diese Gleise sind ein Modell der Versionsgeschichte. Ein Branch ist keine echte Kopie des Projekts, und ein Merge ist kein Deployment. Die Simulation verändert keine GitHub-Repositories.'),
      )),
    ],
  );
}

class RailLabPainter extends CustomPainter {
  final bool branch;
  final bool committed;
  final bool merged;
  final double switchPosition;
  RailLabPainter({required this.branch, required this.committed, required this.merged, required this.switchPosition});

  @override
  void paint(Canvas canvas, Size s) {
    final mainY = s.height * .70;
    final forkX = s.width * switchPosition;
    final joinX = s.width * .84;
    final base = Paint()..color = const Color(0xFF49D8BA)..strokeWidth = 7..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    final side = Paint()..color = const Color(0xFFFFBE65)..strokeWidth = 7..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    final faded = Paint()..color = Colors.white24..strokeWidth = 4..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(18, mainY), Offset(s.width - 18, mainY), base);
    final path = Path()..moveTo(forkX, mainY)..cubicTo(forkX + 35, mainY, forkX + 35, mainY - 84, forkX + 80, mainY - 84)
      ..lineTo(joinX - 75, mainY - 84)..cubicTo(joinX - 32, mainY - 84, joinX - 32, mainY, joinX, mainY);
    canvas.drawPath(path, branch ? side : faded);
    final switchPaint = Paint()..color = branch ? const Color(0xFFFFBE65) : Colors.white;
    canvas.drawCircle(Offset(forkX, mainY), 12, switchPaint);
    canvas.drawCircle(Offset(forkX, mainY), 5, Paint()..color = const Color(0xFF101E30));
    _label(canvas, 'main (Hauptstrecke)', Offset(18, mainY + 18), Colors.white);
    _label(canvas, branch ? 'feature-header (Branch)' : 'Hier abzweigen ↑', Offset(forkX + 8, mainY - 115), branch ? const Color(0xFFFFBE65) : Colors.white70);
    if (branch) {
      _train(canvas, Offset(forkX + 85, mainY - 98), const Color(0xFFFFBE65));
    }
    if (committed) {
      canvas.drawCircle(Offset(joinX - 90, mainY - 84), 12, Paint()..color = const Color(0xFF49D8BA));
      _label(canvas, 'Commit', Offset(joinX - 119, mainY - 55), Colors.white);
    }
    if (merged) {
      canvas.drawCircle(Offset(joinX, mainY), 12, Paint()..color = const Color(0xFF49D8BA));
      _label(canvas, 'Merge ✓', Offset(joinX - 35, mainY + 18), const Color(0xFF49D8BA));
    }
    if (!branch) _train(canvas, Offset(forkX - 20, mainY - 32), const Color(0xFF49D8BA));
  }

  void _label(Canvas c, String value, Offset at, Color color) {
    final span = TextSpan(text: value, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600));
    final painter = TextPainter(text: span, textDirection: TextDirection.ltr, maxLines: 1)..layout();
    painter.paint(c, at);
  }
  void _train(Canvas c, Offset at, Color color) {
    final rect = RRect.fromRectAndRadius(Rect.fromLTWH(at.dx, at.dy, 43, 26), const Radius.circular(6));
    c.drawRRect(rect, Paint()..color = color);
    c.drawRect(Rect.fromLTWH(at.dx + 7, at.dy + 5, 10, 8), Paint()..color = const Color(0xFF101E30));
    c.drawRect(Rect.fromLTWH(at.dx + 23, at.dy + 5, 10, 8), Paint()..color = const Color(0xFF101E30));
  }

  @override
  bool shouldRepaint(covariant RailLabPainter old) => branch != old.branch || committed != old.committed || merged != old.merged || switchPosition != old.switchPosition;
}
