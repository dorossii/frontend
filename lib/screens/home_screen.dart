import 'package:flutter/material.dart';
import 'package:authbase_mobile/services/auth_service.dart';
import 'package:authbase_mobile/services/auth_manager.dart';

class HomeScreen extends StatelessWidget {
  final UserInfo userInfo;
  final VoidCallback onLogout;

  const HomeScreen({
    super.key,
    required this.userInfo,
    required this.onLogout,
  });

  Future<void> _testApiAccess(BuildContext context) async {
    try {
      final response = await AuthManager.authenticatedRequest('/app/');

      if (context.mounted) {
        final message = response.statusCode == 200
            ? 'Access successful: ${response.body}'
            : 'Access failed: ${response.statusCode}';
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Information'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: onLogout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text('User ID'),
              subtitle: Text(userInfo.userId),
            ),
            ListTile(
              title: const Text('Name'),
              subtitle: Text(userInfo.name),
            ),
            ListTile(
              title: const Text('Email'),
              subtitle: Text(userInfo.email),
            ),
            ListTile(
              title: const Text('Provider Code'),
              subtitle: Text(userInfo.provCode),
            ),
            ListTile(
              title: const Text('Provider UID'),
              subtitle: Text(userInfo.provUid),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _testApiAccess(context),
                  child: const Text('Test API Access'),
                ),
                ElevatedButton(
                  onPressed: onLogout,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                  child: const Text('Logout', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
