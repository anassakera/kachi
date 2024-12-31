import 'package:flutter/material.dart';
import '../../constant/app_colors.dart';
import '../../constant/app_typography.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class AddCheckScreen extends StatefulWidget {
  const AddCheckScreen({super.key});

  @override
  State<AddCheckScreen> createState() => _AddCheckScreenState();
}

class _AddCheckScreenState extends State<AddCheckScreen> {
  final _formKey = GlobalKey<FormState>();
  final _checkNumberController = TextEditingController();
  final _amountController = TextEditingController();
  final _issueDateController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _transferDateController = TextEditingController();
  final _remarksController = TextEditingController();
  final _paymentTypeController = TextEditingController();
  final _transferredToController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _checkNumberController.dispose();
    _amountController.dispose();
    _issueDateController.dispose();
    _dueDateController.dispose();
    _customerNameController.dispose();
    _bankNameController.dispose();
    _transferDateController.dispose();
    _remarksController.dispose();
    _paymentTypeController.dispose();
    _transferredToController.dispose();
    super.dispose();
  }

  Future<void> _handleAddCheck() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      try {
        // TO DO: Implement add check logic
        await Future.delayed(const Duration(seconds: 2)); // Simulated delay

        if (mounted) {
          // Navigate back to check list screen on success
          // Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              backgroundColor: AppColors.error,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Check',
          style: AppTypography.heading2.copyWith(
            color: AppColors.textLight,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                controller: _checkNumberController,
                label: 'Check Number',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the check number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _amountController,
                label: 'Amount',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _issueDateController,
                label: 'Issue Date',
                onTap: () {
                  // TO DO: Show date picker
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the issue date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _dueDateController,
                label: 'Due Date',
                onTap: () {
                  // TO DO: Show date picker
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the due date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _customerNameController,
                label: 'Customer Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the customer name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _bankNameController,
                label: 'Bank Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the bank name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _paymentTypeController,
                label: 'Payment Type (CHQ/EFF)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the payment type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _transferredToController,
                label: 'Transferred To (MIS A)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the transferred to';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _transferDateController,
                label: 'Transfer Date (LA DATE)',
                onTap: () {
                  // TO DO: Show date picker
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the transfer date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _remarksController,
                label: 'Remarks (REMARQUES)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the remarks';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              CustomButton(
                onPressed: _isLoading ? null : _handleAddCheck,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('Add Check'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
