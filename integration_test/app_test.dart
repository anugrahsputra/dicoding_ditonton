import 'package:ditonton/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  group('App Testing', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('Tv Test', (widgetTest) async {
      await binding.traceAction(() async {
        int tvIndex = 10;
        final tvSeriesMenu = find.byKey(Key('tv_series'));
        final scrollFinder = find.byType(Scrollable);
        final tvFinder = find.byKey(Key('tv_$tvIndex'));
        final backbuttonFinder = find.byIcon(Icons.arrow_back);
        final addWatchlistbuttonFinder = find.byIcon(Icons.add);
        final checkWatchlistbuttonFinder = find.byIcon(Icons.check);

        app.main();
        await widgetTest.pumpAndSettle();

        // Open Drawer
        await widgetTest.tap(find.byIcon(Icons.menu));
        await widgetTest.pumpAndSettle();

        // Tap TV Series
        await widgetTest.tap(tvSeriesMenu);
        await widgetTest.pumpAndSettle();

        // Search TV Series
        await widgetTest.tap(find.byIcon(Icons.search));
        await widgetTest.pumpAndSettle();
        expect(find.byType(TextField), findsOneWidget);
        await widgetTest.enterText(find.byType(TextField), 'chain');
        await widgetTest.testTextInput.receiveAction(TextInputAction.done);
        await widgetTest.pumpAndSettle();

        // Scroll to TV Series
        await widgetTest.scrollUntilVisible(tvFinder, 500,
            scrollable: scrollFinder.last);
        expect(tvFinder, findsOneWidget);

        // Tap TV Series
        await widgetTest.tap(tvFinder); // tv_10
        await widgetTest.pumpAndSettle();

        // Tap Watchlist Button
        await widgetTest.tap(addWatchlistbuttonFinder);
        await widgetTest.pumpAndSettle();
        expect(checkWatchlistbuttonFinder, findsOneWidget);

        // Tap Back Button
        await widgetTest.tap(backbuttonFinder);
        await widgetTest.pumpAndSettle();
        await widgetTest.tap(backbuttonFinder);
        await widgetTest.pumpAndSettle();

        // Tap Popular TV Series
        await widgetTest.tap(find.byKey(Key('popular_tv')));
        await widgetTest.pumpAndSettle();

        // Scroll Popular TV Series
        await widgetTest.scrollUntilVisible(tvFinder, 200,
            scrollable: scrollFinder);
        await widgetTest.pumpAndSettle();
        expect(tvFinder, findsOneWidget);
        await widgetTest.tap(tvFinder); // tv_10
        await widgetTest.pumpAndSettle();

        // Add Watchlist Button
        await widgetTest.tap(addWatchlistbuttonFinder);
        expect(addWatchlistbuttonFinder, findsOneWidget);
        await widgetTest.pump(Duration(seconds: 3));
        expect(find.byType(SnackBar), findsOneWidget);

        // Remove Watchlist Button
        await widgetTest.tap(checkWatchlistbuttonFinder);
        expect(checkWatchlistbuttonFinder, findsOneWidget);
        await widgetTest.pump(Duration(seconds: 1));
        expect(find.byType(SnackBar), findsOneWidget);

        // Tap Back Button
        // await widgetTest.tap(backbuttonFinder);
        // await widgetTest.pumpAndSettle();
        // await widgetTest.tap(backbuttonFinder);
        // await widgetTest.pumpAndSettle();
      });
    });
  });
}
