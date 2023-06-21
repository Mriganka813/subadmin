import 'package:flutter/material.dart';
import 'package:subadmin/pages/driver.dart';
import 'package:subadmin/pages/servicearea.dart';
import 'package:subadmin/pages/vehical.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'SubAdmin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text("Add Service Area"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ServiceAreaPage()));
              },
            ),
            ListTile(
              title: Text("Verify Driver"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DriverPage()));
              },
            ),
            ListTile(
              title: Text("Add Vehical"),
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VehiclePage()));
              },
            ),
          ],
        ),
      ),
      appBar:
          AppBar(title: const Text("Welcome"), backgroundColor: Colors.blue),
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}
