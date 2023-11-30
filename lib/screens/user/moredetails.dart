import 'package:flutter/material.dart';
//import 'dart:typed_data';
import 'package:pawstel/screens/user/bookingform.dart';
import 'dart:io';

class MoreDetailsUser extends StatelessWidget {
  final Map<String, dynamic> hostel;
  final String? email;

  //const MoreDetailsUser({Key? key, required this.hostel}) : super(key: key);
  MoreDetailsUser({required this.hostel, required this.email});
  @override
  Widget build(BuildContext context) {
    File? _image1 = File(hostel['image1']);
    File? _image2 = File(hostel['image2']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel Details'),
      ),
      // backgroundColor: Color(0xFFF3E0C5),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 200,
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: _image1 != null
                      ? Image.file(
                          _image1,
                          fit: BoxFit.cover,
                        )
                      : Placeholder(), // Placeholder for missing image
                ),
                Container(
                  width: 200,
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: _image2 != null
                      ? Image.file(
                          _image2,
                          fit: BoxFit.cover,
                        )
                      : Placeholder(), // Placeholder for missing image
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              hostel['hostel_name'],
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Address: ${hostel['address']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 12),
            Text(
              'Email: ${hostel['email']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 12),
            Text(
              'Phone: ${hostel['phone_number']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Price for 1 day: ${hostel['price']}',
              style: TextStyle(fontSize: 18),
            ),
            Spacer(), // To push the button to the bottom
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingForm(
                      hostelemail: hostel['email'],
                      hostelName: hostel['hostel_name'],
                      useremail: email ?? '',
                    ), // Navigate to BookingForm
                  ),
                );
              },
              child: Text('Book Now'),
            ),
          ],
        ),
      ),
    );
  }
}
