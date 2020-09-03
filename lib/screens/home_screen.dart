import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:money_manager/models/user.dart';
import 'package:money_manager/providers/user_provider.dart';
import 'package:money_manager/screens/payment_screen.dart';
import 'package:money_manager/screens/transaction_history_screen.dart';
import 'package:money_manager/widgets/transaction_card.dart';
import 'package:money_manager/widgets/reward_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    User _user = Provider.of<UserProvider>(
      context,
    ).getUserDetails();

    return Scaffold(
      body: Column(
        children: [
          // Header Card
          Expanded(
            child: Card(
              margin: const EdgeInsets.all(0.0),
              color: Theme.of(context).primaryColor,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32.0),
                  bottomRight: Radius.circular(32.0),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 32.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Hello XYZ!',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    // Available Balance
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '₹ ',
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _user.accountBalance.toStringAsFixed(2),
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 58,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          Text(
                            'Available in your account!',
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                          ),
                        ],
                      ),
                    ),

                    // Reward Card
                    Expanded(
                      flex: 3,
                      child: RewardCard(),
                    )
                  ],
                ),
              ),
            ),
          ),

          // Body Container
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Text(
                      'Recent Transactions',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                TransactionCard(
                  transaction:
                      _user.transactions[_user.transactions.length - 1],
                ),
                TransactionCard(
                  transaction:
                      _user.transactions[_user.transactions.length - 2],
                ),
                FlatButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        'Show More',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(TransactionHistoryScreen.routeName);
                  },
                ),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ],
      ),

      // New Payment Button
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        child: FloatingActionButton.extended(
          icon: Icon(
            Icons.add,
            color: Theme.of(context).accentColor,
          ),
          label: Text(
            'New Payment',
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.of(context).pushNamed(PaymentScreen.routeName);
          },
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
