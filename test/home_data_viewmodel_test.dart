import 'package:ava_finance/viewmodels/home_data_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:ava_finance/utils/color_constants.dart';

void main() {
  group('HomeDataViewModel', () {
    test('initial state', () {
      final container = ProviderContainer();
      final homeDataViewModel = container.read(homeDataProvider);

      expect(homeDataViewModel.creditFactorList.length, 3);

      final paymentHistory = homeDataViewModel.creditFactorList[0];
      expect(paymentHistory.title, "Payment History");
      expect(paymentHistory.value, "100%");
      expect(paymentHistory.color, ColorConstants.buttonColor1);
      expect(paymentHistory.buttonText, "High Impact");

      final creditCardUtilization = homeDataViewModel.creditFactorList[1];
      expect(creditCardUtilization.title, "Credit Card Utilization");
      expect(creditCardUtilization.value, "4%");
      expect(creditCardUtilization.color, ColorConstants.secondary2Color);
      expect(creditCardUtilization.buttonText, "Low Impact");

      final derogatoryMarks = homeDataViewModel.creditFactorList[2];
      expect(derogatoryMarks.title, "Derogatory Marks");
      expect(derogatoryMarks.value, "2");
      expect(derogatoryMarks.color, ColorConstants.secondaryColor);
      expect(derogatoryMarks.buttonText, "Med Impact");
    });
  });
}
