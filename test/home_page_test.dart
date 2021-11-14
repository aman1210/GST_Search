import 'package:flutter/material.dart';
import 'package:gst_search/presenter/profile_presenter.dart';
import 'package:gst_search/view/screen/home_page.dart';

import 'package:gst_search/view/screen/home_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockSearch extends Mock implements ProfilePresenter {}

void main() {
  Widget makeTestableWidget({required Widget child}) {
    return ChangeNotifierProvider(
      create: (context) => ProfilePresenter(),
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets("Search field smoke test", (WidgetTester tester) async {
    MockSearch mockSearch = MockSearch();
    HomePage page = HomePage();
    await tester.pumpWidget(makeTestableWidget(child: page));
    expect(find.byWidget(CircularProgressIndicator()), findsNothing);
    expect(find.byType(TextFormField), findsOneWidget);

    Finder search = find.byType(TextFormField);
    await tester.enterText(search, 'hello');

    await tester.tap(find.byKey(Key('searchButton')));
  });
}
