class Trx {
  String accountNumber;
  String amount;
  String details;

  Trx({
    required this.accountNumber,
    required this.amount,
    required this.details,
  });

  Map<String, dynamic> toJson() {
    return {
      'account': accountNumber,
      'amount': amount,
      'details': details,
    };
  }

  factory Trx.fromJson(Map<String, dynamic> json) {
    return Trx(
      accountNumber: json['account'],
      amount: json['amount'],
      details: json['details'],
    );
  }
}
