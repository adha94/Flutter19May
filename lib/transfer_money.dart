import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apptextfield.dart';
import 'package:flutter_application_1/transfer_details.dart';
import 'package:http/http.dart' as http;

class TransferMoney extends StatefulWidget {
  const TransferMoney({super.key});

  @override
  State<TransferMoney> createState() => _TransferMoneyState();
}

class _TransferMoneyState extends State<TransferMoney> {
  // Text editing controllers for the input fields
  TextEditingController amountController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  @override
  void dispose() {
    // Dispose the text editing controllers to free up resources
    super.dispose();
    amountController.dispose();
    accountController.dispose();
    detailsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title:
            const Text('Transfer Money', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 5,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              // Text instructions for the user
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Please check the account number and amount before transferring.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Input field for account number
                    AppTextField(
                        controller: accountController,
                        keyboardType: TextInputType.number,
                        labelText: 'Account Number',
                        obscureText: false,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        autovalidateMode: AutovalidateMode.disabled,
                        textInputAction: TextInputAction.next),
                    // Input field for transfer amount
                    AppTextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        labelText: 'Amount',
                        obscureText: false,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        autovalidateMode: AutovalidateMode.disabled,
                        textInputAction: TextInputAction.next),
                    // Input field for transfer details
                    AppTextField(
                        controller: detailsController,
                        keyboardType: TextInputType.text,
                        labelText: 'Details',
                        obscureText: false,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.sentences,
                        autovalidateMode: AutovalidateMode.disabled,
                        textInputAction: TextInputAction.done)
                  ],
                ),
              ),
              // Button to initiate the money transfer
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: 320,
                    child: ElevatedButton(
                      onPressed: () {
                        post(accountController.text, amountController.text,
                            detailsController.text);
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 10,
                          backgroundColor: Colors.yellow,
                          foregroundColor: Colors.black),
                      child: const Text('TRANSFER'),
                    ),
                  )),
              // Button to view transaction details
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextButton(
                    child: const Text('View Transactions'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TransferDetails()));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> post(
      String accountController, amountController, detailsController) async {
    // var client = http.Client();
    const String baseUrl =
        'https://646767292ea3cae8dc2dc149.mockapi.io/transfer';
    var url = Uri.parse(baseUrl);
    var headers = {'content-type': 'application/json'};

    var data = {
      'account': accountController,
      'amount': amountController,
      'details': detailsController
    };

    final response =
        await http.post(url, headers: headers, body: json.encode(data));

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      // POST request successful
      print('Transfer successful');
    } else {
      // POST request failed
      print('Transfer failed');
    }
  }
}
