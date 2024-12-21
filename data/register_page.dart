import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'OTPVerificationPage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isTimerRunning = false;
  int _timeRemaining = 120; // 2 minutes timer for OTP resend

  @override
  void dispose() {
    super.dispose();
    _mobileController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _mobileController,
              decoration: InputDecoration(labelText: 'Mobile No'),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                // Add +91 if 10 digits are entered
                if (value.length == 10 && !value.startsWith("+91")) {
                  _mobileController.text = "+91$value";
                  _mobileController.selection = TextSelection.collapsed(
                      offset: _mobileController.text.length);
                }
              },
              maxLength: 10, // Restrict input to 10 digits
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final name = _nameController.text;
                String mobile = _mobileController.text;

                // Ensure the mobile number has +91 and 10 digits
                if (name.isEmpty || mobile.isEmpty || mobile.length != 13) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Please enter a valid 10-digit mobile number!')),
                  );
                  return;
                }

                // Send OTP to mobile
                await AuthService().sendOTP(context, mobile);

                // Start the timer
                setState(() {
                  _isTimerRunning = true;
                });
                _startTimer();

                // Navigate to OTP verification page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OTPVerificationPage(
                      mobile: mobile,
                      name: name,
                      verificationId: '',
                    ),
                  ),
                );
              },
              child: Text('Register'),
            ),
            if (_isTimerRunning)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Resend OTP in $_timeRemaining seconds',
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _startTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (_timeRemaining > 0 && _isTimerRunning) {
        setState(() {
          _timeRemaining--;
        });
        _startTimer();
      } else {
        setState(() {
          _isTimerRunning = false;
          _timeRemaining = 120; // Reset to 2 minutes when timer completes
        });
      }
    });
  }
}
