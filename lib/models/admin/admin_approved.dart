import 'package:flutter/material.dart';
import 'package:pawstel/utils/db_helper.dart';
//import 'dart:typed_data';
import 'dart:io';

class HostelApprovedPage extends StatefulWidget {
  @override
  _HostelDetailsPageState createState() => _HostelDetailsPageState();
}

class _HostelDetailsPageState extends State<HostelApprovedPage> {
  late Future<List<Map<String, dynamic>>> _hostelDetails;

  @override
  void initState() {
    super.initState();
    _hostelDetails = _fetchApprovedHostelDetails();
  }

  Future<List<Map<String, dynamic>>> _fetchApprovedHostelDetails() async {
    try {
      DatabaseHelper db = DatabaseHelper.instance;
      return await db.getApprovedHostelDetails();
    } catch (e) {
      print('Error fetching approved hostel details: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel Details'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200], // Background color of the page
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: _hostelDetails,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text('No hostel details available.'),
                );
              } else if (snapshot.hasError) {
                return Center(
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
                    columns: [
                      DataColumn(
                        label: Text('Hostel Name',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      DataColumn(
                        label: Text('owner_name',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      DataColumn(
                        label: Text('View More',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                    rows: snapshot.data!.map((hostel) {
                      return DataRow(cells: [
                        DataCell(Text(hostel['hostel_name'],
                            style: TextStyle(fontStyle: FontStyle.italic))),
                        DataCell(Text(hostel['owner_name'] ?? "",
                            style: TextStyle(color: Colors.blue))),
                        DataCell(
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewMoreDetails2Page(
                                      email: hostel['email'] ?? ""),
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

class ViewMoreDetails2Page extends StatelessWidget {
  final String email;

  ViewMoreDetails2Page({required this.email});

  Future<Map<String, dynamic>> _fetchHostelDetailsByEmail() async {
    try {
      DatabaseHelper db1 = DatabaseHelper.instance;
      List<Map<String, dynamic>> details =
          await db1.getApprovedHostelDetailsByEmail(email);
      if (details.isNotEmpty) {
        return details.first;
      }
      return {}; // Return an empty map if no details found
    } catch (e) {
      print('Error fetching hostel details by email: $e');
      return {}; // Return an empty map on error
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchHostelDetailsByEmail(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text('View More Details'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: Text('View More Details'),
            ),
            body: Center(
              child: Text('No details available for this email.'),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text('View More Details'),
            ),
            body: Center(
              child: Text('Error fetching data'),
            ),
          );
        } else {
          Map<String, dynamic> hostelDetails = snapshot.data!;

          File? _image1 = File(hostelDetails['image1']);
          File? _image2 = File(hostelDetails['image2']);

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
                      hostelDetails['hostel_name'] ?? 'Hostel Name',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Image.file(
                    _image1, // Placeholder for null or empty image data
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Image.file(
                    _image2, // Placeholder for null or empty image data
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Owner: ${hostelDetails['owner_name'] ?? 'N/A'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  
                  SizedBox(height: 16),
                  Text(
                    'Pets Allocated: ${hostelDetails['pets_allocated'] ?? 'N/A'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No of Pets That Can Be Allocated: ${hostelDetails['number_of_pets'] ?? 'N/A'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Address: ${hostelDetails['address'] ?? 'N/A'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'City: ${hostelDetails['city'] ?? 'N/A'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Licence Number: ${hostelDetails['licence_number'] ?? 'N/A'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Phone: ${hostelDetails['phone_number'] ?? 'N/A'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Amount for 1 day: ${hostelDetails['price']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Email: ${hostelDetails['email'] ?? 'N/A'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  // Add other details and images here...
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
