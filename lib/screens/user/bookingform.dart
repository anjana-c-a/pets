import 'package:flutter/material.dart';
//import 'package:pawstel/screens/hostel_owner/home_ho.dart';
//import 'package:pawstel/screens/user/home_po2.dart';
import 'package:pawstel/screens/user/log_user.dart';
import 'package:pawstel/utils/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class BookingForm extends StatefulWidget {
  final String hostelemail;
  final String hostelName;
  final String useremail;

  //const BookingForm({Key? key, required this.emailh, required this.hostelName}) : super(key: key);
  BookingForm(
      {required this.hostelName,
      required this.hostelemail,
      required this.useremail});

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  String selectedFoodOption = 'Default';
  bool showFoodDetails = false;
  DateTime? selectedDate;
  String foodDetails = '';
  String selectedPaymentOption = 'Cash'; // Default payment option

  @override
  Widget build(BuildContext context) {
    final TextEditingController dateController = TextEditingController();
    final TextEditingController foodDetailsController = TextEditingController();
    final TextEditingController custNameController = TextEditingController();
    final TextEditingController custPhoneController = TextEditingController();
    final TextEditingController daysController = TextEditingController();
    // final TextEditingController dateController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Form'),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/paws2.jpeg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      readOnly: true,
                      initialValue: widget.hostelName,
                      decoration: InputDecoration(
                        labelText: 'Hostel Name',
                        icon: Icon(Icons.business),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      readOnly: true,
                      initialValue: widget.hostelemail,
                      decoration: InputDecoration(
                        labelText: 'Hostel Email',
                        icon: Icon(Icons.email_sharp),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      readOnly: true,
                      initialValue: widget.useremail,
                      decoration: InputDecoration(
                        labelText: 'User Email',
                        icon: Icon(Icons.email_rounded),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    // SizedBox(height: 16.0),
                    // TextFormField(
                    //   controller: custNameController,
                    //   obscureText: true,
                    //   decoration: InputDecoration(
                    //     labelText: 'Customer Name',
                    //     icon: Icon(Icons.person),
                    //     filled: false,
                    //   ),
                    // ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: custNameController,
                      // initialValue: widget.useremail,
                      decoration: InputDecoration(
                        labelText: 'Customer Name',
                        icon: Icon(Icons.person_2),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: custPhoneController,
                      decoration: InputDecoration(
                        labelText: 'Customer Phone',
                        icon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: daysController,
                      decoration: InputDecoration(
                        labelText: 'No. of days',
                        icon: Icon(Icons.numbers),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    // TextFormField(
                    //   controller: custPhoneController,
                    //   obscureText: true,
                    //   decoration: InputDecoration(
                    //     labelText: 'Customer Phone No.',
                    //     icon: Icon(Icons.phone),
                    //     filled: false,
                    //   ),
                    // ),
                    SizedBox(height: 12),

// ...

                    TextFormField(
                      controller: dateController,
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != selectedDate) {
                          setState(() {
                            selectedDate = picked;
                            dateController.text =
                                DateFormat('MM-dd-yyyy').format(picked);
                          });
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Select Date',
                        icon: Icon(Icons.date_range),
                      ),
                    ),

                    SizedBox(height: 12),
                    Text(
                      'Select Food Option:',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Radio(
                          value: 'Default',
                          groupValue: selectedFoodOption,
                          onChanged: (value) {
                            setState(() {
                              selectedFoodOption = value.toString();
                              showFoodDetails = false;
                            });
                          },
                        ),
                        Text('Default'),
                        SizedBox(width: 20),
                        Radio(
                          value: 'Customizable',
                          groupValue: selectedFoodOption,
                          onChanged: (value) {
                            setState(() {
                              selectedFoodOption = value.toString();
                              showFoodDetails = true;
                            });
                          },
                        ),
                        Text('Customizable'),
                      ],
                    ),
                    if (showFoodDetails)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12),
                          TextFormField(
                            controller: foodDetailsController,
                            onChanged: (value) {
                              setState(() {
                                foodDetails = value;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Food Details',
                              hintText: 'Enter food details...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),

                    // Existing form fields...
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _addBooking(
                          context,
                          hostelname: widget.hostelName,
                          hostelemail: widget.hostelemail,
                          useremail: widget.useremail,
                          dateController: dateController,
                          daysController: daysController,
                          foodDetailsController: foodDetailsController,
                          custNameController: custNameController,
                          custPhoneController: custPhoneController,
                        );
                        // Perform booking confirmation logic here
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(205, 127, 50, 52),
                      ),
                      child: Text(
                        'Confirm Booking',
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
        ],
      ),
    );
  }

  Future<void> _addBooking(
    BuildContext context, {
    required String hostelname,
    required String hostelemail,
    required String useremail,
    required TextEditingController dateController,
    required TextEditingController foodDetailsController,
    required TextEditingController custNameController,
    required TextEditingController custPhoneController,
    required TextEditingController daysController,
  }) async {
    try {
      Database db1 = await DatabaseHelper.instance.database;

      int result = await db1.insert('bookings', {
        'hostel_name': hostelname,
        'hostel_email': hostelemail,
        'cust_email': useremail,
        'cust_name': custNameController.text,
        'cust_phone': custPhoneController.text,
        'date': dateController.text,
        'days': daysController.text,
        'food_option': foodDetailsController.text,
      });

      if (result != null && result > 0) {
        _showSuccessDialog(context);
      } else {
        print('Failed to insert data');
      }
    } catch (e) {
      print('Error inserting data: $e');
    }
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                ); // Navigate to LogUserPage
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
