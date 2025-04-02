class Employee {
  final int? id;
  final String name;
  final String role;
  final DateTime fromDate;
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
      id: map['id'] as int,
      name: map['name'] as String,
      role: map['role'] as String,
      fromDate: DateTime.fromMillisecondsSinceEpoch(map['fromDate'] as int),
      toDate: map['toDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['toDate'] as int) : null,
    );
  }

  bool get isCurrentEmployee {
    if (toDate == null) return true;
    return DateTime.now().isBefore(toDate!);
  }
}