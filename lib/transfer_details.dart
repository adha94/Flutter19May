import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransferDetails extends StatefulWidget {
  const TransferDetails({super.key});

  @override
  TransferDetailsState createState() => TransferDetailsState();
}

class TransferDetailsState extends State<TransferDetails> {
  // List to store the transfer details retrieved from the API
  List<dynamic> jsonData = [];

  @override
  void initState() {
    super.initState();
    // Fetch the transfer details when the widget is initialized
    get();
  }

  Future<dynamic> get() async {
    var client = http.Client();
    const String baseUrl =
        'https://646767292ea3cae8dc2dc149.mockapi.io/transfer';
    var url = Uri.parse(baseUrl);
    var headers = {'content-type': 'application/json'};
    var response = await client.get(url, headers: headers);
    if (response.statusCode == 200) {
      // If the API call is successful, update the jsonData list with the retrieved data
      setState(() {
        jsonData = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: jsonData.length,
          itemBuilder: (context, index) {
            final item = jsonData[index];
            return ListTile(
              // Display the transfer details in a list
              title: Text(item['accountNumber']),
              subtitle: Text(item['amount']),
              trailing: Text(item['details']),
            );
          }),
    );
  }
}
