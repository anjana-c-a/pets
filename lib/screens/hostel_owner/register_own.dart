import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawstel/screens/hostel_owner/home_ho.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:path/path.dart';
import 'package:pawstel/utils/db_helper.dart';


class RegistrationPageown extends StatefulWidget {
  @override
  _RegistrationPageownState createState() => _RegistrationPageownState();
}

class _RegistrationPageownState extends State<RegistrationPageown> {
  final TextEditingController hostelNameController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController petsAllocatedController = TextEditingController();
  final TextEditingController numberOfpets = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController licenceNumberController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // ... other controllers for text fields

  File? _image1;
  File? _image2;

  final ImagePicker _picker = ImagePicker();

  Future getImage(ImageSource source, int imageNumber) async {
    final pickedFile = await _picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        if (imageNumber == 1) {
          _image1 = File(pickedFile.path);
        } else {
          _image2 = File(pickedFile.path);
        }
      } else {
        print('No image selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel Owner Registration'),
      ),
      body: Container(
        decoration: BoxDecoration(
            // ... your gradient decoration
            ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Card(
              elevation: 8.0,
              color: Colors.white70, // Beige color for the card
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: hostelNameController,
                      decoration: InputDecoration(
                        labelText: 'Hostel Name',
                        icon: Icon(Icons.business),
                        filled: false,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: ownerNameController,
                      decoration: InputDecoration(
                        labelText: 'Owner Name',
                        icon: Icon(Icons.person),
                        filled: false,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: petsAllocatedController,
                      decoration: InputDecoration(
                        labelText: 'Pets Allocated',
                        icon: Icon(Icons.pets),
                        filled: false,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: numberOfpets,
                      decoration: InputDecoration(
                        labelText: 'No. of pets allocated',
                        icon: Icon(Icons.pets),
                        filled: false,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        icon: Icon(Icons.place),
                        filled: false,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: cityController,
                      decoration: InputDecoration(
                        labelText: 'City',
                        icon: Icon(Icons.place_rounded),
                        filled: false,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: licenceNumberController,
                      decoration: InputDecoration(
                        labelText: 'Licence number',
                        icon: Icon(Icons.numbers),
                        filled: false,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        icon: Icon(Icons.phone),
                        filled: false,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: priceController,
                      decoration: InputDecoration(
                        labelText: 'Price for 1 day',
                        icon: Icon(Icons.attach_money),
                        filled: false,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        icon: Icon(Icons.email),
                        filled: false,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        icon: Icon(Icons.lock),
                        filled: false,
                      ),
                    ),

                    // Image 1 Selection
                    // Image 1 Selection
                    Column(
                      children: [
                        Text('Upload Images'),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                getImage(ImageSource.gallery, 1);
                              },
                              child: _image1 != null
                                  ? Image.file(
                                      _image1!,
                                      height: 100,
                                      width: 100,
                                    )
                                  : Container(
                                      height: 100,
                                      width: 100,
                                      color: Colors.grey.withOpacity(0.3),
                                      child: Icon(Icons.add_photo_alternate),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Image 2 Selection
                    Column(
                      children: [
                        Text(' '),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                getImage(ImageSource.gallery, 2);
                              },
                              child: _image2 != null
                                  ? Image.file(
                                      _image2!,
                                      height: 100,
                                      width: 100,
                                    )
                                  : Container(
                                      height: 100,
                                      width: 100,
                                      color: Colors.grey.withOpacity(0.3),
                                      child: Icon(Icons.add_photo_alternate),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _registerHostelOwner(context);
                      },
                      child: Text('Register'),
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

  Future<void> _registerHostelOwner(BuildContext context) async {
    Database db1 = await DatabaseHelper.instance.database;

    int result = await db1.insert('hostelowners', {
      'hostel_name': hostelNameController.text,
      'owner_name': ownerNameController.text,
      'pets_allocated': petsAllocatedController.text,
      'number_of_pets': numberOfpets.text,
      'address': addressController.text,
      'city': cityController.text,
      'licence_number': licenceNumberController.text,
      'phone_number': phoneNumberController.text,
      'price': priceController.text,
      'email': emailController.text,
      'password': passwordController.text,
      // ... other text fields
      'image1': _image1 != null ? _image1!.path : null,
      'image2': _image2 != null ? _image2!.path : null,
    });

    if (result != null && result > 0) {
      _showSuccessDialog(context);
    } else {
      print('Failed to insert data');
    }
  }

  // ... _showSuccessDialog and other methods remain unchanged
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Request Submitted Successfully'),
          content: Text('Request for hostel owners submitted successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomeHoPage(), // Navigate to HomeHO2Page
                ));
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
