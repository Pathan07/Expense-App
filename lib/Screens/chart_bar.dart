import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double totalSpending;

  const ChartBar(this.label, this.spendingAmount, this.totalSpending,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: constraint.maxHeight * 0.1,
              child: FittedBox(
                child: Text("\$${spendingAmount.toStringAsFixed(0)}"),
              ),
            ),
             SizedBox(
              height: constraint.maxHeight * 0.05,
            ),
            SizedBox(
              height: constraint.maxHeight * 0.65,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: totalSpending,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: constraint.maxHeight * 0.05,
            ),
            SizedBox(
              height: constraint.maxHeight * 0.15,
                child: Text(label),
            ),
          ],
        );
      },
    );
  }
}
