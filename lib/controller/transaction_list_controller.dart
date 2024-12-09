import 'package:expense_app/model/transactions_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionListController extends StateNotifier<List<TransactionsModel>> {
  TransactionListController() : super([]);

  void addRecord(String title, double amount, DateTime date) {
    final transaction = TransactionsModel(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );
    state = [...state, transaction];
  }

  void deleteTransaction(String id) {
  final remainingTransactions = state.where((trans) => trans.id != id).toList();
  state = remainingTransactions;
  }
}

final transactionProvider =
    StateNotifierProvider<TransactionListController, List<TransactionsModel>>(
  (ref) => TransactionListController(),
);
