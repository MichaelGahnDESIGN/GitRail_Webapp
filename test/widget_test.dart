import 'package:flutter_test/flutter_test.dart';
import 'package:git_rail/main.dart';

void main() {
  testWidgets('Gleisbau startet und Branch lässt sich anlegen', (tester) async {
    await tester.pumpWidget(const GitRailApp());
    expect(find.text('Baue deinen ersten Branch'), findsOneWidget);
    await tester.tap(find.text('1. Branch (Abzweigung)'));
    await tester.pump();
    expect(find.textContaining('Dein Branch (Abzweigung)'), findsOneWidget);
    await tester.tap(find.text('2. Commit (Speicherpunkt)'));
    await tester.pump();
    expect(find.textContaining('Commit (Speicherpunkt) gesetzt'), findsOneWidget);
  });

  testWidgets('Missionen sind weiterhin verfügbar', (tester) async {
    await tester.pumpWidget(const GitRailApp());
    await tester.tap(find.text('Missionen'));
    await tester.pump();
    expect(find.text('Die Hauptstrecke'), findsOneWidget);
  });
}
