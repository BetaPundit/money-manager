import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/models/user.dart';
import 'package:money_manager/providers/user_provider.dart';
import 'package:money_manager/utils/column_builder.dart';
import 'package:money_manager/widgets/transaction_card.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TransactionHistoryScreen extends StatefulWidget {
  static const routeName = '/transaction-history-screen';

  @override
  _TransactionHistoryScreenState createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  double _opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    User _user = Provider.of<UserProvider>(
      context,
      listen: false,
    ).getUserDetails();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // App Bar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: AppBar(
            leading: IconButton(
              icon: Icon(
                CupertinoIcons.back,
                color: Colors.white,
                semanticLabel: 'Back',
              ),
              iconSize: 38,
              tooltip: 'Back',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Transactions List',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 26,
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
          ),
        ),
      ),

      // Body
      body: LayoutBuilder(
        builder: (context, constraints) => SafeArea(
          child: Stack(
            children: [
              // Sliding Up Panel
              SlidingUpPanel(
                minHeight: constraints.biggest.height * 0.7,
                maxHeight: constraints.biggest.height,
                color: Colors.white,
                onPanelSlide: (value) {
                  setState(() {
                    _opacity = value;
                  });
                },
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(26),
                  topRight: Radius.circular(26),
                ),
                panelBuilder: (sc) => Container(
                  padding: const EdgeInsets.all(22.0),
                  child: ListView.builder(
                    controller: sc,
                    itemCount: _user.transactions.length,
                    itemBuilder: (context, index) => TransactionCard(
                      transaction: _user
                          .transactions[_user.transactions.length - index - 1],
                    ),
                  ),
                ),
              ),

              // Header Image
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 56.0,
                  ),
                  alignment: Alignment.bottomCenter,
                  height: constraints.biggest.height * 0.29 * (1 - _opacity),
                  width: constraints.biggest.width * (1 - _opacity),
                  child: Opacity(
                    opacity: (1 - _opacity * 1.5).clamp(0.0, 1.0),
                    child: Image.asset('assets/images/header1.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
