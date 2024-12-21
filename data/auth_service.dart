import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'OTPVerificationPage.dart'; // Ensure this path is correct

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendOTP(BuildContext context, String mobile) async {
    final String fullMobileNumber =
        mobile; // Correct country code already included in RegisterPage

    await _auth.verifyPhoneNumber(
      phoneNumber: fullMobileNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-sign in on Android (if possible)
        await _auth.signInWithCredential(credential);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Phone number automatically verified!')),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid phone number. Please try again.')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Verification failed. Error: ${e.message}')),
          );
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        print('Verification ID: $verificationId'); // Debug Print
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPVerificationPage(
              verificationId: verificationId,
              mobile: mobile,
              name: '', // Use actual name if needed
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print(
            'Code auto-retrieval timeout. VerificationId: $verificationId'); // Debug Print
      },
    );
  }

  Future<void> verifyOTP(
      BuildContext context, String verificationId, String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      await _auth.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Phone number verified successfully!')),
      );
      // Navigate to another screen if needed
    } catch (e) {
      print('Error verifying OTP: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error verifying OTP. Please try again.')),
      );
    }
  }
}
