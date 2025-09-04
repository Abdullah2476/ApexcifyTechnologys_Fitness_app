import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_track/features/core/theme/app_colors.dart';
import 'package:fit_track/features/fit_track/presentations/auth/login.dart';
import 'package:fit_track/features/fit_track/presentations/bottomNavigation/navigation_pages/profilePage.dart';
import 'package:fit_track/features/fit_track/providers/userinfo_provider/user_provider.dart';
import 'package:fit_track/features/shared/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(currentUserStreamProvider);
    final user = userData.asData?.value;
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              boxShadow: [BoxShadow(color: Colors.yellow.withOpacity(0.15))],
            ),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.transparentBackground,
                      radius: 32,
                      child: Icon(
                        Icons.person,
                        color: AppColors.yelow,
                        size: 40,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          bigTextexpanded(user?.name ?? ''),
                          smallBOldTextgrey('Stronger Every Day 💪'),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Profilepage();
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: 40,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: AppColors.yelow),
                        ),
                        child: Center(
                          child: smallBOldTextWhite("View Profile"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          tileText("General"),
          settingsCard(
            icon: Icons.person,
            title: "Account",
            subtitle: "Manage your account settings",
            onTap: () {},
          ),
          settingsCard(
            icon: Icons.notifications,
            title: "Notifications",
            subtitle: "Push, email, and SMS alerts",
            onTap: () {},
          ),
          settingsCard(
            icon: Icons.mode_night,
            title: "Dark Mode",
            subtitle: "Switch between light and dark theme",
            trailing: Switch(
              value: true,
              activeColor: Colors.yellow,
              onChanged: (val) {},
            ),
          ),

          const SizedBox(height: 20),
          tileText("More"),
          settingsCard(
            icon: Icons.info,
            title: "About",
            subtitle: "App version, terms, policies",
            onTap: () {},
          ),
          settingsCard(
            icon: Icons.login,
            title: "Logout",
            subtitle: "Sign out of your account",
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget settingsCard({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [BoxShadow(color: Colors.yellow.withOpacity(0.15))],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: Colors.yellow, size: 28),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle:
            subtitle != null
                ? Text(
                  subtitle,
                  style: TextStyle(color: Colors.white.withOpacity(0.6)),
                )
                : null,
        trailing:
            trailing ??
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.white54,
            ),
      ),
    );
  }

  Widget tileText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
