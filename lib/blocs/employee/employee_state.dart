import 'package:talent_track/data/models/employee.dart';

abstract class EmployeeState {}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final List<Employee> currentEmployees;
  final List<Employee> previousEmployees;

  EmployeeLoaded({
    required this.currentEmployees,
    required this.previousEmployees,
  });
}

class EmployeeOperationSuccess extends EmployeeState {}

class EmployeeError extends EmployeeState {
  final String message;

  EmployeeError(this.message);
}