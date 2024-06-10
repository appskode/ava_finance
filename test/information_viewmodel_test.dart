import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:ava_finance/models/user.dart';
import 'package:ava_finance/viewmodels/user_viewmodel.dart';
import 'package:ava_finance/viewmodels/information_viewmodel.dart';

void main() {
  group('InformationViewModel', () {
    late ProviderContainer container;
    late User testUser;
    late StateNotifierProvider<UserViewModel, User?> overrideUserProvider;

    setUp(() {
      testUser = User(
        employmentType: "Full time",
        employe: "Test Employer",
        jobTitle: "Software Engineer",
        annualIncome: "100000",
        payFrequency: "Monthly",
        address: "123 Test St",
        payDate: DateTime(2023, 6, 15),
        years: "2 years",
        months: "3 months",
        payType: true,
      );

      container = ProviderContainer(
        overrides: [
          userProvider.overrideWith((ref) {
            var vm = UserViewModel();
            vm.setUser(testUser);
            return vm;
          }),
        ],
      );
    });

    test('initial state', () {
      final viewModel = container.read(informationViewModel);

      expect(viewModel.employmentType.text, "Full time");
      expect(viewModel.employer.text, "Test Employer");
      expect(viewModel.jobTitle.text, "Software Engineer");
      expect(viewModel.grossAnnualIncome.text, "100000");
      expect(viewModel.payFrequency.text, "Monthly");
      expect(viewModel.employerAddress.text, "123 Test St");
      expect(viewModel.timeWithEmployer.text, "2 years 3 months ");
      expect(viewModel.nextPayDate.text, "Jun 15 ,2023(Thursday)");
      expect(viewModel.payType.text, "true");
      expect(viewModel.isDirectDeposit, true);
      expect(viewModel.years, "2 years");
      expect(viewModel.months, "3 months");
    });

    test('enableEdit and disableEdit toggle isEditing', () {
      final viewModel = container.read(informationViewModel);

      expect(viewModel.isEditing, false);

      viewModel.enableEdit();
      expect(viewModel.isEditing, true);

      viewModel.disableEdit();
      expect(viewModel.isEditing, false);
    });

    test('changeDirectDeposit updates isDirectDeposit', () {
      final viewModel = container.read(informationViewModel);

      viewModel.changeDirectDeposit(false);
      expect(viewModel.isDirectDeposit, false);

      viewModel.changeDirectDeposit(true);
      expect(viewModel.isDirectDeposit, true);
    });

    test('onYearChanged updates years', () {
      final viewModel = container.read(informationViewModel);

      viewModel.onYearChanged("4 years");
      expect(viewModel.years, "4 years");
    });

    test('onMonthsChanged updates months', () {
      final viewModel = container.read(informationViewModel);

      viewModel.onMonthsChanged("5 months");
      expect(viewModel.months, "5 months");
    });

    test('onPayFrequencyChanged updates payFrequency', () {
      final viewModel = container.read(informationViewModel);

      viewModel.onPayFrequencyChanged("Weekly");
      expect(viewModel.payFrequency.text, "Weekly");
    });

    test('onEmploymentChanged updates employmentType', () {
      final viewModel = container.read(informationViewModel);

      viewModel.onEmploymentChanged("Self employed");
      expect(viewModel.employmentType.text, "Self employed");
    });
  });
}
