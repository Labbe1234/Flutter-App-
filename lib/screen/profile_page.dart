import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key, required String username, required String email, required int age, required String imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: user != null
          ? Center(
              child: Card(
                elevation: 5,
                margin: EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: user.photoURL != null ? NetworkImage(user.photoURL!) : AssetImage('assets/default_avatar.png'), // You can use a default avatar image if user doesn't have one
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Username: ${user.displayName}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Email: ${user.email}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Age: 30', // You can replace '30' with the user's actual age if available
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : CircularProgressIndicator(), // Show loading indicator while fetching user data
    );
  }
}
