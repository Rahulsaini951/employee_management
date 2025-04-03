import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talent_track/data/local/database_helper.dart';
import 'package:talent_track/ui/common/app_theme.dart';
import 'blocs/employee/employee_bloc.dart';
import 'data/repositories/employee_repository.dart';
import 'ui/screens/employee_list_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Initialize database
  final databaseHelper = DatabaseHelper();
  await databaseHelper.initDatabase();

  runApp(const EmployeeManagementApp());
}

class EmployeeManagementApp extends StatelessWidget {
  const EmployeeManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeBloc(repository: EmployeeRepository()),
      child: MaterialApp(
        title: 'Employee Management',
        theme: AppTheme.lightTheme,
        home: const EmployeeListScreen(),
      ),
    );
  }
}