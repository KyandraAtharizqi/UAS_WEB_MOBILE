import 'package:flutter/material.dart';
import 'package:uasmobile/model/user_model.dart';
import 'package:uasmobile/controllers/navigation_manager.dart';

class UserProfilePage extends StatefulWidget {
  final User user; // Pass the user data to the page

  UserProfilePage({required this.user});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late TextEditingController favMovieController;
  late TextEditingController userDetailController;

  @override
  void initState() {
    super.initState();
    favMovieController = TextEditingController(text: widget.user.favmovie);
    userDetailController = TextEditingController(text: widget.user.userdetail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.user.usr,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Favorite Movies',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                  ),
                  Text(
                    widget.user.favmovie,
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'User Detail',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                  ),
                  Text(
                    widget.user.userdetail.length > 500
                        ? '${widget.user.userdetail.substring(0, 500)}...'
                        : widget.user.userdetail,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      NavigationManager.navigateToLoginPage(context);
                    },
                    child: Text('Logout'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}