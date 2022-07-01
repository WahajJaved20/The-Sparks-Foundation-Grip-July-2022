// ignore_for_file: prefer_const_declarations, unnecessary_this

final String tableName = "Customers";

class TableFields {
  static final List<String> values = [id, name, value];
  static final String id = "_id";
  static final String name = "customer_name";
  static final String value = "money_value";
}

class Customer {
  final int? id;
  final String customerName;
  final int moneyValue;

  Customer({this.id, required this.customerName, required this.moneyValue});

  Customer copy({int? id, String? cName, int? money}) => Customer(
      id: id ?? this.id,
      customerName: cName ?? this.customerName,
      moneyValue: money ?? this.moneyValue);

  static Customer fromJson(Map<String, Object?> json) => Customer(
        id: json[TableFields.id] as int,
        customerName: json[TableFields.name] as String,
        moneyValue: json[TableFields.value] as int,
      );

  Map<String, Object?> toJson() => {
        TableFields.id: id,
        TableFields.name: customerName,
        TableFields.value: moneyValue
      };
}
