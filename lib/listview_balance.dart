import 'package:flutter/material.dart';
import 'package:flutter_application_1/transfer_money.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';

class UserBalances extends StatefulWidget {
  const UserBalances(this.name, {Key? key}) : super(key: key);
  final String? name;

  @override
  State<UserBalances> createState() => _UserBalancesState();
}

class _UserBalancesState extends State<UserBalances> {
  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        // Center the contents of the widget
        child: Padding(
      padding: const EdgeInsets.fromLTRB(10, 50, 10, 50),
      child: ListView(
        children: <Widget>[
          // Display the user's name and a logout button
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(widget.name ?? ''),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: () {
                    // Clear the shared preferences and navigate to the login page
                    if (sharedPreferences != null) {
                      sharedPreferences!.remove('email');
                      sharedPreferences!.remove('password');
                      sharedPreferences!.clear();
                    } else {
                      // Show an error dialog if shared preferences is null
                      showAboutDialog(
                          context: context,
                          children: [const Text('Logout Error')]);
                    }
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const LoginPage())));
                  },
                  child: const Icon(Icons.logout)),
            ),
          ]),
          // Display the user's saving account balance
          GestureDetector(
            child: const Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              elevation: 5,
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                title: Text('Saving Account'),
                subtitle: Text('RM 3241.95'),
                trailing: Icon(Icons.wallet, size: 58),
              ),
            ),
            // Navigate to the transfer money page when the card is tapped
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TransferMoney()));
            },
          ),
          const SizedBox(height: 10),
          const Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            elevation: 5,
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              title: Text('Credit Card'),
              subtitle: Text('RM 9241.45'),
              trailing: Icon(Icons.credit_card, size: 58),
            ),
          ),
          const SizedBox(height: 10),
          const Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            elevation: 5,
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              title: Text('Home Loan'),
              subtitle: Text('RM 100,945.95'),
              trailing: Icon(Icons.home, size: 58),
            ),
          )
        ],
      ),
    ));
  }
}
