import 'package:gst_search/view/screen/home_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('empty search', () {
    var result = InputValidationMixin.isGSTINValid('');
    expect(result, false);
  });

  test('invalid gstin search', () {
    var result = InputValidationMixin.isGSTINValid('abcdefsfd');
    expect(result, false);
  });

  test('valid gstin search', () {
    var result = InputValidationMixin.isGSTINValid('29AAACC1206D2ZB');
    expect(result, true);
  });
}
