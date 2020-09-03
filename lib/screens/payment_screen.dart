import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/models/user.dart';
import 'package:money_manager/providers/transactions_provider.dart';
import 'package:money_manager/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:toggle_switch/toggle_switch.dart';

enum TransactionMode { Send, Receive }

class PaymentScreen extends StatefulWidget {
  static const routeName = '/payment-screen';

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _amountFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  User _user;
  double _opacity = 0.0;
  int _receiverId;
  TransactionMode _selectedMode = TransactionMode.Send;

  // transaction Data
  Map<String, String> _transactionData = {
    'receiverId': '',
    'amount': '',
    'description': '',
  };

  @override
  void initState() {
    _user = Provider.of<UserProvider>(
      context,
    ).getUserDetails();

    _receiverId = _user.userFriends[0];
    super.initState();
  }

  @override
  void dispose() {
    _amountFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              'New Payment',
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
                onPanelSlide: (value) {
                  setState(() {
                    _opacity = value;
                  });
                },
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(26),
                  topRight: Radius.circular(26),
                ),
                panelBuilder: (sc) => SingleChildScrollView(
                  controller: sc,
                  child: Container(
                    padding: const EdgeInsets.all(22.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Send/Receive Toggle
                          Padding(
                            padding: const EdgeInsets.only(bottom: 26.0),
                            child: ToggleSwitch(
                              minWidth: 120.0,
                              minHeight: 50.0,
                              initialLabelIndex: _selectedMode.index,
                              cornerRadius: 12.0,
                              activeFgColor: Theme.of(context).accentColor,
                              inactiveFgColor: Colors.grey[800],
                              inactiveBgColor: Theme.of(context).accentColor,
                              activeBgColor: Theme.of(context).primaryColor,
                              labels: ['Send', 'Receive'],
                              icons: [
                                Icons.call_made,
                                Icons.call_received,
                              ],
                              onToggle: (index) {
                                setState(() {
                                  _selectedMode = index == 0
                                      ? TransactionMode.Send
                                      : TransactionMode.Receive;
                                });
                              },
                            ),
                          ),

                          // Sender/Receiver Id
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _selectedMode == TransactionMode.Send
                                        ? '     To : '
                                        : 'From : ',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 60,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: Colors.grey[500]),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<int>(
                                      elevation: 1,
                                      value: _receiverId,
                                      items: _user.userFriends
                                          .map(
                                            (value) => DropdownMenuItem(
                                              value: value,
                                              child: Text('$value'),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _receiverId = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Amount input field
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              validator: (value) {
                                if (value.length == 0) {
                                  return 'Amount cannot be empty';
                                } else if (value
                                    .contains(RegExp(r'[a-zA-Z_]'))) {
                                  return 'Invalid Amount';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Amount",
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              onFieldSubmitted: (_) {
                                _formKey.currentState.validate();
                                FocusScope.of(context)
                                    .requestFocus(_descriptionFocusNode);
                              },
                              onSaved: (value) {
                                _transactionData['amount'] = value;
                              },
                            ),
                          ),

                          // Description input field
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              focusNode: _descriptionFocusNode,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                labelText: "Description",
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).unfocus();
                              },
                              onSaved: (value) {
                                _transactionData['description'] = value;
                              },
                            ),
                          ),

                          // Submit Button
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ButtonTheme(
                              minWidth: 150.0,
                              padding: const EdgeInsets.all(14.0),
                              child: FlatButton(
                                onPressed: _submit,
                                color: Theme.of(context).primaryColor,
                                textColor: Theme.of(context).accentColor,
                                child: Text(
                                  '${_selectedMode == TransactionMode.Send ? 'Send' : 'Receive'}',
                                  style: TextStyle(fontSize: 18),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                    child: Image.asset('assets/images/header.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Add new User Button
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.add,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () {
            _addFriendDialog(context);
          },
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _submit() {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState.save();

    try {
      Provider.of<UserProvider>(context, listen: false).addTransaction(
        _selectedMode == TransactionMode.Send
            ? Provider.of<TransactionsProvider>(context, listen: false)
                .payMoney(
                double.parse(_transactionData['amount']),
                _user.accountBalance,
                _transactionData['description'],
                _receiverId,
              )
            : Provider.of<TransactionsProvider>(context, listen: false)
                .requestMoney(
                double.parse(_transactionData['amount']),
                _transactionData['description'],
                _receiverId,
              ),
      );
      _showSuccessDialog('Payment Successful!', context);
      _formKey.currentState.reset();

      print(_user.transactions);
    } catch (error) {
      _showErrorDialog(error.toString(), context);
    }
  }

  static void _showSuccessDialog(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        title: Text('Success!'),
        content: Text(message),
        actions: [
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  static void _showErrorDialog(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        title: Text('An error Occurred!'),
        content: Text(message),
        actions: [
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  static void _addFriendDialog(BuildContext context) {
    var _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        title: Text('Add a Friend'),
        content: TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          style: TextStyle(
            fontSize: 16,
          ),
          decoration: InputDecoration(
            labelText: "ID",
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        actions: [
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              // _controller.dispose();
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Save'),
            onPressed: () {
              print('Friend ID: ${_controller.text}');
              Provider.of<UserProvider>(
                context,
                listen: false,
              ).addUserFriend(
                int.parse(_controller.text),
              );
              // _controller.dispose();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
