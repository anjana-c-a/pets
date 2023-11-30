import 'package:flutter/material.dart';
import 'package:pawstel/screens/user/log_user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pawstel/utils/db_helper.dart';

class RegistrationPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Registration'),
      ),
         body: Container(
        decoration: BoxDecoration(
          //color: Colors.black.withOpacity(1),
          image: DecorationImage(
            image: AssetImage('assets/images/reguser.jpeg'),
            fit: BoxFit.cover, // Adjust this to your preference
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 8.0,
              color: Colors.white.withOpacity(0.8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        icon: Icon(Icons.person),
                        filled: false,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        icon: Icon(Icons.account_circle),
                        filled: false,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        icon: Icon(Icons.email),
                        filled: false,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        icon: Icon(Icons.lock),
                        filled: false,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
    primary: const Color.fromRGBO(205, 127, 50, 52), // Set the background color here
  ),
                      onPressed: () {
                        _registerUser(context);
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _registerUser(BuildContext context) async {
    Database db1 = await DatabaseHelper.instance.database;

    // Check if the email already exists in the 'user' table
    List<Map<String, dynamic>> existingEmail = await db1.query(
      'users',
      where: 'email = ?',
      whereArgs: [emailController.text],
    );

    if (existingEmail.isNotEmpty) {
      // Email already exists, show dialog
      _showEmailAlreadyRegisteredDialog(context);
    } else {
      // Email doesn't exist, proceed with insertion
      int result = await db1.insert('users', {
        'name': nameController.text,
        'username': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      });

      if (result != null && result > 0) {
        _showSuccessDialog(context);
      } else {
        print('Failed to insert data');
      }
    }
  }

  void _showEmailAlreadyRegisteredDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Email Already Registered'),
          content: Text('The provided email is already registered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registration Successful'),
          content: Text('User data has been stored in SQLite.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        LoginPage())); // Navigate to LogUserPage
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
