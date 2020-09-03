import 'package:money_manager/models/reward.dart';
import 'package:money_manager/models/transaction.dart';

class User {
  int _id;
  double _accountBalance;
  List<int> userFriends;
  List<Reward> rewards;
  List<Transaction> transactions;

  //----------- constructor -----------//
  User(
    this._id,
    this._accountBalance, {
    this.rewards,
    this.transactions,
    this.userFriends,
  });

  //----------- Getters -----------//
  List<Object> get props => [_id];
  int get id => _id;
  double get accountBalance => _accountBalance;
}
