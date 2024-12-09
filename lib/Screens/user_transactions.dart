import 'package:expense_app/Screens/transactions_list.dart';
import 'package:expense_app/controller/transaction_list_controller.dart';
import 'package:expense_app/model/transactions_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'chart.dart';
import 'new_transactions.dart';

class UserTransactions extends ConsumerStatefulWidget {
  const UserTransactions({super.key});

  @override
  ConsumerState<UserTransactions> createState() => UserTransactionsState();
}

class UserTransactionsState extends ConsumerState<UserTransactions> {
  List<TransactionsModel> get recentTransactions {
    // Access state from Riverpod
    final transactions = ref.watch(transactionProvider);
    return transactions.where((tx) {
      return tx.date!.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  _addNewTransaction(String txtitle, double txamount, DateTime date) {
    final tx = TransactionsModel(
        id: DateTime.now().toString(),
        title: txtitle,
        amount: txamount,
        date: date);
    ref.read(transactionProvider.notifier).addRecord(
          tx.title!,
          tx.amount!,
          tx.date!,
        );
  }

  void addNewTransactions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewTransactions(_addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    ref.read(transactionProvider.notifier).deleteTransaction(id);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: const Text("Personal Expenses"),
      actions: <Widget>[
        IconButton(
          onPressed: () => addNewTransactions(context),
          icon: const Icon(
            Icons.add,
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.3,
              child: Chart(recentTransactions),
            ),
            SizedBox(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: TransactionList(
                ref.watch(transactionProvider),
                _deleteTransaction,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addNewTransactions(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
