import 'package:flutter/material.dart';
import 'package:pawstel/screens/user/register_user.dart';
import 'package:pawstel/screens/user/log_user.dart';

class HomePoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Owners'),
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/hostelbg.jpeg'), // Replace 'your_image.jpg' with your actual image file
            fit: BoxFit.cover, // Adjust the fit based on your preference
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to the Pet Owners Page!',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(150, 121, 105, 44)),
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 20.0), // Add padding for better alignment
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: 16.0,
                        color: const Color.fromRGBO(72, 60, 50, 1)),
                    children: [
                      TextSpan(
                        text:
                            'Welcome to the Pet Owners Page, a dedicated space where you can effortlessly manage your pets needs. ',
                      ),
                      TextSpan(
                        text: 'Search and book nearby pet-friendly hostels, ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            'customize your pets stay by specifying food preferences, ',
                      ),
                      TextSpan(
                        text:
                            'and seamlessly shop for their favorite toys and treats—all in one place.',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(150, 121, 105, 44),
                ),
                child: Text('Register', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 16.0),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(150, 121, 105, 44),
                ),
                child: Text('Login', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
