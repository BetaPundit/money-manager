import 'package:flutter/material.dart';
import 'package:money_manager/models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({
    Key key,
    this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: Theme.of(context).accentColor,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(
              transaction.isDebit ? Icons.call_made : Icons.call_received,
            ),
          ),
          title: Text(
            transaction.isDebit ? 'Paid to' : 'Received from',
          ),
          subtitle: Text('${transaction.receiverId}'),
          trailing: transaction.isDebit
              ? Text(
                  '- ₹ ${transaction.amount}',
                  style: TextStyle(
                    color: Colors.red[600],
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : Text(
                  '+ ₹ ${transaction.amount}',
                  style: TextStyle(
                    color: Colors.green[600],
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }
}
