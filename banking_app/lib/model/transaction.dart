// ignore_for_file: prefer_const_declarations

final String transactionTable = "TransactionTable";

class TransactionTableField {
  static final String id = "_id";
  static final String value = "Transactions";
}

class TransactionList {
  final int? id;
  final String value;
  TransactionList({this.id, required this.value});
  static TransactionList fromJson(Map<String, Object?> json) => TransactionList(
      id: json[TransactionTableField.id] as int,
      value: json[TransactionTableField.value] as String);
  Map<String, Object?> toJson() => {
        TransactionTableField.id: id,
        TransactionTableField.value: value,
      };
}
