import 'package:flutter/material.dart';
import 'package:to_do_clone/screens/manage_account/add_account.dart';

import '../../utils/res/theme.dart';
import 'accounts.dart';
import 'settings.dart';

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
            currentAccountPicture: const CircleAvatar(
              child: Placeholder(),
            ),
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
          actionTile(context, Icons.add, 'Add account',
              () => Navigator.of(context).pushNamed(AddAccount.id)),
          actionTile(context, Icons.manage_accounts, 'Manage accounts',
              () => Navigator.of(context).pushNamed(Accounts.id)),
          const SizedBox(height: 10),
          const Divider(
              thickness: 2, color: Colors.white12, endIndent: 20, indent: 20),
          const SizedBox(height: 10),
          actionTile(context, Icons.settings, 'Settings',
              () => Navigator.of(context).pushNamed(Settings.id)),
        ],
      ),
    );
  }

  Widget actionTile(
      context, IconData icon, String action, void Function()? ontap) {
    return ListTile(
      style: ListTileStyle.list,
      onTap: ontap,
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
