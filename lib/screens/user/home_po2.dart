import 'package:flutter/material.dart';
import 'package:pawstel/screens/user/serachresult.dart';
import 'package:pawstel/utils/db_helper.dart';
import 'package:pawstel/screens/user/userbookings.dart';

class HomePo2Page extends StatefulWidget {
  final String userEmail;

  HomePo2Page({required this.userEmail});

  @override
  _HomePo2PageState createState() => _HomePo2PageState();
}

class _HomePo2PageState extends State<HomePo2Page> {
  late Future<List<Map<String, dynamic>>> userDetails;
  String? userName = '';
  String? email = ''; // Initialize userName variable to store the user's name

  @override
  void initState() {
    super.initState();
    _fetchUserDetailsAndName(widget.userEmail);
  }

  Future<void> _fetchUserDetailsAndName(String userEmail) async {
    try {
      DatabaseHelper db7 = DatabaseHelper.instance;
      List<Map<String, dynamic>> user =
          await db7.getUserDetailsByEmail(userEmail);
      if (user.isNotEmpty) {
        setState(() {
          userName = user.first['name'];
          // Assuming 'name' is the key for the user's name
        });
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  List<String> districts = [
    'Thiruvananthapuram',
    'Kollam',
    'Thrissur',
    // ... (other districts)
    'Kasaragod',
  ];

  String? selectedDistrict = 'Thiruvananthapuram'; // Default selected district
  String? petCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Home - District Search'),
        // Display the user's name in the app bar title
        title: Text(userName != null && userName!.isNotEmpty
            ? 'Welcome $userName'
            : 'Welcome'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Welcome $userName', // Display the user's name in the drawer header
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomePo2Page(userEmail: widget.userEmail),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Your Bookings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BookingsPage(userEmail: widget.userEmail),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Color(0xFFF3E5C3),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select District:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: DropdownButton<String>(
                  value: selectedDistrict,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDistrict = newValue;
                    });
                  },
                  items:
                      districts.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter pet category',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (String value) {
                  setState(() {
                    petCategory = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchList(
                        selectedCity: selectedDistrict,
                        petCategory: petCategory,
                        email: widget.userEmail,
                      ),
                    ),
                  );
                },
                child: Text('Search'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
