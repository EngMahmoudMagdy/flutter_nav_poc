// lib/models/vacation_request.dart
class VacationRequest {
  String employeeName;
  String employeeId;
  DateTime startDate;
  DateTime endDate;
  String reason;
  String contactInfo;

  VacationRequest({
    required this.employeeName,
    required this.employeeId,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.contactInfo,
  });

  // Check if all required fields are filled
  bool get isComplete {
    return employeeName.isNotEmpty &&
        employeeId.isNotEmpty &&
        reason.isNotEmpty &&
        contactInfo.isNotEmpty;
  }

  // Check if dates are valid
  bool get hasValidDates {
    return endDate.isAfter(startDate) || endDate.isAtSameMomentAs(startDate);
  }

  // Update methods for real-time updates
  void updateEmployeeName(String name) {
    employeeName = name.trim();
  }

  void updateEmployeeId(String id) {
    employeeId = id.trim();
  }

  void updateReason(String reasonText) {
    reason = reasonText.trim();
  }

  void updateContactInfo(String contact) {
    contactInfo = contact.trim();
  }

  void updateStartDate(DateTime date) {
    startDate = date;
  }

  void updateEndDate(DateTime date) {
    endDate = date;
  }
}