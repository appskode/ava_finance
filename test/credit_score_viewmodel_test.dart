import 'package:ava_finance/models/CreditScore.dart';
import 'package:ava_finance/viewmodels/credit_score_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  group('CreditScoreViewModel', () {
    test('initial state', () {
      final container = ProviderContainer();
      final creditScore = container.read(creditScoreProvider);

      expect(creditScore, isNotNull);
      expect(creditScore?.score, 720);
      expect(creditScore?.totalScore, 1000);
      expect(creditScore?.status, "Good");
      expect(creditScore?.pointsChange, 1000);
      expect(creditScore?.monthScores.length, 12);
      expect(creditScore?.monthScores[0].score, 610);
      expect(creditScore?.monthScores[11].score, 700);
    });

    test('updateCreditScore updates state', () {
      final container = ProviderContainer();
      final viewModel = container.read(creditScoreProvider.notifier);

      final newCreditScore = CreditScore(
        score: 800,
        totalScore: 1000,
        status: "Excellent",
        pointsChange: 80,
        lastUpdated: DateTime.now(),
        monthScores: [
          Month(monthNumber: 0, score: 700),
          Month(monthNumber: 1, score: 710),
          Month(monthNumber: 2, score: 720),
          Month(monthNumber: 3, score: 730),
          Month(monthNumber: 4, score: 740),
          Month(monthNumber: 5, score: 750),
          Month(monthNumber: 6, score: 760),
          Month(monthNumber: 7, score: 770),
          Month(monthNumber: 8, score: 780),
          Month(monthNumber: 9, score: 790),
          Month(monthNumber: 10, score: 800),
          Month(monthNumber: 11, score: 810),
        ],
      );

      viewModel.updateCreditScore(newCreditScore);

      final updatedCreditScore = container.read(creditScoreProvider);

      expect(updatedCreditScore?.score, 800);
      expect(updatedCreditScore?.totalScore, 1000);
      expect(updatedCreditScore?.status, "Excellent");
      expect(updatedCreditScore?.pointsChange, 80);
      expect(updatedCreditScore?.monthScores.length, 12);
      expect(updatedCreditScore?.monthScores[0].score, 700);
      expect(updatedCreditScore?.monthScores[11].score, 810);
    });
  });
}
