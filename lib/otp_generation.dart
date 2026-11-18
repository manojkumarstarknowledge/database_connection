import 'package:otp/otp.dart';

class Otpgeneration {
  String secretKey = 'JBSWY3DPEHPK3PXP';

  String getCurrentCode() {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    String otpCode = OTP.generateTOTPCodeString(
      secretKey,
      currentTime,
      isGoogle: true,
      length: 4,
    );
    return otpCode;
  }


  bool verifyCode(String enteredCode) {
    String currentOtp = getCurrentCode();
    if (currentOtp == enteredCode.trim()) {
      return true;
    } else {
      return false;
    }
  }
}
