import 'dart:convert';

import 'package:ava_finance/models/user.dart';
import 'package:ava_finance/utils/constants.dart';
import 'package:ava_finance/viewmodels/user_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('UserViewModel', () {
    late ProviderContainer container;
    late SharedPreferences sharedPreferences;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      sharedPreferences = await SharedPreferences.getInstance();
      ConstantsHelper.sp = sharedPreferences;

      container = ProviderContainer();
    });

    test('initial state when no user in shared preferences', () {
      final viewModel = container.read(userProvider.notifier);
      final user = container.read(userProvider);

      expect(user?.employmentType, "Full time");
      expect(user?.employe, "Apple Inc");
      expect(user?.jobTitle, "Software engineer");
      expect(user?.annualIncome, "\$1500,000/year");
      expect(user?.payFrequency, "Bi-weekly");
      expect(user?.address, "Apple one apple park");
      expect(user?.payDate, DateTime(2021, 10, 10));
      expect(user?.years, "1 years");
      expect(user?.months, "1 months");
      expect(user?.payType, false);
    });

    test('initial state when user is present in shared preferences', () async {
      final testUser = User(
        employmentType: "Part time",
        employe: "Google",
        jobTitle: "Product Manager",
        annualIncome: "\$2000,000/year",
        payFrequency: "Monthly",
        address: "Googleplex",
        payDate: DateTime(2022, 11, 11),
        years: "2 years",
        months: "2 months",
        payType: true,
      );
      await sharedPreferences.setString('user', jsonEncode(testUser.toJson()));

      final viewModel = container.read(userProvider.notifier);
      final user = container.read(userProvider);

      expect(user?.employmentType, "Part time");
      expect(user?.employe, "Google");
      expect(user?.jobTitle, "Product Manager");
      expect(user?.annualIncome, "\$2000,000/year");
      expect(user?.payFrequency, "Monthly");
      expect(user?.address, "Googleplex");
      expect(user?.payDate, DateTime(2022, 11, 11));
      expect(user?.years, "2 years");
      expect(user?.months, "2 months");
      expect(user?.payType, true);
    });

    test('setUser updates the user state', () async {
      final viewModel = container.read(userProvider.notifier);
      final newUser = User(
        employmentType: "Contractor",
        employe: "Amazon",
        jobTitle: "DevOps Engineer",
        annualIncome: "\$3000,000/year",
        payFrequency: "Weekly",
        address: "Amazon HQ",
        payDate: DateTime(2023, 12, 12),
        years: "3 years",
        months: "3 months",
        payType: true,
      );

      viewModel.setUser(newUser);
      final user = container.read(userProvider);

      expect(user?.employmentType, "Contractor");
      expect(user?.employe, "Amazon");
      expect(user?.jobTitle, "DevOps Engineer");
      expect(user?.annualIncome, "\$3000,000/year");
      expect(user?.payFrequency, "Weekly");
      expect(user?.address, "Amazon HQ");
      expect(user?.payDate, DateTime(2023, 12, 12));
      expect(user?.years, "3 years");
      expect(user?.months, "3 months");
      expect(user?.payType, true);
    });
  });
}
