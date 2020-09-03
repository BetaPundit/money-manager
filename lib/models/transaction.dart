import 'package:money_manager/models/reward.dart';

class Transaction {
  String _id;
  double _amount;
  int _receiverId;
  String description;
  Reward rewardReceived;
  bool isDebit;

  //----------- constructor -----------//
  Transaction(
    this._id,
    this._amount,
    this._receiverId,
    this.isDebit, {
    this.description,
    this.rewardReceived,
  });

  //----------- Getters -----------//
  List<Object> get props => [_id, _amount, _receiverId];
  String get id => _id;
  double get amount => _amount;
  int get receiverId => _receiverId;
}
