// ignore_for_file: non_constant_identifier_names

class BatchModel {
  String batchName;
  String batchType;
  String batch_Id;
  String course_Id;
  String course_Name;
  dynamic course;
  String startingTime;
  dynamic sessionsGivenNo;
  String status;
  String id;
  String instructorName;
  dynamic instructor;
  String session_Day;
  String session_Time;
  String whatsAppChannel;
  String batchPicture;
  dynamic students;
  dynamic enrollments;

  BatchModel({
    required this.batchName,
    required this.batchType,
    required this.batch_Id,
    required this.course_Id,
    required this.course_Name,
    required this.course,
    required this.startingTime,
    required this.sessionsGivenNo,
    required this.status,
    required this.id,
    required this.instructorName,
    required this.instructor,
    required this.session_Day,
    required this.session_Time,
    required this.whatsAppChannel,
    required this.batchPicture,
    required this.students,
    required this.enrollments,
  });

  factory BatchModel.fromJson(json) {
    return BatchModel(
      batchName: json['batchName'] ?? '',
      batchType: json['batchType'] ?? '',
      batch_Id: json['batch_Id'] ?? '',
      course_Id: json['course_Id'] ?? '',
      course_Name: json['course_Name'] ?? '',
      course: json['course'] ?? '',
      startingTime: json['startingTime'] ?? '',
      sessionsGivenNo: json['sessionsGivenNo'] ?? '',
      status: json['status'] ?? '',
      id: json['id'] ?? '',
      instructorName: json['instructorName'] ?? '',
      instructor: json['instructor'] ?? '',
      session_Day: json['session_Day'] ?? '',
      session_Time: json['session_Time'] ?? '',
      whatsAppChannel: json['whatsAppChannel'] ?? '',
      batchPicture: json['batchPicture'] ?? '',
      students: json['students'] ?? '',
      enrollments: json['enrollments'] ?? '',
    );
  }
}
