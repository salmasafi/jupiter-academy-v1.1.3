// ignore_for_file: unnecessary_string_interpolations, avoid_print

import 'package:dio/dio.dart';
import 'package:jupiter_academy/features/batches/logic/models/student_model.dart';
import '../../features/employees/logic/models/employee_model.dart';
import '../../features/batches/logic/models/batch_model.dart';
import '../../features/login/logic/models/user_model.dart';

class APiService {
  static String baseURL = 'https://web-api.jupiter-academy.org/api';

  Dio dio = Dio();

  Future<UserModel> getUserById(String id) async {
    Response response = await dio.get('$baseURL/User/$id');
    Map<String, dynamic> jsonData = response.data;

    return UserModel.fromJson(jsonData);
  }

  Future<String> getUserIdByLogin(String email, String password) async {
    Response response = await dio.post(
      '$baseURL/User/login',
      data: {
        "email": "$email",
        "password": "$password",
      },
    );
    Map<String, dynamic> json = response.data;
    switch (response.statusCode) {
      case 200:
        return json['user_id'];
      default:
        return 'Not Found';
    }
  }

  Future<String> changePassword(
    String id,
    String oldPassword,
    String newPassword,
  ) async {
    Response response = await dio.post(
      '$baseURL/User/changepassword/$id',
      data: {
        "oldPassword": "$oldPassword",
        "newPassword": "$newPassword",
      },
    );

    switch (response.statusCode) {
      case 200:
        return 'Done';
      default:
        return 'Error';
    }
  }

  Future<List<BatchModel>> getBatchById(String id) async {
    List<BatchModel> batchesList = [];
    Response response = await dio.get('$baseURL/Batches/instructor/$id');

    print('Response data: ${response.data}');

    Map<String, dynamic> jsonData = response.data;
    List batches = jsonData['data'];
    for (var batch in batches) {
      batchesList.add(BatchModel.fromJson(batch));
    }
    return batchesList;
  }

  Future<List<StudentModel>> getStudentsByBatchId(String id) async {
    List<StudentModel> studentsList = [];
    Response response =
        await dio.get('$baseURL/Enrollments/patch-students/$id');

    List jsonData = response.data;
    for (var student in jsonData) {
      studentsList.add(StudentModel.fromJson(student));
    }
    return studentsList;
  }

  Future<String> getUserImageById(String id) async {
    Response response = await dio.get('$baseURL/User/$id');
    Map<String, dynamic> jsonData = response.data;

    return jsonData['profileImagePath'];
  }

  Future<List<Employee>> getEmployees() async {
    try {
      final dio = Dio();
      final response = await dio.get('$baseURL/User/Employee');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        final List<Employee> fetchedEmployees = data
            .map((e) => Employee(
                  id: e['id'] ?? '',
                  name: e['name'] ?? '',
                  role: e['role'] ?? '',
                  branch: e['branch'] ?? '',
                  email: e['email'] ?? '',
                  phone: e['phone'] ?? '',
                  whatsApp: e['whatsApp'] ?? '',
                  getStartedAt: e['getStartedAt'] ?? '',
                  isActive: e['isActive'] ?? false,
                  profileImagePath: e['profileImagePath'] ??
                      'https://scontent.fcai19-8.fna.fbcdn.net/v/t39.30808-6/362285845_769142955221141_8396394440359555180_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=zVWvNXMHj-MQ7kNvgEuzo42&_nc_ht=scontent.fcai19-8.fna&oh=00_AYAkBdCPfnCFdieu4OuKo4b55WKeJ0aeg0v2xIWhD7poyw&oe=668F2FD6',
                  paymentInfo: e['paymentInfo'] ?? '',
                  basicSalary: e['paymentInfo'] ?? 0,
                  phoneNumber: e['phoneNumber'] ?? '',
                  userName: e['userName'] ?? '',
                ))
            .toList();

        for (int i = 0; i < fetchedEmployees.length; i++) {
          if (fetchedEmployees[i].role == 'manager' ||
              fetchedEmployees[i].role == 'Manager' ||
              fetchedEmployees[i].isActive == false ||
              fetchedEmployees[i].name == 'Sama Abdalla') {
            fetchedEmployees.removeAt(i);
          }
        }
        //fetchedEmployees.removeAt(0);

        return fetchedEmployees;
      } else {
        throw Exception('Failed to load employees');
      }
    } catch (e) {
      throw Exception('Failed to load employees: $e');
    }
  }

  Future<void> addABatch(BatchModel batchModel) async {
    Response response = await dio.post(
      '$baseURL/Batches',
      data: {
        "course_Id": "${batchModel.course_Id}",
        "startingTime": "${batchModel.startingTime}",
        "instructor_Id": "${batchModel.id}",
        "session_Day": "${batchModel.session_Day}",
        "session_Time": "${batchModel.session_Time}",
        "whatsAppChannel": "${batchModel.whatsAppChannel}",
        "batchType": "${batchModel.batch_Id}"
      },
    );
    // ignore: unused_local_variable
    Map<String, dynamic> json = response.data;
    switch (response.statusCode) {
      case 200:
        print('Batch has added successfully');
      default:
        print('Batch adding failed');
    }
  }

  Future<Response> changeProfileDetails({
    required UserModel userModel,
    String? role,
    String? address,
    String? email,
    String? whatsApp,
    String? phoneNumber,
    String? paymentInfo,
    String? branch,
  }) async {
    Response response = await dio.put(
      '$baseURL/User/${userModel.id}',
      data: {
        "id": userModel.id,
        "name": userModel.name,
        "role": role ?? userModel.role,
        "isActive": userModel.isActive,
        "address": address ?? userModel.address,
        "email": email ?? userModel.email,
        "whatsApp": whatsApp ?? userModel.whatsApp,
        "basicSalary": 0,
        "phoneNumber": phoneNumber ?? userModel.phoneNumber,
        "getStartedAt": userModel.getStartedAt,
        "profileImagePath": userModel.profileImagePath,
        "paymentInfo": paymentInfo ?? userModel.paymentInfo,
        "branch": branch ?? userModel.branch,
      },
    );

    return response;
  }

  Future<bool> changePaymentInfo({
    required UserModel userModel,
    required String cardNumber,
    required String cardHolderName,
  }) async {
    String paymentInfo =
        "Payment Method: InstaPay, Card/VFCash: $cardNumber, Holder Name: $cardHolderName";

    // ignore: unused_local_variable
    Response? response;

    try {
      response = await APiService().changeProfileDetails(
        userModel: userModel,
        paymentInfo: paymentInfo,
      );
    } catch (e) {
      print('errrrrrrrrrrrrorrrrrrrrrrrr $e');
      return false;
    }

    return true;
  }
}

/* Map<String, String> employeesIds = {
  'Mohamed Elsayed': '17235db5-6a36-4248-88ff-b29a11fe2024',
  'Rawan Magdy': '25194165-f2f3-4032-a621-3e0b1dc5adc3',
  'Mariam Galal': '2f9bdd87-367b-45c4-b384-77a205dc3f69',
  'Ahmad Fathy': '3904e335-fcab-49ce-bf55-3195f7d998c1',
  'Omar Eslam': '59016b5c-a17f-4918-9007-5e9aafc7cc51',
  'Amira Gomaa': '670b2538-9ff7-414d-9f21-dbe7b6bfa8a9',
  'Taghred Ali': '71fd5c38-35c1-4036-bbf7-8982139a1e84',
  'Yara Ibrahim': 'a54c334c-ba55-4f23-a213-9915c93426ae',
  'Salma Safi': 'd666da61-11ed-48d2-bee7-f994d85e6be0',
  'Eman Mohamed': 'dd5b0c4d-cf64-435f-a635-17a3e61b185e',
  'Mahmoud Mohamed': 'e48f4f73-363e-4d50-8463-f49c1a2a2a40',
}; */
