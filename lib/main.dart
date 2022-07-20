import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guide_flutter/widgets/chart.dart';
import 'package:guide_flutter/widgets/newTransaction.dart';
import 'package:guide_flutter/widgets/transaction_list.dart';

import 'model/transaction.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: "Quicksand",
        appBarTheme: AppBarTheme(
          toolbarTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              )
              .bodyText2,
          titleTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              )
              .headline6,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transaction = [
    //Transaction(id: "i1", title: "Biscuit", amount: 9.88, date: DateTime.now()),
    //Transaction(id: "i2", title: "Mango", amount: 5.58, date: DateTime.now()),
  ];
  bool _switchVal = false;

  void _addTransaction(String title, double amount, DateTime date) {
    setState(() {
      _transaction.add(new Transaction(
          id: DateTime.now().toString(),
          title: title,
          amount: amount,
          date: date));
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transaction.removeWhere((element) => element.id == id);
    });
  }

  void _addTransactionWindow(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bcx) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  List<Transaction> get _recentTransaction {
    return _transaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final isLandscape = mq.orientation == Orientation.landscape;
    final PreferredSizeWidget appbars = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              "Expenses",
              style: TextStyle(color: Colors.black),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => _addTransactionWindow(context),
                  child: Icon(CupertinoIcons.add),
                )
              ],
            ),
          )
        : AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _addTransactionWindow(context),
              ),
            ],
            title: Text(
              "Expenses",
              style: TextStyle(color: Colors.black),
            ),
          );
    final txList = Container(
        height:
            (mq.size.height - appbars.preferredSize.height - mq.padding.top) *
                0.6,
        child: TransactionList(_transaction, _deleteTransaction));
    final bodys = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Show Chart",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Switch.adaptive(
                      activeColor: Theme.of(context).primaryColor,
                      value: _switchVal,
                      onChanged: (val) {
                        setState(() {
                          _switchVal = val;
                        });
                      })
                ],
              ),
            if (!isLandscape)
              Container(
                width: double.infinity,
                height: (mq.size.height -
                        appbars.preferredSize.height -
                        mq.padding.top) *
                    0.35,
                child: Chart(_recentTransaction),
              ),
            txList,
            if (isLandscape)
              _switchVal
                  ? Container(
                      width: double.infinity,
                      height: (mq.size.height -
                              appbars.preferredSize.height -
                              mq.padding.top) *
                          0.7,
                      child: Chart(_recentTransaction),
                    )
                  : txList,
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: bodys,
            navigationBar: appbars,
          )
        : Scaffold(
            appBar: appbars,
            body: bodys,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _addTransactionWindow(context),
                  ),
          );
  }
}
