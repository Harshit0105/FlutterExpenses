import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _deleteTransaction;

  TransactionList(this._userTransactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    "No transaction added yet!",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                          child: Text(
                              '\u20B9  ${_userTransactions[index].amount}')),
                    ),
                    radius: 30,
                  ),
                  title: Text(
                    _userTransactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(_userTransactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 450
                      ? FlatButton.icon(
                          onPressed: () =>
                              _deleteTransaction(_userTransactions[index].id),
                          icon: Icon(
                            Icons.delete,
                          ),
                          label: Text("Delete"),
                          textColor: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          onPressed: () =>
                              _deleteTransaction(_userTransactions[index].id),
                          color: Theme.of(context).errorColor,
                          icon: Icon(
                            Icons.delete,
                          ),
                        ),
                ),
              );
            },
            itemCount: _userTransactions.length,
          );
  }
}
