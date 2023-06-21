import 'package:flutter/material.dart';
import 'package:subadmin/services/servicearea.dart';

import '../model/vehicle.dart';
import '../services/vehicle.dart';

class VehiclePage extends StatefulWidget {
  @override
  _VehiclePageState createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  final TextEditingController _priceController = TextEditingController();
  String? _selectedVehicle;
  String? _selectedServiceAreaId;

  List<String> _vehicleList = [
    'Car',
    'Motorcycle',
    'Truck',
    'SUV',
  ];

  List<String> _serviceAreaIdList = [];

  @override
  void initState() {
    ServiceAreaList();
    super.initState();
  }

  void ServiceAreaList() async {
    List<String> _serviceList = await Servicearea().getarea();
    setState(() {
      _serviceAreaIdList = _serviceList;
    });
  }

  void _saveVehicle() {
    double? price = double.tryParse(_priceController.text);

    if (price != null &&
        _selectedVehicle != null &&
        _selectedServiceAreaId != null) {
      Vehicle newVehicle = Vehicle(
        name: _selectedVehicle!,
        price: price,
      );

      Vehical()
          .createarea(newVehicle, _selectedServiceAreaId!)
          .then((value) => successdialogue());
      // Clear the text fields and selections
      _priceController.clear();
      _selectedVehicle = null;
      _selectedServiceAreaId = null;
    } else {
      // Show an error or validation message if input is invalid
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Invalid input. Please enter valid values.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  successdialogue() {
    // show a dialogue box
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Vehicle Added Successfully'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedVehicle,
              onChanged: (newValue) {
                setState(() {
                  _selectedVehicle = newValue;
                });
              },
              items: _vehicleList.map((vehicle) {
                return DropdownMenuItem<String>(
                  value: vehicle,
                  child: Text(vehicle),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Vehicle Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Price',
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedServiceAreaId,
              onChanged: (newValue) {
                setState(() {
                  _selectedServiceAreaId = newValue;
                });
              },
              items: _serviceAreaIdList.map((serviceAreaId) {
                return DropdownMenuItem<String>(
                  value: serviceAreaId,
                  child: Text(serviceAreaId),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Service Area ID',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveVehicle,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
