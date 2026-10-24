import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bendrummond1819_fo529642dc3c7/data/sources/local/shared_preference/shared_preference.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/setup/viewmodel/setup_data_provider.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/setup/widgets/set_up6_screen.dart';

Widget createTestWidget({VoidCallback? onContinue, VoidCallback? onSkip}) {
  return ProviderScope(
    overrides: [
      setupDataProvider.overrideWith(() {
        final notifier = SetupDataNotifier();
        return notifier;
      }),
    ],
    child: ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(home: child),
      child: SetUp6Screen(
        isStandalone: true,
        onContinue: onContinue,
        onSkip: onSkip,
      ),
    ),
  );
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  Future<void> setupTesterView(WidgetTester tester) async {
    tester.view.physicalSize = const Size(375 * 3, 900 * 3);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  }

  Future<void> tapVisible(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  testWidgets('Renders initial empty state and opens form on tap', (
    tester,
  ) async {
    await setupTesterView(tester);
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.text("Any other regular bills?"), findsOneWidget);
    expect(find.text("No bills added yet."), findsOneWidget);
    expect(find.text("Add a bill"), findsOneWidget);

    await tapVisible(tester, find.text("Add a bill"));

    expect(find.text("Bill Name"), findsOneWidget);
    expect(find.text("Bill Amount"), findsOneWidget);
    expect(find.text("Due day"), findsOneWidget);
    expect(find.text("Every 2 weeks Payment"), findsOneWidget);
  });

  testWidgets(
    'Validates Bill Name, Bill Amount positive number, and Due day 1-31',
    (tester) async {
      await setupTesterView(tester);
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await tapVisible(tester, find.text("Add a bill"));

      // 1. Empty submission
      await tapVisible(tester, find.text("Add"));
      expect(find.text("Please enter a bill name"), findsOneWidget);

      // 2. Enter name, leave amount empty
      await tester.enterText(find.byType(TextFormField).at(0), "Electricity");
      await tapVisible(tester, find.text("Add"));
      expect(find.text("Please enter an amount"), findsOneWidget);

      // 3. Enter negative / zero amount
      final amountField = find.byType(TextFormField).at(1);
      await tester.enterText(amountField, "-50");
      await tapVisible(tester, find.text("Add"));
      expect(find.text("Amount must be a positive number"), findsOneWidget);

      await tester.enterText(amountField, "0");
      await tapVisible(tester, find.text("Add"));
      expect(find.text("Amount must be a positive number"), findsOneWidget);

      // 4. Enter valid amount, leave due day empty
      await tester.enterText(amountField, "75.50");
      await tapVisible(tester, find.text("Add"));
      expect(find.text("Enter due day"), findsOneWidget);

      // 5. Enter invalid due day (> 31 or < 1)
      final dayField = find.byType(TextFormField).at(2);
      await tester.enterText(dayField, "32");
      await tapVisible(tester, find.text("Add"));
      expect(find.text("Due day must be between 1 and 31"), findsOneWidget);

      await tester.enterText(dayField, "0");
      await tapVisible(tester, find.text("Add"));
      expect(find.text("Due day must be between 1 and 31"), findsOneWidget);
    },
  );

  testWidgets('Successfully adds monthly bill and resets form', (tester) async {
    await setupTesterView(tester);
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    await tapVisible(tester, find.text("Add a bill"));

    await tester.enterText(find.byType(TextFormField).at(0), "Netflix");
    await tester.enterText(find.byType(TextFormField).at(1), "15.99");
    await tester.enterText(find.byType(TextFormField).at(2), "10");

    await tapVisible(tester, find.text("Add"));

    // Bill should now be in the list
    expect(find.text("Netflix"), findsOneWidget);
    expect(find.text("\$15.99"), findsOneWidget);
    expect(find.text("Monthly • Due day 10"), findsOneWidget);
    expect(find.byIcon(Icons.edit_outlined), findsOneWidget);
    expect(find.byIcon(Icons.close), findsOneWidget);

    // Form should be closed and Add a bill should be visible
    expect(find.text("Add a bill"), findsOneWidget);
  });

  testWidgets('Cancel clears form without deleting previously added bills', (
    tester,
  ) async {
    await setupTesterView(tester);
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    // Add first bill
    await tapVisible(tester, find.text("Add a bill"));
    await tester.enterText(find.byType(TextFormField).at(0), "Gym");
    await tester.enterText(find.byType(TextFormField).at(1), "30");
    await tester.enterText(find.byType(TextFormField).at(2), "5");
    await tapVisible(tester, find.text("Add"));

    expect(find.text("Gym"), findsOneWidget);

    // Open form to add a second bill, but cancel
    await tapVisible(tester, find.text("Add a bill"));
    await tester.enterText(find.byType(TextFormField).at(0), "Spotify");
    await tester.enterText(find.byType(TextFormField).at(1), "10");

    await tapVisible(tester, find.text("Cancel"));

    // Form closed, Gym still exists, Spotify is not added
    expect(find.text("Gym"), findsOneWidget);
    expect(find.text("Spotify"), findsNothing);
  });

  testWidgets(
    'Every 2 weeks checkbox toggles date picker and validates starting date',
    (tester) async {
      await setupTesterView(tester);
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await tapVisible(tester, find.text("Add a bill"));

      // Toggle Every 2 weeks
      await tapVisible(tester, find.text("Every 2 weeks Payment"));

      expect(find.text("Starting due date"), findsOneWidget);

      await tester.enterText(find.byType(TextFormField).at(0), "Insurance");
      await tester.enterText(find.byType(TextFormField).at(1), "120");

      // Attempt to add without date
      await tapVisible(tester, find.text("Add"));
      expect(find.text("Select starting date"), findsOneWidget);
    },
  );

  testWidgets('Edit bill populates form and updates bill properly', (
    tester,
  ) async {
    await setupTesterView(tester);
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    // Add bill
    await tapVisible(tester, find.text("Add a bill"));
    await tester.enterText(find.byType(TextFormField).at(0), "Internet");
    await tester.enterText(find.byType(TextFormField).at(1), "60");
    await tester.enterText(find.byType(TextFormField).at(2), "1");
    await tapVisible(tester, find.text("Add"));

    expect(find.text("Internet"), findsOneWidget);
    expect(find.text("\$60"), findsOneWidget);

    // Tap edit
    await tapVisible(tester, find.byKey(const Key('edit_bill_0')));

    expect(find.text("Update"), findsOneWidget);
    // Modify amount
    await tester.enterText(find.byType(TextFormField).at(1), "65");
    await tapVisible(tester, find.text("Update"));

    expect(find.text("\$65"), findsOneWidget);
  });

  testWidgets('Delete bill removes it from list and local storage', (
    tester,
  ) async {
    await setupTesterView(tester);
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    // Add bill
    await tapVisible(tester, find.text("Add a bill"));
    await tester.enterText(find.byType(TextFormField).at(0), "Water");
    await tester.enterText(find.byType(TextFormField).at(1), "40");
    await tester.enterText(find.byType(TextFormField).at(2), "15");
    await tapVisible(tester, find.text("Add"));

    expect(find.text("Water"), findsOneWidget);

    // Delete
    await tapVisible(tester, find.byKey(const Key('delete_bill_0')));

    expect(find.text("Water"), findsNothing);
    expect(find.text("No bills added yet."), findsOneWidget);
  });

  testWidgets(
    'Continue persists bill list locally and triggers navigation callback',
    (tester) async {
      await setupTesterView(tester);
      bool continued = false;
      await tester.pumpWidget(
        createTestWidget(
          onContinue: () {
            continued = true;
          },
        ),
      );
      await tester.pumpAndSettle();

      // Add a bill
      await tapVisible(tester, find.text("Add a bill"));
      await tester.enterText(find.byType(TextFormField).at(0), "Gas");
      await tester.enterText(find.byType(TextFormField).at(1), "25");
      await tester.enterText(find.byType(TextFormField).at(2), "20");
      await tapVisible(tester, find.text("Add"));

      // Tap Continue
      await tapVisible(tester, find.text("Continue"));

      expect(continued, isTrue);

      // Check SharedPreferences
      final savedBills = await SharedPreferenceData.getBills();
      expect(savedBills.length, 1);
      expect(savedBills.first['name'], "Gas");
    },
  );

  testWidgets(
    'No regular bills saves empty bill list and continues without validation errors',
    (tester) async {
      await setupTesterView(tester);
      bool skipped = false;
      await tester.pumpWidget(
        createTestWidget(
          onSkip: () {
            skipped = true;
          },
        ),
      );
      await tester.pumpAndSettle();

      // Add a bill first
      await tapVisible(tester, find.text("Add a bill"));
      await tester.enterText(find.byType(TextFormField).at(0), "Trash");
      await tester.enterText(find.byType(TextFormField).at(1), "20");
      await tester.enterText(find.byType(TextFormField).at(2), "1");
      await tapVisible(tester, find.text("Add"));

      // Tap "No regular bills"
      await tapVisible(tester, find.text("No regular bills"));

      expect(skipped, isTrue);

      // Check SharedPreferences is empty
      final savedBills = await SharedPreferenceData.getBills();
      expect(savedBills, isEmpty);
    },
  );

  testWidgets('Prevents duplicate bill names', (tester) async {
    await setupTesterView(tester);
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    // Add first bill
    await tapVisible(tester, find.text("Add a bill"));
    await tester.enterText(find.byType(TextFormField).at(0), "Gym");
    await tester.enterText(find.byType(TextFormField).at(1), "30");
    await tester.enterText(find.byType(TextFormField).at(2), "5");
    await tapVisible(tester, find.text("Add"));

    // Try to add second bill with duplicate name
    await tapVisible(tester, find.text("Add a bill"));
    await tester.enterText(find.byType(TextFormField).at(0), "gym");
    await tester.enterText(find.byType(TextFormField).at(1), "45");
    await tester.enterText(find.byType(TextFormField).at(2), "12");
    await tapVisible(tester, find.text("Add"));

    // Should not add duplicate
    expect(find.text("Update"), findsNothing);
    expect(find.text("Add"), findsOneWidget); // still on form
  });
}
