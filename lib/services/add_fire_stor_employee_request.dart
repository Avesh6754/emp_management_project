import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_management/modal/employee_request.dart';

class AddFireStoreEmployeeRequest {
  AddFireStoreEmployeeRequest._();

  static AddFireStoreEmployeeRequest addFireStoreRequest =
      AddFireStoreEmployeeRequest._();

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> addEmployeeRequest(EmployeeRequest employee) async {
    await _fireStore
        .collection("Employee Requests")
        .doc(employee.email)
        .set(EmployeeRequest.toMap(employee));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchEmployeeRequestData() {
    return _fireStore.collection("Employee Requests").snapshots();
  }

  Future<void> deleteData({required String email}) async {
    await _fireStore.collection("Employee Requests").doc(email).delete();
  }

  Future<void> update({required String email}) async {
    await _fireStore
        .collection("Employee Requests")
        .doc(email)
        .update({"status": "Approved"});
  }
}
