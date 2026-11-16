import 'package:otp/otp.dart';

class Otpgeneration {
  static String getCurrentCode() => OTP.generateTOTPCodeString(
    'JBSWY3DPEHPK3PXP',
    DateTime.now().millisecondsSinceEpoch,
    isGoogle: true,
  );

  static bool verifyCode(String code) => getCurrentCode() == code.trim();
}
