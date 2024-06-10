import 'package:ava_finance/models/account_detail.dart';
import 'package:ava_finance/viewmodels/account_info_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AccountInfoViewModel', () {
    test('initial state', () {
      final container = ProviderContainer();
      final accountInfo = container.read(accountInfoProvider);

      expect(accountInfo, isNotNull);
      expect(accountInfo?.spendBalance, 75);
      expect(accountInfo?.creditBalance, 30);
      expect(accountInfo?.creditLimit, 600);
      expect(accountInfo?.totalBalance, 8300);
      expect(accountInfo?.totalLimit, 200900);
      expect(accountInfo?.spendLimit, 100);
      expect(accountInfo?.creditCard.length, 3);
    });

    test('updateCreditScore updates state', () {
      final container = ProviderContainer();
      final viewModel = container.read(accountInfoProvider.notifier);

      final newAccountInfo = AccountInfo(
        spendBalance: 100,
        creditBalance: 50,
        creditLimit: 1000,
        totalBalance: 9000,
        totalLimit: 210000,
        spendLimit: 150,
        creditCard: [
          OpenCreditCard(
            name: "Syncb/NewCard",
            balance: 2000,
            limit: 8000,
            reportedOn: DateTime(2023, 6, 21),
          ),
        ],
      );

      viewModel.updateCreditScore(newAccountInfo);

      final updatedAccountInfo = container.read(accountInfoProvider);

      expect(updatedAccountInfo?.spendBalance, 100);
      expect(updatedAccountInfo?.creditBalance, 50);
      expect(updatedAccountInfo?.creditLimit, 1000);
      expect(updatedAccountInfo?.totalBalance, 9000);
      expect(updatedAccountInfo?.totalLimit, 210000);
      expect(updatedAccountInfo?.spendLimit, 150);
      expect(updatedAccountInfo?.creditCard.length, 1);
      expect(updatedAccountInfo?.creditCard[0].name, "Syncb/NewCard");
    });
  });
}
