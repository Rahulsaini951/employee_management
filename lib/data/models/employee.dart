import 'package:hive/hive.dart';
part 'employee.g.dart';

@HiveType(typeId: 0)
class Employee {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String role;

  @HiveField(3)
  final DateTime fromDate;

  @HiveField(4)
  final DateTime? toDate;

  Employee({
    this.id,
    required this.name,
    required this.role,
    required this.fromDate,
    this.toDate,
  });

  Employee copyWith({
    int? id,
    String? name,
    String? role,
    DateTime? fromDate,
    DateTime? toDate,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'fromDate': fromDate.millisecondsSinceEpoch,
      'toDate': toDate?.millisecondsSinceEpoch,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      name: map['name'],
      role: map['role'],
      fromDate: DateTime.fromMillisecondsSinceEpoch(map['fromDate']),
      toDate: map['toDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['toDate']) : null,
    );
  }

  bool get isCurrentEmployee {
    if (toDate == null) return true;
    return DateTime.now().isBefore(toDate!);
  }
}