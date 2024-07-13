import 'package:flutter/material.dart';
import '../../../../core/api/api_service.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/build_appbar_method.dart';
import '../../../../core/widgets/errorwidget.dart';
import '../../../../core/widgets/loadingwidget.dart';
import '../widgets/my_drawer.dart';
import '../../../login/logic/models/user_model.dart';

String thisUserId = '';

class HomeScreenBuilder extends StatefulWidget {
  final String id;
  const HomeScreenBuilder({
    super.key,
    required this.id,
  });

  @override
  State<HomeScreenBuilder> createState() => _HomeScreenBuilderState();
}

class _HomeScreenBuilderState extends State<HomeScreenBuilder> {
  Future<UserModel> getUserModel() async {
    return await APiService().getUserById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: getUserModel(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const MyErrorWidget();
        } else if (snapshot.hasData) {
          thisUserId = snapshot.data!.id;
          return HomeScreen(
            userModel: snapshot.data!,
          );
        } else {
          return const MyLoadingWidget();
        }
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  final UserModel userModel;
  const HomeScreen({super.key, required this.userModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /* void showNotification() {
    flutterLocalNotificationsPlugin.show(
      0,
      'Testing Jupiter',
      'How are you?',
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: Importance.high,
          color: myPurple,
          playSound: true,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }
 */
  /* @override
  void initState() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: myPurple,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ),
          );
        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was Published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title ?? 'no title'),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.body ?? 'no body'),
                    ],
                  ),
                ),
              );
            });
      }
    });
    super.initState();
  }
 */

  @override
  Widget build(BuildContext context) {
    thisUserId = widget.userModel.id;
    return Scaffold(
      appBar: buildAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'WELCOME',
              style: Styles.style42,
            ),
            Text(
              widget.userModel.name,
              style: Styles.style36,
            ),
            /*widget.userModel.id == 'd666da61-11ed-48d2-bee7-f994d85e6be0' ? ElevatedButton(
              onPressed: (){},
              child: Text('send notification'),
            ):SizedBox(), */
           ],
        ),
      ),
      drawer: MyDrawer(
        userModel: widget.userModel,
      ),
    );
  }
}
