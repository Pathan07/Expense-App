import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addtx;

  const NewTransactions(this.addtx, {Key? key}) : super(key: key);

  @override
  State<NewTransactions> createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime? selectedDate = DateTime.now();

  void submitTransaction(BuildContext context) {
    if (amountController.text.isEmpty) {}
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }
    widget.addtx(
      enteredTitle,
      enteredAmount,
      selectedDate,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Transaction added successfully',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    Navigator.of(context).pop();
  }

  void datePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
              // onSubmitted: (_) => submitTransaction,
            ),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: "Amount"),
              // onSubmitted: (_) => submitTransaction,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(selectedDate == null
                      ? "No Date Chosen!"
                      : 'Picked Date ${DateFormat.yMd().format(selectedDate!).toString()}'),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, right: 10),
                  child: TextButton(
                    onPressed: () => datePicker(context),
                    child: const Text(
                      "Choose Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: ElevatedButton(
                child: const Text(
                  "Add Transaction",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  submitTransaction(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
