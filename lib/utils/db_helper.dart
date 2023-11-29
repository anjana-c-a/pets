import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database1.db');
    Database db1 = await openDatabase(
      path,
      version: 1,
      onCreate: (db1, version) async {
        await _createTables(db1);
      },
    );

    return db1;
  }

  Future<void> _createTables(Database db1) async {
    try {
      await db1.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        name TEXT,
        username TEXT,
        email TEXT,
        password TEXT
      )
    ''');

      await db1.execute('''
      CREATE TABLE hostelowners (
        id INTEGER PRIMARY KEY,
        hostel_name TEXT,
        owner_name TEXT,
        pets_allocated TEXT,
        number_of_pets TEXT,
        address TEXT,
        city TEXT,
        licence_number TEXT,
        phone_number TEXT,
        price TEXT,
        email TEXT,
        password TEXT,
        image1 TEXT,
        image2 TEXT
      )
    ''');
      await db1.execute('''
  CREATE TABLE adminapproved (
    id INTEGER PRIMARY KEY,
    hostel_name TEXT,
    owner_name TEXT,
    pets_allocated TEXT,
    number_of_pets TEXT,
    address TEXT,
    city TEXT,
    licence_number TEXT,
    phone_number TEXT,
    price TEXT,
    email TEXT,
    password TEXT,
    image1 TEXT,
    image2 TEXT,
    admin_decision TEXT DEFAULT ''
  )
''');
      await db1.execute('''
  CREATE TABLE bookings (
    id INTEGER PRIMARY KEY,
    hostel_name TEXT,
    hostel_email TEXT,
    cust_email TEXT,
    cust_name TEXT,
    cust_phone TEXT,
    date TEXT,
    days TEXT,
    food_option TEXT
  )
''');

await db1.execute('''
  CREATE TABLE confirmedbookings (
    id INTEGER PRIMARY KEY,
    hostel_name TEXT,
    hostel_email TEXT,
    cust_email TEXT,
    cust_name TEXT,
    cust_phone TEXT,
    date TEXT,
    days TEXT,
    food_option TEXT,
    decision TEXT
  )
''');

    } catch (e) {
      print('Error creating tables: $e');
    }
    Future<Map<String, dynamic>> getHostelDetailsByEmail(String email) async {
      try {
        final Database db2 = await database;
        List<Map<String, dynamic>> details = await db2.query(
          'hostelowners',
          where: 'email = ?',
          whereArgs: [email],
        );

        if (details.isNotEmpty) {
          return details.first;
        } else {
          // Handle if no details found
          return {};
        }
      } catch (e) {
        print('Error fetching hostel details by email: $e');
        return {};
      }
    }
  }

  // Future<List<Map<String, dynamic>>> getHostelDetails() async {
  //   try {
  //     final Database db = await database;
  //     return await db.query('hostelowners');
  //   } catch (e) {
  //     print('Error fetching hostel details: $e');
  //     return [];
  //   }
  // }
  Future<List<Map<String, dynamic>>> getHostelDetails() async {
    try {
      final Database db = await database;
      return await db.query(
        'hostelowners',
        columns: [
          'hostel_name',
          'owner_name',
          'email'
        ], // Specify columns to fetch
      );
    } catch (e) {
      print('Error fetching hostel details: $e');
      return []; // Return an empty list on error
    }
  }

  // Future<List<Map<String, dynamic>>> getAdminApprovedDetails() async {
  //   try {
  //     final Database db2 = await database;
  //     return await db2.query('adminapproved');
  //   } catch (e) {
  //     print('Error fetching hostel details: $e');
  //     return [];
  //   }
  // }
  Future<List<Map<String, dynamic>>> getAdminApprovedDetails() async {
    try {
      final Database db = await database;
      return await db.query(
        'adminapproved',
        columns: [
          'hostel_name',
          'owner_name',
          'email'
        ], // Specify columns to fetch
      );
    } catch (e) {
      print('Error fetching hostel details: $e');
      return []; // Return an empty list on error
    }
  }

  //  Future<List<Map<String, dynamic>>> getHostelDetailsByEmail(String email) async {
  //   final Database db3 = await instance.database;
  //   return await db3.query(
  //     'hostelowners',
  //     where: 'email = ?',
  //     whereArgs: [email],
  //   );
  // }
  Future<List<Map<String, dynamic>>> getHostelDetailsByEmail(
      String email) async {
    try {
      final Database db = await database;
      return await db.query(
        'hostelowners',
        columns: [
          'hostel_name',
          'owner_name',
          'pets_allocated',
          'number_of_pets',
          'address',
          'city',
          'licence_number',
          'phone_number',
          'price',
          'email',
          'password',
          'image1',
          'image2'
        ],
        where: 'email = ?',
        whereArgs: [email], // Specify columns to fetch
      );
    } catch (e) {
      print('Error fetching hostel details: $e');
      return []; // Return an empty list on error
    }
  }

  Future<void> addHostelToAdminApproval(
      Map<String, dynamic> hostelDetails, String decision) async {
    try {
      Database db4 = await instance.database;
      await db4.insert('adminapproved', {
        'hostel_name': hostelDetails['hostel_name'],
        'owner_name': hostelDetails['owner_name'],
        'pets_allocated': hostelDetails['pets_allocated'],
        'number_of_pets': hostelDetails['number_of_pets'],
        'address': hostelDetails['address'],
        'city': hostelDetails['city'],
        'licence_number': hostelDetails['licence_number'],
        'phone_number': hostelDetails['phone_number'],
        'price': hostelDetails['price'],
        'email': hostelDetails['email'],
        'password': hostelDetails['password'],
        'image1': hostelDetails['image1'],
        'image2': hostelDetails['image2'],
        // Add other fields...
        'admin_decision': decision, // Set admin decision here
      });
    } catch (e) {
      print('Error adding hostel to admin approval: $e');
      throw e;
    }
  }

  Future<void> deleteHostelOwner(String email) async {
    final db4 = await database;
    await db4.delete(
      'hostelowners',
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  Future<List<Map<String, dynamic>>> getApprovedHostelDetails() async {
    try {
      final Database db = await database;
      return await db.query('adminapproved',
          where: 'admin_decision = ?', whereArgs: ['accept']);
    } catch (e) {
      print('Error fetching approved hostel details: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getApprovedHostelDetailsByEmail(
      String email) async {
    final Database db3 = await instance.database;
    return await db3.query(
      'adminapproved',
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  Future<List<Map<String, dynamic>>> getSearchHostel(
      String selectedCity, String petCategory) async {
    final Database db6 = await DatabaseHelper.instance.database;
    return await db6.query(
      'adminapproved',
      where: 'pets_allocated = ? AND city = ? AND admin_decision = ?',
      whereArgs: [petCategory, selectedCity, 'accept'],
    );
  }
//  Future<Map<String, dynamic>?> getUserDetailsByEmail(String email) async {
//   try {
//     final Database db7 = await database;
//     List<Map<String, dynamic>> userdetails = await db7.query(
//       'users',
//       where: 'email = ?',
//       whereArgs: [email],
//     );

//     if (userdetails.isNotEmpty) {
//       return userdetails.first;
//     } else {
//       // Return null if no user details were found for the email
//       return null;
//     }
//   } catch (e) {
//     print('Error fetching user details: $e');
//     // Handle the error and return null or rethrow the exception
//     return null; // or throw Exception('Error fetching user details: $e');
//   }
// }
 Future<List<Map<String, dynamic>>> getUserDetailsByEmail(String email) async {
  try {
    final Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> userDetails = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    return userDetails;
  } catch (e) {
    print('Error fetching user details: $e');
    return []; // Return an empty list on error
  }
}

Future<List<Map<String, dynamic>>> getBookingDetails(String email) async {
    final Database db3 = await instance.database;
    return await db3.query(
      'bookings',
      where: 'hostel_email = ?',
      whereArgs: [email],
    );
  }
  Future<List<Map<String, dynamic>>> getBookingDetailsByCust(String email) async {
    final Database db3 = await instance.database;
    return await db3.query(
      'bookings',
      where: 'cust_email = ?',
      whereArgs: [email],
    );
  }


  // ... other methods ...
}
