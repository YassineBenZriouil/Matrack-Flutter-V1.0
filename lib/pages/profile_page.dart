import 'package:flutter/material.dart';
import '../main.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile';
  final String role;
  final String username;

  const ProfilePage({Key? key, this.role = 'Agent', this.username = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xFF0D47A1);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 44,
                backgroundColor: primaryColor.withOpacity(0.1),
                child: Icon(Icons.person, size: 60, color: primaryColor),
              ),
              SizedBox(height: 18),
              Text(
                role,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
              ),
              SizedBox(height: 8),
              Text(username.isNotEmpty ? username : 'agent@matricule.com', style: TextStyle(color: Colors.grey[700])),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, LoginPage.routeName);
                  },
                  icon: Icon(Icons.logout),
                  label: Text('Déconnexion', style: TextStyle(fontSize: 17)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 