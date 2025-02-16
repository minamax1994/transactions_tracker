import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transactions_tracker/presentation/widgets/card_creation/name_step.dart';

void main() {
  testWidgets('NameStep validation works correctly', (WidgetTester tester) async {
    final formKey = GlobalKey<FormState>();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Form(
          key: formKey,
          child: NameStep(
            onNameChanged: (name) {},
            onCardholderChanged: (cardholder) {},
          ),
        ),
      ),
    ));

    // Invalid input (name less than 3 chars)
    await tester.enterText(find.byKey(Key('card_name_text_field')), 'AA');
    await tester.enterText(find.byKey(Key('cardholder_text_field')), 'Card Holder');
    expect(formKey.currentState!.validate(), false);

    // Invalid input (name has non-English characters)
    await tester.enterText(find.byKey(Key('card_name_text_field')), 'بطاقة دفع');
    await tester.enterText(find.byKey(Key('cardholder_text_field')), 'Card Holder');
    expect(formKey.currentState!.validate(), false);

    // Invalid input (cardholder empty)
    await tester.enterText(find.byKey(Key('card_name_text_field')), 'Test Card');
    await tester.enterText(find.byKey(Key('cardholder_text_field')), '');
    expect(formKey.currentState!.validate(), false);

    // Valid input
    await tester.enterText(find.byKey(Key('card_name_text_field')), 'Test Card');
    await tester.enterText(find.byKey(Key('cardholder_text_field')), 'Card Holder');
    expect(formKey.currentState!.validate(), true);
  });
}
