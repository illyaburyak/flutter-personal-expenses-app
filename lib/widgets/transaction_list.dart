import 'package:flutter/material.dart';
import 'package:flutter_personal_expenses_app/models/transaction.dart';

import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  'No transaction added yet!',
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWRQezMDbnfbw0nPcEnGOyCu1sguIDbpbVZQ&usqp=CAU',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text('\$${transactions[index].amount}')),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 360
                      ? FlatButton.icon(
                          onPressed: () => deleteTx(transactions[index].id),
                          textColor: Colors.red,
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () => deleteTx(transactions[index].id),
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
