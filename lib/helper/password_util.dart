import 'package:bcrypt/bcrypt.dart';

class PasswordUtil {
  // generate hashpassword
  static String hashPassword(String password) {
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  // verify password and hashpassword
  static bool verifyPassword(String password, String hashedPassword) {
    return BCrypt.checkpw(password, hashedPassword);
  }
}
