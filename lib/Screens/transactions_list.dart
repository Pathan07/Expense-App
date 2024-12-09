import 'package:expense_app/model/transactions_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionsModel> transaction;
  final void Function(String id) deleteTransaction;

  const TransactionList(this.transaction, this.deleteTransaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10.0),
                child: Text(
                  "No transaction added Yet",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 200,
                child: Image.asset(
                  "assets/images/waiting.png",
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        : Consumer(
            builder: (context, ref, child) {
              return ListView.builder(
                itemCount: transaction.length,
                itemBuilder: (context, index) {
                  final cardData = transaction[index];
                  return Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: Card(
                      elevation: 10,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 30.00,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: FittedBox(
                              child: Text(
                                "\$${cardData.amount!.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        title: Text(cardData.title!,
                            style: Theme.of(context).textTheme.titleMedium),
                        subtitle: Text(
                          DateFormat().add_yMMMd().format(cardData.date!),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                           deleteTransaction(cardData.id!);
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
  }
}
