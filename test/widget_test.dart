import 'package:flutter_test/flutter_test.dart';
import 'package:projict_3_todo/main.dart';

void main() {
  testWidgets('Todo app test', (WidgetTester tester) async {
    await tester.pumpWidget(const TodoApp());

    expect(find.byType(TodoApp), findsOneWidget);
  });
}
