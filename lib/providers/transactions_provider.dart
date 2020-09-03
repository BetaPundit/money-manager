import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:money_manager/models/transaction.dart';

class TransactionsProvider with ChangeNotifier {
  Transaction payMoney(
    double amount,
    double accountBalance,
    String description,
    int receiverId,
  ) {
    if (accountBalance < amount) {
      throw Exception("Not enough balance");
    } else {
      Random random = Random();
      bool isSuccessful = random.nextBool();

      if (isSuccessful) {
        notifyListeners();
        return Transaction(
          random.nextInt(100).toString(),
          amount,
          receiverId,
          true,
        );
      } else {
        throw Exception("Pay money was unsuccessful");
      }
    }
  }

  Transaction requestMoney(double amount, String description, int senderId) {
    Random random = Random();
    bool isSuccessful = random.nextBool();
    if (isSuccessful) {
      notifyListeners();
      return Transaction(
        random.nextInt(100).toString(),
        amount,
        senderId,
        false,
      );
    } else {
      throw Exception("Request money was unsuccessful");
    }
  }
}
