import 'package:flutter/material.dart';
import 'package:guide_flutter/widgets/transactionItem.dart';
import 'package:intl/intl.dart';

import '/model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;
  TransactionList(this.transaction, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder(builder: ((ctx, constaints) {
            return Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  "No Transactions Added Yet!",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: constaints.maxHeight * 0.6,
                  child: Image(
                    image: AssetImage("assets/images/waiting.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          }))
        : ListView(
            children: transaction
                .map((e) => TransactionItem(
                    key: ValueKey(e.id), transaction: e, deleteTx: deleteTx))
                .toList(),
          );
    // .builder(
    //     itemBuilder: (ctx, i) {
    //       return TransactionItem(transaction: transaction[i], deleteTx: deleteTx);
    //   Card(
    //   child: Row(
    //     children: [
    //       Container(
    //         margin:
    //             EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    //         padding: EdgeInsets.all(10),
    //         decoration: BoxDecoration(
    //             border: Border.all(
    //                 color: Theme.of(context).primaryColor,
    //                 width: 2)),
    //         child: Text(
    //           '\$${transaction[i].amount.toStringAsFixed(2)}',
    //           style: TextStyle(
    //             fontSize: 24,
    //             fontWeight: FontWeight.bold,
    //             color: Theme.of(context).primaryColor,
    //           ),
    //         ),
    //       ),
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(transaction[i].title,
    //               style: Theme.of(context).textTheme.headline6),
    //           Text(
    //             DateFormat.yMMMd().format(transaction[i].date),
    //             style: TextStyle(
    //                 fontSize: 16,
    //                 color: Theme.of(context).accentColor),
    //           ),
    //         ],
    //       )
    //     ],
    //   ),
    // );
    //   },
    //   itemCount: transaction.length,
    // );
  }
}
