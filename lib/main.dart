import 'package:flutter/material.dart';
import 'package:money_manager/providers/transactions_provider.dart';
import 'package:money_manager/providers/user_provider.dart';
import 'package:money_manager/screens/home_screen.dart';
import 'package:money_manager/screens/payment_screen.dart';
import 'package:money_manager/screens/transaction_history_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TransactionsProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF4666c7),
          accentColor: Color(0xFFF1F1F1),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
        routes: <String, WidgetBuilder>{
          HomeScreen.routeName: (context) => HomeScreen(),
          TransactionHistoryScreen.routeName: (context) =>
              TransactionHistoryScreen(),
          PaymentScreen.routeName: (context) => PaymentScreen(),
        },
      ),
    );
  }
}
