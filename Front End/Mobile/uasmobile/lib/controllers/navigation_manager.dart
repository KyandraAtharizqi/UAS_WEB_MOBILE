import 'package:flutter/material.dart';
import 'package:uasmobile/model/movie_model.dart';
import 'package:uasmobile/model/user_model.dart';
import 'user_manager.dart';

class NavigationManager {
  static void navigateToLoginPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  static void navigateToHomePage(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/home');
  }

  static void navigateToMovieDetailPage(BuildContext context, Movie movie) {
    Navigator.pushNamed(
      context,
      '/detail',
      arguments: movie,
    );
  }

  static void navigateToReviewPage(BuildContext context, Movie movie) {
    int currentUserId = UserManager.getCurrentUserId();
    String currentUsername = UserManager.getCurrentUsername();

    Navigator.pushNamed(
      context,
      '/review',
      arguments: {
        'movie': movie,
        'userId': currentUserId,
        'username': currentUsername,
      },
    );
  }

  static void navigateToUserProfilePage(BuildContext context) {
    Navigator.pushNamed(context, '/user-profile');
  }

  static void navigateToLoginAfterLogout(BuildContext context) {
   Navigator.pushNamed(context, '/login');
  }
}