import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transactions_tracker/presentation/widgets/card_creation/balance_step.dart';

void main() {
  testWidgets('BalanceStep validation works correctly', (WidgetTester tester) async {
    final formKey = GlobalKey<FormState>();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Form(
          key: formKey,
          child: BalanceStep(
            onBalanceChanged: (balance) {},
          ),
        ),
      ),
    ));

    // Invalid input (empty)
    await tester.enterText(find.byType(TextFormField), '');
    expect(formKey.currentState!.validate(), false);

    // Invalid input (less than 100)
    await tester.enterText(find.byType(TextFormField), '0');
    expect(formKey.currentState!.validate(), false);

    // Invalid input (more than 1000)
    await tester.enterText(find.byType(TextFormField), '2000');
    expect(formKey.currentState!.validate(), false);

    // Valid input
    await tester.enterText(find.byType(TextFormField), '500');
    expect(formKey.currentState!.validate(), true);
  });
}
