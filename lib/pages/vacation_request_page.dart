// lib/pages/vacation_request_page.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nav_poc/models/vacation_request.dart';
import 'package:nav_poc/nav_service.dart';
import 'package:nav_poc/navigation_guard_mixin.dart';

@RoutePage()
class VacationRequestPage extends StatefulWidget {
  const VacationRequestPage({Key? key}) : super(key: key);

  @override
  State<VacationRequestPage> createState() => _VacationRequestPageState();
}

class _VacationRequestPageState extends State<VacationRequestPage>
    with NavigationGuardMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final VacationRequest _vacationRequest = VacationRequest(
    employeeName: '',
    employeeId: '',
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 1)),
    reason: '',
    contactInfo: '',
  );

  final FocusNode _reasonFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _reasonFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_reasonFocusNode.hasFocus) {
      _updateUnsavedChanges();
    }
  }

  void _updateUnsavedChanges() {
    final hasData =
        _vacationRequest.employeeName.isNotEmpty ||
        _vacationRequest.employeeId.isNotEmpty ||
        _vacationRequest.reason.isNotEmpty ||
        _vacationRequest.contactInfo.isNotEmpty;

    setHasUnsavedChanges(hasData);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // No need to call save() since we're updating in real-time
      // _formKey.currentState!.save();

      if (_vacationRequest.isComplete && _vacationRequest.hasValidDates) {
        _showSuccessDialog();
        clearUnsavedChanges();
      } else {
        _showValidationError();
      }
    }
  }

  void _showValidationError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Please fill all required fields correctly before submitting.',
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Request Submitted'),
          content: const Text(
            'Your vacation request has been submitted successfully.',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                NavService().goBack();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget buildWithProtection(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vacation Request'),
        actions: [
          if (hasUnsavedChanges)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.circle, color: Colors.orange, size: 12),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          onChanged: _updateUnsavedChanges,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Employee Name *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (value) {
                  // Update model in real-time
                  _vacationRequest.updateEmployeeName(value ?? '');
                  _updateUnsavedChanges();
                },
                // onSaved is optional now since we update in real-time
                onSaved: (value) {
                  _vacationRequest.updateEmployeeName(value ?? '');
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Employee ID *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your employee ID';
                  }
                  return null;
                },
                onChanged: (value) {
                  _vacationRequest.updateEmployeeId(value ?? '');
                  _updateUnsavedChanges();
                },
                onSaved: (value) {
                  _vacationRequest.updateEmployeeId(value ?? '');
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Start Date *'),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () async {
                            final selectedDate = await showDatePicker(
                              context: context,
                              initialDate: _vacationRequest.startDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );
                            if (selectedDate != null) {
                              setState(() {
                                _vacationRequest.updateStartDate(selectedDate);
                                _updateUnsavedChanges();
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  '${_vacationRequest.startDate.day}/${_vacationRequest.startDate.month}/${_vacationRequest.startDate.year}',
                                ),
                                const Spacer(),
                                const Icon(Icons.calendar_today, size: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('End Date *'),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () async {
                            final selectedDate = await showDatePicker(
                              context: context,
                              initialDate: _vacationRequest.endDate,
                              firstDate: _vacationRequest.startDate,
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );
                            if (selectedDate != null) {
                              setState(() {
                                _vacationRequest.updateEndDate(selectedDate);
                                _updateUnsavedChanges();
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  '${_vacationRequest.endDate.day}/${_vacationRequest.endDate.month}/${_vacationRequest.endDate.year}',
                                ),
                                const Spacer(),
                                const Icon(Icons.calendar_today, size: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (!_vacationRequest.hasValidDates) ...[
                const SizedBox(height: 8),
                const Text(
                  'End date must be after start date',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],
              const SizedBox(height: 16),
              TextFormField(
                focusNode: _reasonFocusNode,
                decoration: const InputDecoration(
                  labelText: 'Reason for Vacation *',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the reason for your vacation';
                  }
                  if (value.length < 10) {
                    return 'Please provide a more detailed reason (min. 10 characters)';
                  }
                  return null;
                },
                onChanged: (value) {
                  _vacationRequest.updateReason(value ?? '');
                  _updateUnsavedChanges();
                },
                onSaved: (value) {
                  _vacationRequest.updateReason(value ?? '');
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Contact Information *',
                  border: OutlineInputBorder(),
                  hintText: 'Phone number or email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your contact information';
                  }
                  return null;
                },
                onChanged: (value) {
                  _vacationRequest.updateContactInfo(value ?? '');
                  _updateUnsavedChanges();
                },
                onSaved: (value) {
                  _vacationRequest.updateContactInfo(value ?? '');
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Submit Vacation Request',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  NavService().goBack();
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _reasonFocusNode.removeListener(_onFocusChange);
    _reasonFocusNode.dispose();
    super.dispose();
  }
}
