import 'package:flutter/material.dart';
import 'package:pawstel/screens/hostel_owner/bookigrequest.dart';

class HomeHo2Page extends StatelessWidget {
  final String userEmail;

  HomeHo2Page({required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(150, 121, 105, 44),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('View Booking Requests'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewBookingPage(userEmail: userEmail),
                  ),
                );
              },
            ),
            // Add other ListTiles for navigation here
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/homeho.jpeg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, // Align children to the center
            children: [
              Transform.rotate(
                angle: 90 * 3.14159 / 180, // Rotate text vertically
                child: Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown, // Set text color to brown
                  ),
                ),
              ),
              SizedBox(height: 20), // Add space between rotated text and other content
              // Other widgets or content here
            ],
          ),
        ),
      ),
    );
  }
}
