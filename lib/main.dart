import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/api/notification_api.dart';
import 'core/cubit/jupiter_cubit.dart';
import 'core/widgets/jupiter_widget.dart';
import 'core/widgets/loadingwidget.dart';
import 'features/attendance/logic/attendance_screen_builder.dart';
import 'features/login/presentation/views/loginscreen.dart';
import 'features/home/presentation/views/homescreen.dart';
import 'features/login/logic/models/user_model.dart';
import 'core/api/api_service.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
String? employeeIdNotifi;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationApi().initNotifacations();
  NotificationApi().configLocalNotifi();
  await NotificationHandler.initialize();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('userId');
  }

  Widget _buildHomeScreen() {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const JupiterWidget();
        } else if (snapshot.hasData) {
          final prefs = snapshot.data!;
          final userId = prefs.getString('userId')!;
          return FutureBuilder<UserModel>(
            future: APiService().getUserById(userId),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const JupiterWidget();
              } else if (userSnapshot.hasData) {
                return HomeScreen(userModel: userSnapshot.data!);
              } else {
                return const LoginScreen();
              }
            },
          );
        } else {
          return const LoginScreen();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JupiterCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        home: FutureBuilder<bool>(
          future: _checkLoginStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const MyLoadingWidget();
            } else if (snapshot.hasData && snapshot.data == true) {
              return _buildHomeScreen();
            } else {
              return const LoginScreen();
            }
          },
        ),
        onGenerateRoute: generateRoute,
      ),
    );
  }
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/attendance':
      return MaterialPageRoute(builder: (context) => AttendanceScreenBuilder(id: employeeIdNotifi ?? ''));
    default:
      return MaterialPageRoute(builder: (context) => LoginScreen());
  }
}

class NotificationHandler {
  static Future<void> initialize() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // تعامل مع الإشعار عندما يكون التطبيق مفتوحاً
      print('Received a message while in foreground: ${message.notification}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // توجيه المستخدم إلى الصفحة المستهدفة عند النقر على الإشعار
      if (message.data.containsKey('page')) {
        String targetPage = message.data['page'];
        employeeIdNotifi = message.data['employeeId'];

        if (targetPage == 'attendance') {
          navigatorKey.currentState?.pushNamed('/attendance');
        }
      }
    });

    // إذا تم فتح التطبيق من خلال النقر على إشعار
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null && initialMessage.data.containsKey('page')) {
      String targetPage = initialMessage.data['page'];
      employeeIdNotifi = initialMessage.data['employeeId'];
      if (targetPage == 'attendance') {
        navigatorKey.currentState?.pushNamed('/attendance');
      }
    }
  }
}
