import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'admin.dart'; // Admin Page का Import करें

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int _loginAttempts = 0; // Track the number of failed login attempts
  bool _isLoading = false; // Loading state indicator

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      // Attempt to sign in with email and password
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // If login is successful, navigate to Admin Page
      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminPage()),
        );
      }
    } catch (e) {
      // Handle login failure
      setState(() {
        _loginAttempts++; // Increment login attempt count
        _isLoading = false;
      });

      if (_loginAttempts >= 3) {
        // If 3 attempts fail, navigate to Home Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(toggleTheme: () {}, isDarkTheme: false)), // Redirect to Home Page
        );
      } else {
        // Display error message if login fails
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Invalid username or password. Attempts remaining: ${3 - _loginAttempts}'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              const Icon(
                Icons.account_circle,
                size: 100,
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 20),
              // Email TextField
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Password TextField
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                      : const Text('Login'),
                ),
              ),
              const SizedBox(height: 20),
              // Error message after failed attempts
              if (_loginAttempts > 0)
                Text(
                  'Failed attempts: $_loginAttempts/3',
                  style: const TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
