import '../models/employee.dart';
import '../local/database_helper.dart';

class EmployeeRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<Employee>> getEmployees() async {
    return await _databaseHelper.getEmployees();
  }

  Future<Employee?> getEmployee(int id) async {
    return await _databaseHelper.getEmployee(id);
  }

  Future<void> addEmployee(Employee employee) async {
    await _databaseHelper.insertEmployee(employee);
  }

  Future<void> updateEmployee(Employee employee) async {
    await _databaseHelper.updateEmployee(employee);
  }

  Future<void> deleteEmployee(int id) async {
    await _databaseHelper.deleteEmployee(id);
  }
}