import 'package:flutter/material.dart';
import 'package:test_drive/pages/login.dart';
import 'references.dart';
import '../components/sidebar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Widget _currentPage = const ReferencesPage();

  void _selectPage(Widget page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _logout() {
    // Implement your logout logic here
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
    const SnackBar(content: Text('Logged out Successful!'));
    // print("Logged out");
    // You may want to navigate to a login page or perform any necessary cleanup
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Sidebar Navigation')),
      body: Row(
        children: [
          Sidebar(onSelectPage: _selectPage, onLogout: _logout),
          Expanded(child: _currentPage),
        ],
      ),
    );
  }
}
