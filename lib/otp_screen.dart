import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'otp_generation.dart';
import 'details_screen.dart';

class OtpScreen extends StatefulWidget {
  @override
  State<OtpScreen> createState() => OtpScreenState();
}

class OtpScreenState extends State<OtpScreen> {
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  String alertMessage = '';
  String generatedOtp = '';

  @override
  void initState() {
    super.initState();
    generateNewOtp();
  }

  void generateNewOtp() {
    setState(() {
      generatedOtp = Otpgeneration.getCurrentCode();
      alertMessage = '';
    });
  }

  void checkOtp() {
    if (formKey.currentState!.validate()) {
      bool isOtpValid = Otpgeneration.verifyCode(otpController.text);

      if (isOtpValid) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DetailsScreen()),
        );
      } else {
        setState(() {
          alertMessage = 'Invalid or expired OTP';
        });
      }
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
        title: Text("OTP Verification"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.refresh, color: Colors.blueAccent),
                      onPressed: () {
                        generateNewOtp();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  labelText: "Enter 6-Digit OTP",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().length != 6) {
                    return 'Please enter 6 digits';
                  }
                  return null;
                },
              ),
              if (alertMessage.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    alertMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  checkOtp();
                },
                child: Text("Verify OTP", style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text("Back to Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
