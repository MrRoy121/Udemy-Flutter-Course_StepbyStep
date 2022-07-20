import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
   Color _bgcolor;

  @override
  void initState() {
    const color = [Colors.red,Colors.blue,Colors.grey,Colors.green,Colors.yellow,Colors.orange,Colors.purple];

    _bgcolor = color[Random().nextInt(7)];

  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListTile(
        leading: Padding(
          padding: EdgeInsets.all(5),
          child: FittedBox(
            child: CircleAvatar(
              backgroundColor: _bgcolor,
              radius: 30,
              child: Container(
                child: Text(
                  '\$${widget.transaction.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black45,
          ),
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
          style: TextStyle(
              fontSize: 16, color: Theme.of(context).accentColor),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
          onPressed: () => widget.deleteTx(widget.transaction.id),
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).errorColor,
          ),
          label: Text("Delete",style:  TextStyle(
            fontSize: 16, color: Theme.of(context).errorColor,),
          ),
        )
            : IconButton(
          onPressed: () => widget.deleteTx(widget.transaction.id),
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).errorColor,
          ),
        ),
      ),
    );
  }
}
