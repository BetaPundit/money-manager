import 'package:flutter/material.dart';
import 'package:money_manager/models/user.dart';
import 'package:money_manager/providers/user_provider.dart';
import 'package:provider/provider.dart';

class RewardCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User _user = Provider.of<UserProvider>(
      context,
      listen: false,
    ).getUserDetails();

    return Card(
      margin: const EdgeInsets.all(0.0),
      elevation: 10.0,
      color: Theme.of(context).accentColor,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Total Rewards: ',
                style: TextStyle(
                  color: Colors.grey[800],
                ),
              ),
              Text(
                '${_user.rewards.length}',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
