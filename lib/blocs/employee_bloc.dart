import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/employee_repository.dart';
import 'employee_event.dart';
import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository repository;

  EmployeeBloc({required this.repository}) : super(EmployeeInitial()) {
    on<LoadEmployees>(_onLoadEmployees);
    on<AddEmployee>(_onAddEmployee);
    on<UpdateEmployee>(_onUpdateEmployee);
    on<DeleteEmployee>(_onDeleteEmployee);
  }

  Future<void> _onLoadEmployees(LoadEmployees event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoading());
    try {
      final employees = await repository.getEmployees();
      final currentEmployees = employees.where((e) => e.isCurrentEmployee).toList();
      final previousEmployees = employees.where((e) => !e.isCurrentEmployee).toList();

      emit(EmployeeLoaded(
        currentEmployees: currentEmployees,
        previousEmployees: previousEmployees,
      ));
    } catch (e) {
      emit(EmployeeError('Failed to load employees: $e'));
    }
  }

  Future<void> _onAddEmployee(AddEmployee event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoading());
    try {
      await repository.addEmployee(event.employee);
      add(LoadEmployees());
    } catch (e) {
      emit(EmployeeError('Failed to add employee: $e'));
    }
  }

  Future<void> _onUpdateEmployee(UpdateEmployee event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoading());
    try {
      await repository.updateEmployee(event.employee);
      add(LoadEmployees());
    } catch (e) {
      emit(EmployeeError('Failed to update employee: $e'));
    }
  }

  Future<void> _onDeleteEmployee(DeleteEmployee event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoading());
    try {
      await repository.deleteEmployee(event.id);
      add(LoadEmployees());
    } catch (e) {
      emit(EmployeeError('Failed to delete employee: $e'));
    }
  }
}