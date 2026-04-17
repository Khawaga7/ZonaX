import 'package:flutter/material.dart';
import 'package:zona_x_16_4/features/auth/data/auth_service.dart';
import 'package:zona_x_16_4/core/theme/app_colors.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final authService = AuthService();
  
  void logout() async {
    await authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    // get user email
    final currentEmail = authService.getCurrentUserEmail();
    return Scaffold(
      backgroundColor: appColors.background,
      appBar: AppBar(
        backgroundColor: appColors.background,
        elevation: 0,
        title: Text(
          "Profile",
          style: TextStyle(color: appColors.textPrimary),
        ),
        actions: [
          //Log out button
          IconButton(
            onPressed: logout,
            icon: Icon(
              Icons.logout,
              color: appColors.accent,
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_circle_rounded,
                size: 80,
                color: appColors.accent,
              ),
              const SizedBox(height: 20),
              Text(
                "Welcome to ZonaX",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: appColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: appColors.inputBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: appColors.inputBorder),
                ),
                child: Column(
                  children: [
                    Text(
                      "Logged in as:",
                      style: TextStyle(
                        color: appColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      currentEmail ?? 'No user',
                      style: TextStyle(
                        color: appColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: logout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Text(
                    "Logout",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
