import 'package:flutter/material.dart';
import 'package:pawstel/screens/hostel_owner/register_own.dart';
import 'package:pawstel/screens/hostel_owner/log_own.dart';

class HomeHoPage extends StatelessWidget {
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
      image: AssetImage('assets/images/petownbg.jpeg'), // Replace 'your_image.jpg' with your actual image file
      fit: BoxFit.cover, // Adjust the fit based on your preference
    ),
  ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to the Hostel Owners Page!',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: const Color.fromRGBO(128, 128, 0, 33)),
              ),
              SizedBox(height: 16.0),
              Text(
                'Hostel owners can apply for enrollment in our platform to showcase their hostel facilities. Once the application is submitted, our admin reviews and approves qualified hostel owners. Once accepted, owners gain access to manage bookings and allocate spaces based on the available seats. They can efficiently accommodate pets in accordance with the number of available seats, enhancing their hostels appeal to pet-loving guests',
                style: TextStyle(fontSize: 16.0, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationPageown()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                ),
                child: Text('Register', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 16.0),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPageown()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.teal),
                ),
                child: Text('Login', style: TextStyle(color: Colors.teal)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
