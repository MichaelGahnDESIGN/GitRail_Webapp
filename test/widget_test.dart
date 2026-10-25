import 'package:flutter_test/flutter_test.dart';
import 'package:git_rail/main.dart';

void main() {
  testWidgets('startet auf der ersten Lernmission', (tester) async {
    await tester.pumpWidget(const GitRailApp());
    expect(find.text('Die Hauptstrecke'), findsOneWidget);
    expect(find.text('Antwort prüfen'), findsOneWidget);
  });
}
