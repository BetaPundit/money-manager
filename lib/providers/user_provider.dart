import 'package:flutter/material.dart';
import 'package:money_manager/models/transaction.dart';
import 'package:money_manager/models/reward.dart';
import 'package:money_manager/models/user.dart';

class UserProvider with ChangeNotifier {
  //----------- Static Class Variables -----------//
  static List<Reward> rewardList = [
    Reward("1", "First Reward"),
    Reward("2", "Second Reward")
  ];

  static List<Transaction> transactionList = [
    Transaction("1", 55.0, 2, true),
    Transaction("2", 980, 3, false),
    Transaction("3", 1050.0, 2, true),
  ];

  static List<int> userFriends = [2, 3, 4, 7];

  static User user = User(
    1,
    1978.90,
    rewards: rewardList,
    transactions: transactionList,
    userFriends: userFriends,
  );

  //----------- Class Methods -----------//
  void addReward(Reward reward) {
    rewardList.add(reward);
    notifyListeners();
  }

  void addTransaction(Transaction transaction) {
    transactionList.add(transaction);
    rewardList.add(transaction.rewardReceived);

    user = User(
      user.id,
      transaction.isDebit
          ? user.accountBalance - transaction.amount
          : user.accountBalance + transaction.amount,
      transactions: transactionList,
      rewards: rewardList,
      userFriends: userFriends,
    );

    notifyListeners();
  }

  void addUserFriend(int friendId) {
    userFriends.add(friendId);
    notifyListeners();
  }

  User getUserDetails() {
    return user;
  }
}
