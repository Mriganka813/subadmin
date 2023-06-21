import 'package:flutter/material.dart';
import 'package:subadmin/model/driver.dart';

import '../services/driver.dart';
import '../services/servicearea.dart';

// class Driver {
//   final String name;
//   final String serviceArea;
//   bool isVerified;

//   Driver({
//     required this.name,
//     required this.serviceArea,
//     this.isVerified = false,
//   });
// }

class DriverPage extends StatefulWidget {
  @override
  _DriverPageState createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  String? _selectedServiceArea;

  List<String> _serviceAreaList = [];

  List<DriverModel> _driverList = [];

  void _onServiceAreaChanged(String? newValue) async {
    List<DriverModel> _driver = await Driver().getdriver(newValue!);
    setState(() {
      _selectedServiceArea = newValue;
      _driverList = _driver;
    });
  }

  void _toggleDriverStatus(int index) async {
    await Driver().verifydriver(_driverList[index].driverId!);
    setState(() {
      _driverList[index].isVerified = !_driverList[index].isVerified!;
    });
  }

  @override
  void initState() {
    ServiceAreaList();
    Driver().getdriver("6461f3bdc4918d53bf5c1210");
    super.initState();
  }

  void ServiceAreaList() async {
    List<String> _serviceList = await Servicearea().getarea();
    print(_serviceList);
    setState(() {
      _serviceAreaList = _serviceList;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List<DriverModel> filteredDrivers = _selectedServiceArea != null
    //     ? _driverList
    //         .where((driver) => driver.serviceAreaId == _selectedServiceArea)
    //         .toList()
    //     : _driverList;

    return Scaffold(
      appBar: AppBar(
        title: Text('Drivers'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              value: _selectedServiceArea,
              onChanged: _onServiceAreaChanged,
              items: _serviceAreaList.map((serviceArea) {
                return DropdownMenuItem<String>(
                  value: serviceArea,
                  child: Text(serviceArea),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Service Area',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _driverList.length,
              itemBuilder: (context, index) {
                DriverModel driver = _driverList[index];
                return ListTile(
                  title: Text("Driver ${index + 1}"),
                  subtitle: Text(driver.licenseID!),
                  // trailing: Switch(
                  //   value: driver.isVerified!,
                  //   onChanged: (value) => _toggleDriverStatus(index),
                  // ),
                  trailing: driver.isVerified!
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.verified, color: Colors.green),
                            Text("Verified")
                          ],
                        )
                      : InkWell(
                          onTap: () => _toggleDriverStatus(index),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.verified_outlined, color: Colors.red),
                              Text("Not Verified")
                            ],
                          ),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
