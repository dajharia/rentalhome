import 'package:flutter/material.dart';
import 'auth_service.dart';

class OTPVerificationPage extends StatefulWidget {
  final String mobile;
  final String name;
  final String verificationId;

  const OTPVerificationPage({super.key, 
    required this.mobile,
    required this.name,
    required this.verificationId,
  });

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final TextEditingController _otpController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Enter the OTP sent to ${widget.mobile}'),
            TextField(
              controller: _otpController,
              decoration: InputDecoration(labelText: 'OTP'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final otp = _otpController.text;
                if (otp.isEmpty || otp.length != 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid OTP!')),
                  );
                  return;
                }

                // Verify OTP
                await _authService.verifyOTP(context, widget.verificationId, otp);
              },
              child: Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
