import 'package:flutter/material.dart';

class ChartItem extends StatelessWidget {
  String label;
  double amount, percentage;
  ChartItem(this.label, this.amount, this.percentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((ctx, constraints) {
      return Column(
        children: [
          Container(
            height: constraints.maxHeight * 0.1,
            child: FittedBox(
              child: Text(
                "\$${amount.toStringAsFixed(0)}",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.03,
          ),
          Container(
            height: constraints.maxHeight * 0.7,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
              height: constraints.maxHeight * 0.1,
              child: FittedBox(child: Text(label))),
        ],
      );
    }));
  }
}
