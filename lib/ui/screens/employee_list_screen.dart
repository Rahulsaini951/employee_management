import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talent_track/ui/screens/add_employee.dart';
import '../../blocs/employee/employee_bloc.dart';
import '../../blocs/employee/employee_event.dart';
import '../../blocs/employee/employee_state.dart';
import '../../data/models/employee.dart';
import '../common/app_theme.dart';
import '../widgets/employee_list_item.dart';
import '../common/app_colors.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Employee List',
          style: AppTextStyles.appBarTitle(context),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeInitial) {
            context.read<EmployeeBloc>().add(LoadEmployees());
            return const Center(child: CircularProgressIndicator());
          }

          if (state is EmployeeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is EmployeeLoaded) {
            if (state.currentEmployees.isEmpty && state.previousEmployees.isEmpty) {
              return _buildEmptyState(context);
            }

            return _buildEmployeeList(context, state.currentEmployees, state.previousEmployees);
          }

          if (state is EmployeeError) {
            return Center(
              child: Text(
                state.message,
                style: textStyle.bodyLarge,
              ),
            );
          }

          return Center(
            child: Text(
              'Unknown state',
              style: textStyle.bodyLarge
              // AppTextStyles.bodyLarge(context),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEmployeeScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/no_employee_found.svg', height: 200),
          const SizedBox(height: 16),
          Text(
            'No employee records found',
            style: textStyle.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeList(
      BuildContext context,
      List<Employee> currentEmployees,
      List<Employee> previousEmployees) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.only(bottom: 50), // Avoid overlapping with the text
          children: [
            if (currentEmployees.isNotEmpty) ...[
              Container(
                color: AppColors.divider,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Current employees',
                    style: AppTextStyles.dividerTitle(context).copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              ...currentEmployees.map((employee) => EmployeeListItem(
                employee: employee,
                onDelete: (id) {
                  context.read<EmployeeBloc>().add(DeleteEmployee(id!));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Employee data has been deleted',
                        style: AppTextStyles.input(context).copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
                onEdit: (employee) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEmployeeScreen(employee: employee),
                    ),
                  );
                },
              )),
            ],
            if (previousEmployees.isNotEmpty) ...[
              Container(
                color: AppColors.divider,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Previous employees',
                    style: AppTextStyles.dividerTitle(context).copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              ...previousEmployees.map((employee) => EmployeeListItem(
                employee: employee,
                onDelete: (id) {
                  context.read<EmployeeBloc>().add(DeleteEmployee(id!));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Employee data has been deleted',
                        style: AppTextStyles.input(context).copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
                onEdit: (employee) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEmployeeScreen(employee: employee),
                    ),
                  );
                },
              )),
            ],
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: AppColors.divider,
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: Text(
              'Swipe left to delete',
              style: AppTextStyles.input(context).copyWith(
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buildEmployeeList(
  //     BuildContext context,
  //     List<Employee> currentEmployees,
  //     List<Employee> previousEmployees
  //     ) {
  //   return ListView(
  //     children: [
  //       if (currentEmployees.isNotEmpty) ...[
  //         Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Text(
  //             'Current employees',
  //             style: AppTextStyles.dividerTitle(context).copyWith(
  //               color: AppColors.primary,
  //             ),
  //           ),
  //         ),
  //         ...currentEmployees.map((employee) =>
  //             EmployeeListItem(
  //               employee: employee,
  //               onDelete: (id) {
  //                 context.read<EmployeeBloc>().add(DeleteEmployee(id!));
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   SnackBar(
  //                     content: Text(
  //                       'Employee data has been deleted',
  //                       style: AppTextStyles.input(context).copyWith(
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ),
  //                 );
  //               },
  //               onEdit: (employee) {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => AddEmployeeScreen(employee: employee),
  //                   ),
  //                 );
  //               },
  //             )
  //         ),
  //       ],
  //
  //       if (previousEmployees.isNotEmpty) ...[
  //         Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Text(
  //             'Previous employees',
  //             style: AppTextStyles.dividerTitle(context).copyWith(
  //               color: AppColors.primary,
  //             ),
  //           ),
  //         ),
  //         ...previousEmployees.map((employee) =>
  //             EmployeeListItem(
  //               employee: employee,
  //               onDelete: (id) {
  //                 context.read<EmployeeBloc>().add(DeleteEmployee(id!));
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   SnackBar(
  //                     content: Text(
  //                       'Employee data has been deleted',
  //                       style: AppTextStyles.input(context).copyWith(
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ),
  //                 );
  //               },
  //               onEdit: (employee) {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => AddEmployeeScreen(employee: employee),
  //                   ),
  //                 );
  //               },
  //             )
  //         ),
  //       ],
  //     ],
  //   );
  // }
}