import 'package:flutter/material.dart';
import '../../../login/logic/models/user_model.dart';
import '../../../profile_editing/presentation/views/profilescreen.dart';
import '/core/widgets/build_appbar_method.dart';
import 'theme_screen.dart';

class SettingsScreen extends StatelessWidget {
  final UserModel userModel;
  const SettingsScreen({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen(userModel: userModel,)),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Theme'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ThemeScreen()),
              );
            },
          ),
          
        ],
      ),
    );
  }
}