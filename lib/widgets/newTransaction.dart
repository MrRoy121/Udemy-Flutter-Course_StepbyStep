import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  Function addTransaction;
  NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _pickeddate;

  void submitTxt() {
    final String text = _titleController.text;
    final double amount = double.parse(_amountController.text);
    if (text == null || amount < 0 || amount == null || _pickeddate == null) {
      return;
    }
    widget.addTransaction(text, amount, _pickeddate);
    Navigator.of(context).pop();
  }

  void _pickadate(){
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2022), lastDate: DateTime.now()).then((value) {
      if(value==null){
        return;
      }
      setState((){
        _pickeddate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Title",
              ),
              controller: _titleController,
              onSubmitted: (_) => submitTxt,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Amount",
              ),
              controller: _amountController,
              onSubmitted: (_) => submitTxt,
            ),
            Container(
              height: 70,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( _pickeddate==null ?
                    "No Date Selected": DateFormat.yMMMd().format(_pickeddate),
                  ),
                  IconButton(
                    onPressed: () {_pickadate();},
                    icon: Icon(Icons.calendar_month, color: Theme.of(context).primaryColor,),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: ElevatedButton(
                  onPressed: () {
                    submitTxt();
                  },
                  child: Text(
                    "Add Transaction",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
