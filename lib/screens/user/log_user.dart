import 'package:flutter/material.dart';
import 'package:pawstel/screens/user/home_po2.dart';
import 'package:pawstel/models/admin/home_admin.dart'; // Import HomeAdmin
import 'package:sqflite/sqflite.dart';
import 'package:pawstel/utils/db_helper.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          //color: Colors.black.withOpacity(1),
          image: DecorationImage(
            image: AssetImage('assets/images/loguser.jpeg'),
            fit: BoxFit.cover, // Adjust this to your preference
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 8.0,
              color: Colors.white.withOpacity(0.8), // Beige color for the card
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
    primary: const Color.fromRGBO(205, 127, 50, 52), // Set the background color here
  ),
                      onPressed: () {
                        _loginUser(context);
                      },
                      child: Text(
                        'Login',
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

  Future<void> _loginUser(BuildContext context) async {
    Database db = await DatabaseHelper.instance.database;

    final String adminEmail = 'admin1@gmail.com';
    final String adminPassword = 'admin@123';

    if (emailController.text == adminEmail &&
        passwordController.text == adminPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminHomePage()),
      );
    } else {
      List<Map<String, dynamic>> user = await db.query(
        'users',
        where: 'email = ? AND password = ?',
        whereArgs: [emailController.text, passwordController.text],
      );

      if (user.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePo2Page(userEmail: emailController.text),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Failed'),
              content: Text('Invalid email or password.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}
