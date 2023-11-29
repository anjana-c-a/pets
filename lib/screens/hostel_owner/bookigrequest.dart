import 'package:flutter/material.dart';
import 'package:pawstel/utils/db_helper.dart';
//import 'dart:typed_data';
//import 'dart:io';

class ViewBookingPage extends StatefulWidget {
  final String userEmail;

  ViewBookingPage({required this.userEmail});

  @override
  _ViewBookingPageState createState() => _ViewBookingPageState();
}

class _ViewBookingPageState extends State<ViewBookingPage> {
  late Future<List<Map<String, dynamic>>> _bookingDetails;

  @override
  void initState() {
    super.initState();
    _bookingDetails = _fetchBookingDetails();
  }

  Future<List<Map<String, dynamic>>> _fetchBookingDetails() async {
    try {
      // Assuming db1 is an instance of your DatabaseHelper class
      DatabaseHelper db = DatabaseHelper.instance;
      return await db.getBookingDetails(widget.userEmail);
      // Use widget.userEmail to access the userEmail passed to the StatefulWidget
    } catch (e) {
      print('Error fetching _bookingDetails details: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200], // Background color of the page
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: _bookingDetails,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No Bookings availabe.'),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error fetching data'),
                );
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateColor.resolveWith((states) =>
                        Colors.grey[400]!), // Background color of heading row
                    dataRowColor: MaterialStateColor.resolveWith((states) =>
                        Colors.white), // Background color of data rows
                    columns: const [
                      DataColumn(
                        label: Text('Name',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      DataColumn(
                        label: Text('Date',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      DataColumn(
                        label: Text('View More',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                    rows: snapshot.data!.map((_bookingDetails) {
                      return DataRow(cells: [
                        DataCell(Text(_bookingDetails['cust_name'] ?? "",
                            style:
                                const TextStyle(fontStyle: FontStyle.italic))),
                        DataCell(Text(_bookingDetails['date'] ?? "",
                            style: const TextStyle(color: Colors.blue))),
                        // DataCell(Text(_bookingDetails['date'] ?? "",
                        // style: const TextStyle(color: Colors.blue))),
                        DataCell(
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewMoreDetailsPage(
                                      email: _bookingDetails['cust_email']),
                                ),
                              );
                            },
                            child: Text('View More'),
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class ViewMoreDetailsPage extends StatelessWidget {
  final String email;

  ViewMoreDetailsPage({required this.email});

  Future<Map<String, dynamic>> _fetchBookingDetailsByCust() async {
    try {
      DatabaseHelper db1 = DatabaseHelper.instance;
      List<Map<String, dynamic>> details = await db1.getBookingDetailsByCust(email);
      if (details.isNotEmpty) {
        return details.first;
      }
      return {}; // Return an empty map if no details found
    } catch (e) {
      print('Error fetching _bookingDetails details by email: $e');
      return {}; // Return an empty map on error
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchBookingDetailsByCust(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('View More Details'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('View More Details'),
            ),
            body: const Center(
              child: Text('No details available for this email.'),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('View More Details'),
            ),
            body: const Center(
              child: Text('Error fetching data'),
            ),
          );
        } else {
          Map<String, dynamic> _bookingDetailsDetails = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: Text('View More Details'),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _bookingDetailsDetails['_bookingDetails_name'] ??
                          'Booking Details',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 16),
                  Text(
                    'Customer Name: ${_bookingDetailsDetails['cust_name'] }',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Date: ${_bookingDetailsDetails['date'] ?? 'N/A'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No of days: ${_bookingDetailsDetails['days'] ?? 'N/A'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Food Preference: ${_bookingDetailsDetails['food_option'] ?? 'N/A'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  

                 
                  // Add other details and images here...
                ],
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // ElevatedButton(
                  //   onPressed: () {
                  //     _acceptAction(context, _bookingDetailsDetails);
                  //   },
                  //   child: Text('Accept'),
                  // ),
                  // ElevatedButton(
                  //   // onPressed: () {
                  //   //   _rejectAction(context, _bookingDetailsDetails);
                  //   // },
                  //   child: Text('Reject'),
                  // ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

//   void _acceptAction(
//       BuildContext context, Map<String, dynamic> _bookingDetailsDetails) async {
//     try {
//       DatabaseHelper db4 = DatabaseHelper.instance;

//       await db4.add_bookingDetailsToAdminApproval(
//           _bookingDetailsDetails, 'accept'); // Passing 'accept'

//       await db4.delete_bookingDetailsOwner(_bookingDetailsDetails['email']);

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('_bookingDetails accepted')),
//       );
//     } catch (e) {
//       print('Error accepting _bookingDetails: $e');
//       // Handle the error
//     }
//   }

//   void _rejectAction(
//       BuildContext context, Map<String, dynamic> _bookingDetailsDetails) async {
//     try {
//       DatabaseHelper db4 = DatabaseHelper.instance;

//       await db4.add_bookingDetailsToAdminApproval(
//           _bookingDetailsDetails, 'reject'); // Passing 'reject'

//       await db4.delete_bookingDetailsOwner(_bookingDetailsDetails['email']);

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('_bookingDetails rejected')),
//       );
//     } catch (e) {
//       print('Error rejecting _bookingDetails: $e');
//       // Handle the error
//     }
//   }
// }
}
