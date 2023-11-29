// Import necessary packages
import 'package:flutter/material.dart';
import 'package:pawstel/screens/hostel_owner/home_ho.dart';
import 'package:pawstel/screens/user/home_po.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        // Add the hamburger icon to open the drawer
        actions: [
          IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Image using Image.asset
          Image.asset(
            'assets/images/paws3.jpeg', // Provide the correct asset path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Content Overlay
          //Container(
            //color:
              //  Colors.black.withOpacity(0.4), // Adjust the opacity as needed
          //),
          // Centered Heading
        Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'WELCOME TO PAWSTEL',
                  style: TextStyle(
                    color: Color.fromRGBO(110, 0, 0, 0.906),
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.0), // Adjust the spacing between heading and description
                Text(
                  'Pet Hostel Finder',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 168, 81, 81),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
          //fontStyle: FontStyle.italic, // Added italic style
          letterSpacing: 1.2, // Adjust spacing between characters
          // Other possible text styles you might consider:
          // decoration: TextDecoration.underline, // Add underline
          // decorationColor: Colors.blue, // Color for underline
          // decorationStyle: TextDecorationStyle.dashed,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: AppSidebar(),
    );
  }
}

class AppSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(150, 121, 105, 44),
            ),
            child: Text(
              'PAWSTEL',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Pet Owners'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePoPage()),
              );
            },
          ),
          ListTile(
            title: Text('Hostel Owners'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeHoPage()),
              );
            },
          ),
          // Add more items as needed
          ListTile(
            title: Text('Shopping'),
            onTap: () {
              // Handle item 2 tap
            },
          ),
        ],
      ),
    );
  }
}

