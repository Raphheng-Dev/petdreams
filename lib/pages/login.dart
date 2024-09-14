import 'package:flutter/material.dart';
import 'dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _isLoading = false;

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate a network call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });

        // Here you'd typically check the user's credentials
        // For demo purposes, we'll just print them
        if (_email == 'test@example.com' && _password == 'password') {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login Successful!')),
          );
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Dashboard()),
          );
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid email or password')),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.lightBlueAccent),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Login', style: TextStyle(fontSize: 24)),
                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(color: Colors.lightBlueAccent),
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _email = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _password = value;
                  },
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _login,
                        child: const Text('Login'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
