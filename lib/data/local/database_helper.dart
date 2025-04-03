import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/employee.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static const String _employeeBoxName = 'employees';
  static Box<Employee>? _employeeBox;

  Future<void> initDatabase() async {
    // Initialize Hive
    await Hive.initFlutter();

    // Register the Employee adapter
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(EmployeeAdapter());
    }

    // Open the box
    _employeeBox = await Hive.openBox<Employee>(_employeeBoxName);
  }

  Future<int> insertEmployee(Employee employee) async {
    if (_employeeBox == null) await initDatabase();

    // Generate a new ID if not provided
    if (employee.id == null || employee.id == 0) {
      int newId = (_employeeBox!.isEmpty) ? 1 : (_employeeBox!.values.map((e) => e.id ?? 0).reduce((a, b) => a > b ? a : b) + 1);
      employee = employee.copyWith(id: newId);
    }

    await _employeeBox!.put(employee.id, employee);
    return employee.id!;
  }

  Future<int> updateEmployee(Employee employee) async {
    if (_employeeBox == null) await initDatabase();
    await _employeeBox!.put(employee.id, employee);
    return employee.id!;
  }

  Future<int> deleteEmployee(int id) async {
    if (_employeeBox == null) await initDatabase();
    await _employeeBox!.delete(id);
    return id;
  }

  Future<List<Employee>> getEmployees() async {
    if (_employeeBox == null) await initDatabase();
    return _employeeBox!.values.toList();
  }

  Future<Employee?> getEmployee(int id) async {
    if (_employeeBox == null) await initDatabase();
    return _employeeBox!.get(id);
  }
}