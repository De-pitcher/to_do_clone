import 'package:flutter/material.dart';
import '../utils/res/theme.dart';

class ProfileAccount extends StatefulWidget {
  static const String id = '/profile_account_settings';
  const ProfileAccount({super.key});

  @override
  State<ProfileAccount> createState() => _ProfileAccountState();
}

class _ProfileAccountState extends State<ProfileAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(),
            accountName: const Text('User name'),
            accountEmail: const Text('User Email Address'),
            decoration: const BoxDecoration(),
            onDetailsPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(height: 10),
          const Divider(
            thickness: 2,
            color: Colors.white12,
            endIndent: 20,
            indent: 20,
          ),
          actionTile(context, Icons.add, 'Add account'),
          actionTile(context, Icons.manage_accounts, 'Manage accounts'),
          const SizedBox(height: 10),
          const Divider(
            thickness: 2,
            color: Colors.white12,
            endIndent: 20,
            indent: 20,
          ),
          const SizedBox(height: 10),
          actionTile(context, Icons.settings, 'Settings'),
        ],
      ),
    );
  }

  Widget actionTile(context, IconData icon, String action) {
    return ListTile(
      style: ListTileStyle.list,
      onTap: () {},
      leading: Icon(icon,
          color: ThemeMode.system == ThemeMode.light
              ? AppTheme.lightTheme.iconTheme.color
              : AppTheme.darkTheme.iconTheme.color),
      title: Text(
        action,
        style: ThemeMode.system == ThemeMode.light
            ? AppTheme.lightTheme.textTheme.bodySmall
            : AppTheme.darkTheme.textTheme.bodySmall,
      ),
    );
  }
}
