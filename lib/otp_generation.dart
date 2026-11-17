import 'package:otp/otp.dart';

class Otpgeneration {
  static String secretKey = 'JBSWY3DPEHPK3PXP';

  static String getCurrentCode() {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    String otpCode = OTP.generateTOTPCodeString(
      secretKey,
      currentTime,
      length: 4,
    );
    return otpCode;
  }

  static bool verifyCode(String enteredCode) {
    String currentOtp = getCurrentCode();
    if (currentOtp == enteredCode.trim()) {
      return true;
    } else {
      return false;
    }
  }
}
