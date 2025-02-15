import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transactions_tracker/presentation/widgets/card_creation/steps/color_step.dart';

void main() {
  testWidgets('ColorStep validation works correctly', (WidgetTester tester) async {
    final formKey = GlobalKey<FormState>();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Form(
          key: formKey,
          child: ColorStep(
            onColorChanged: (color) {},
          ),
        ),
      ),
    ));

    // Invalid input (no color selected)
    expect(formKey.currentState!.validate(), false);

    // Valid input
    await tester.tap(find.byKey(Key('radio_list_tile_red')));
    expect(formKey.currentState!.validate(), true);
  });
}
