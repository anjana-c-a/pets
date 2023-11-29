import 'package:flutter/material.dart';
import 'package:pawstel/models/admin/admin_approved.dart';
import 'package:pawstel/models/admin/hostel_request.dart';
//import 'package:pawstel/models/admin/approved_hostel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AdminHomePage(),
    );
  }
}

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home'),
      ),
      body: Row(
        children: <Widget>[
          // Sidebar
          Container(
            width: 250,
            color: Colors.blueGrey, // Adjust sidebar color
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                ListTile(
                  leading: Icon(Icons.list),
                  title: Text('View Hostel Allocation Request'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HostelDetailsPage(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                ListTile(
                  leading: Icon(Icons.list),
                  title: Text('View Approved hostels'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HostelApprovedPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.people),
                  title: Text('User List'),
                  onTap: () {
                    // Handle tap
                  },
                ),
                ListTile(
                  leading: Icon(Icons.manage_accounts),
                  title: Text('Manage Users'),
                  onTap: () {
                    // Handle tap
                  },
                ),
              ],
            ),
          ),
          // Main content
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  'Welcome, Admin!',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
