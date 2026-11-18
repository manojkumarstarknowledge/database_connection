import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'otp_generation.dart';
import 'details_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen>
  createState() => OtpScreenState();
}

class OtpScreenState extends State<OtpScreen> {
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();

  Otpgeneration otpHelper = Otpgeneration();

  String otp = '';
  String message = '';

  @override
  void initState() {
    super.initState();
    otp = otpHelper.getCurrentCode();
  }

  void verifyOtp() {
    if (!formKey.currentState!.validate()) return;

    if (otpHelper.verifyCode(otpController.text)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsScreen(),
        ),
      );
    } else {
      setState(() {
        message = "Invalid OTP";
      });
    }
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Verification"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [

              Text(
                "OTP : $otp",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              IconButton(
                onPressed: () {
                  setState(() {
                    otp = otpHelper.getCurrentCode();
                    message = '';
                  });
                },
                icon: const Icon(Icons.refresh),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: otpController,
                maxLength: 4,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Enter OTP",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.length != 4) {
                    return "Enter 4 digit OTP";
                  }
                  return null;
                },
              ),

              if (message.isNotEmpty)
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: verifyOtp,
                child: const Text("Verify OTP"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                child: const Text("Back to Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
