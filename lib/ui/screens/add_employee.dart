import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:talent_track/ui/common/app_theme.dart';
import 'package:talent_track/ui/widgets/costom_date_picker.dart';
import 'package:talent_track/ui/widgets/custom_app_button.dart';
import '../../blocs/employee/employee_bloc.dart';
import '../../blocs/employee/employee_event.dart';
import '../../data/models/employee.dart';
import '../common/app_colors.dart';

class AddEmployeeScreen extends StatefulWidget {
  final Employee? employee;

  const AddEmployeeScreen({super.key, this.employee});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  String? _selectedRole;
  DateTime? _fromDate;
  DateTime? _toDate;
  final List<String> _roles = [
    'Product Designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owner'
  ];

  final FocusNode _nameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();

    if (widget.employee != null) {
      _nameController.text = widget.employee!.name;
      _selectedRole = widget.employee!.role;
      _fromDate = widget.employee!.fromDate;
      _toDate = widget.employee!.toDate;
    } else {
      _fromDate = DateTime.now();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _dismissKeyboard,
      child: Scaffold(
        backgroundColor: AppColors.secondaryBackground,
        appBar: AppBar(
          title: Text(
            widget.employee == null ? 'Add Employee Details' : 'Edit Employee Details',
            style: AppTextStyles.appBarTitle(context),
          ),
          actions: [
            if(widget.employee?.id != null)
            IconButton(
              onPressed: () {
                context.read<EmployeeBloc>().add(DeleteEmployee(widget.employee!.id!));
                Navigator.pop(context);
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
              icon: SvgPicture.asset(
                'assets/images/delete_icon.svg',
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name TextField
                  TextFormField(
                    controller: _nameController,
                    focusNode: _nameFocusNode,
                    style: AppTextStyles.input(context),
                    decoration: InputDecoration(
                      labelText: 'Employee name *',
                      labelStyle: AppTextStyles.inputHint(context),
                      border: OutlineInputBorder(),
                      prefixIcon: SizedBox(
                        width: 48,
                        height: 48,
                        child: Align(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            'assets/images/name_icon.svg',
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter employee name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Role Dropdown
                  InkWell(
                    onTap: () {
                      _dismissKeyboard();
                      _showRoleSelector();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.divider),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'assets/images/role_icon.svg',
                              height: 24,
                              width: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _selectedRole ?? 'Select role *',
                            style: _selectedRole == null
                                ? AppTextStyles.inputHint(context)
                                : AppTextStyles.input(context),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_drop_down, color: AppColors.primary),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            _selectFromDate();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.divider),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(
                                    'assets/images/calendar_icon.svg',
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _fromDate == null
                                      ? 'Today'
                                      : DateFormat('d MMM, yyyy').format(_fromDate!),
                                  style: AppTextStyles.input(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.arrow_forward, color: AppColors.primary),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            _selectToDate();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.divider),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(
                                    'assets/images/calendar_icon.svg',
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _toDate == null
                                      ? 'No date'
                                      : DateFormat('d MMM, yyyy').format(_toDate!),
                                  style: AppTextStyles.input(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(height: 1, thickness: 1, color: AppColors.divider), // Divider added here
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                left: 16,
                right: 16,
                top: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    text: 'Cancel',
                    onPressed: () {
                      _dismissKeyboard();
                      Navigator.pop(context);
                    },
                    isSelected: false,
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      _dismissKeyboard();
                      _saveEmployee();
                    },
                    child: Text(
                      'Save',
                      style: AppTextStyles.positiveButtonText(context).copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRoleSelector() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ..._roles.map((role) => Column(
              children: [
                Divider(height: 1),
                InkWell(
                  onTap: (){
                    setState(() {
                      _selectedRole = role;
                    });
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                        role,
                        style: AppTextStyles.bottomSheetText(context)
                    ),
                  ),
                ),
                SizedBox(height: 12)
              ],
            )),
          ],
        );
      },
    );
  }

  Future<void> _selectFromDate() async {
    final selectedDate = await CustomDatePicker.show(
      context: context,
      initialDate: _fromDate,
      isFromDate: true,
    );

    if (selectedDate != null) {
      setState(() {
        _fromDate = selectedDate;
        // If toDate is before fromDate, reset toDate
        if (_toDate != null && _toDate!.isBefore(selectedDate)) {
          _toDate = null;
        }
      });
    }
  }

  Future<void> _selectToDate() async {
    final selectedDate = await CustomDatePicker.show(
      context: context,
      initialDate: _toDate,
      isFromDate: false,
      minDate: _fromDate, // Pass fromDate as minDate
    );

    if (selectedDate != null) {
      setState(() {
        _toDate = selectedDate;
      });
    }
  }

  void _saveEmployee() {
    if (_formKey.currentState!.validate() && _selectedRole != null && _fromDate != null) {
      final employee = Employee(
        id: widget.employee?.id,
        name: _nameController.text,
        role: _selectedRole!,
        fromDate: _fromDate!,
        toDate: _toDate,
      );

      if (widget.employee == null) {
        context.read<EmployeeBloc>().add(AddEmployee(employee));
      } else {
        context.read<EmployeeBloc>().add(UpdateEmployee(employee));
      }
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill all required fields',
            style: AppTextStyles.input(context).copyWith(
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }
}