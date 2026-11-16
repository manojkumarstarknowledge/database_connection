import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'otp_generation.dart';
import 'details_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => OtpScreenState();
}

class OtpScreenState extends State<OtpScreen> {
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  String errorMessage = '';
  String generatedOtp = '';

  @override
  void initState() {
    super.initState();
    generateNewOtp();
  }

  void generateNewOtp() => setState(() {
    generatedOtp = Otpgeneration.getCurrentCode();
    errorMessage = '';
  });

  void checkOtp() {
    if (!formKey.currentState!.validate()) return;

    if (Otpgeneration.verifyCode(otpController.text)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DetailsScreen()),
      );
    } else {
      setState(() => errorMessage = 'OTP expired.');
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
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("OTP Verification"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Your OTP: $generatedOtp",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh, color: Colors.blueAccent),
                      onPressed: generateNewOtp,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: const InputDecoration(
                  labelText: "Enter 6-Digit OTP",
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                (v == null || v.trim().length != 6) ? 'Enter 6 digits' : null,
              ),
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: checkOtp,
                  child: const Text("Verify OTP", style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                ),
                child: const Text("Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
