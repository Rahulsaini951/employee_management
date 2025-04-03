import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talent_track/blocs/employee/employee_bloc.dart';
import 'package:talent_track/blocs/employee/employee_event.dart';
import 'package:talent_track/blocs/employee/employee_state.dart';
import 'package:talent_track/data/models/employee.dart';
import 'package:talent_track/ui/common/app_assets.dart';
import 'package:talent_track/ui/common/app_colors.dart';
import 'package:talent_track/ui/common/app_theme.dart';
import 'package:talent_track/ui/screens/add_employee.dart';
import 'package:talent_track/ui/widgets/employee_list_item.dart';
import 'package:talent_track/utils/string_util.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringUtil.employeeList,
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
                StringUtil.unknownState,
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
          SvgPicture.asset(AppAssets.noEmployee, height: 200),
          const SizedBox(height: 16),
          Text(
            StringUtil.noEmployeeRecordsFound,
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
                    StringUtil.currentEmployees,
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
                        StringUtil.employeeDataDeleted,
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
                    StringUtil.previousEmployees,
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
                        StringUtil.employeeDataDeleted,
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
              StringUtil.swipeLeftToDelete,
              style: AppTextStyles.input(context).copyWith(
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ],
    );
  }
}