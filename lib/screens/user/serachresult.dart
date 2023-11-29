import 'package:flutter/material.dart';
import 'package:pawstel/utils/db_helper.dart';
import 'package:pawstel/screens/user/moredetails.dart';
//import 'dart:typed_data';
import 'dart:io';
class SearchList extends StatelessWidget {
  final String? selectedCity;
  final String? petCategory;
  final String? email;

  SearchList({required this.selectedCity, required this.petCategory, required this.email });

  @override
  Widget build(BuildContext context) {
    if (selectedCity != null && petCategory != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Pet Hostels in $selectedCity for $petCategory'),
        ),
         backgroundColor: Color(0xFFF3E0C5),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: DatabaseHelper.instance.getSearchHostel(selectedCity!, petCategory!),
          
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No pet hostels found for the selected criteria.'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final hostel = snapshot.data![index];
                  File? _image1 = File(hostel['image1']);
                  //File? _image2 = File(hostel['image2']);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MoreDetailsUser(hostel: hostel, email: email),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
                              child: Image.file(
                                _image1,
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    hostel['hostel_name'].toString().toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    'Location: ${hostel['city']}',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      );
    }
    return Scaffold();
  }
}
