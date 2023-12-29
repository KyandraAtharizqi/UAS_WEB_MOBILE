// user_manager.dart
import 'package:uasmobile/model/user_model.dart';

class UserManager {
  static User? currentUser; // Update to allow null

  // Add a method to get the current user id
  static int getCurrentUserId() {
    return currentUser?.id ?? 0; // Replace 'id' with the actual field in User model
  }

  // Add a method to get the current username
  static String getCurrentUsername() {
    return currentUser?.usr ?? ""; // Replace 'usr' with the actual field in User model
  }
}