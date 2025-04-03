import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:talent_track/ui/common/app_colors.dart';
import '../../data/models/employee.dart';

class EmployeeListItem extends StatelessWidget {
  final Employee employee;
  final Function(int?) onDelete;
  final Function(Employee) onEdit;

  const EmployeeListItem({
    super.key,
    required this.employee,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(employee.id.toString()),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: SvgPicture.asset(
          'assets/images/delete_icon.svg',
          width: 24,
          height: 24,
        )
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onDelete(employee.id);
      },
      child: InkWell(
        onTap: () => onEdit(employee),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.card,
            border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    employee.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    employee.role,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDateRange(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateRange() {
    final DateFormat formatter = DateFormat('d MMM, yyyy');
    final String fromDate = formatter.format(employee.fromDate);

    if (employee.toDate == null) {
      return 'From $fromDate';
    } else {
      final String toDate = formatter.format(employee.toDate!);
      return '$fromDate - $toDate';
    }
  }
}