
Map<String, int> calculateTimeDifference({required String startTime, required String endTime}) {
  DateTime start = parseTime(startTime);
  DateTime end = parseTime(endTime);

  // حساب فارق الوقت بين الوقتين
  int differenceInSeconds = end.difference(start).inSeconds;

  // تحويل فارق الوقت إلى ساعات ودقائق وثواني
  int hours = differenceInSeconds ~/ 3600;
  int remainingSeconds = differenceInSeconds % 3600;
  int minutes = remainingSeconds ~/ 60;
  //int seconds = remainingSeconds % 60;

  // إرجاع الفارق كمخرج من نوع Map
  return {'hours': hours, 'minutes': minutes};
}

DateTime parseTime(String timeString) {
  List<String> parts = timeString.split(' '); // تقسيم السلسلة باستخدام الفراغ كفاصل
  String timePart = parts[0]; // الجزء الخاص بالوقت
  String amPmPart = parts[1]; // الجزء الخاص بـ AM/PM
  
  List<String> timeParts = timePart.split(':'); // تقسيم الوقت إلى ساعات ودقائق
  int hour = int.parse(timeParts[0]); // التحويل إلى عدد صحيح
  int minute = int.parse(timeParts[1]); // التحويل إلى عدد صحيح
  
  if (amPmPart.toLowerCase() == 'pm') {
    // إذا كان PM، قم بإضافة 12 ساعة للوقت إذا كانت الساعة ليست 12
    if (hour != 12) {
      hour += 12;
    }
  } else {
    // إذا كان AM والساعة 12، قم بتعيين الساعة إلى 0
    if (hour == 12) {
      hour = 0;
    }
  }
  
  return DateTime(0, 1, 1, hour, minute); // إنشاء وإرجاع كائن DateTime
}

