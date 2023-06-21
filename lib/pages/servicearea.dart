import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:subadmin/model/servicearea.dart';
import 'package:subadmin/services/servicearea.dart';

class ServiceAreaPage extends StatefulWidget {
  @override
  _ServiceAreaPageState createState() => _ServiceAreaPageState();
}

class _ServiceAreaPageState extends State<ServiceAreaPage> {
  final TextEditingController _radiusController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  LatLng? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _selectedLocation = LatLng(position.latitude, position.longitude);
      _markers.add(
        Marker(
          markerId: MarkerId('current_location'),
          position: _selectedLocation!,
        ),
      );

      _latitudeController.text = position.latitude.toStringAsFixed(6);
      _longitudeController.text = position.longitude.toStringAsFixed(6);

      _mapController?.animateCamera(
        CameraUpdate.newLatLng(_selectedLocation!),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onMapTap(LatLng location) {
    setState(() {
      _selectedLocation = location;
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId('selected_location'),
          position: location,
        ),
      );

      _latitudeController.text = location.latitude.toStringAsFixed(6);
      _longitudeController.text = location.longitude.toStringAsFixed(6);
    });
  }

  createdDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Service Area Created'),
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
    void _saveServiceArea() async {
      double? radius = double.tryParse(_radiusController.text);
      double? latitude = double.tryParse(_latitudeController.text);
      double? longitude = double.tryParse(_longitudeController.text);

      if (radius != null && latitude != null && longitude != null) {
        // Perform save service area logic here

        ModalArea area = ModalArea(
          radius: radius,
          lat: latitude,
          long: longitude,
        );

        Servicearea servicearea = Servicearea();
        await servicearea
            .createarea(area)
            .then((value) => createdDialog())
            .onError((error, stackTrace) => Navigator.pop(context));

        // Optional: Navigate to a different page after saving

        // Clear the text fields
        _radiusController.clear();
        _latitudeController.clear();
        _longitudeController.clear();
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Service Area'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              onTap: _onMapTap,
              markers: _markers,
              initialCameraPosition: CameraPosition(
                target: _selectedLocation ?? LatLng(0, 0),
                zoom: 15,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _radiusController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Radius',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _latitudeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Latitude',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _longitudeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Longitude',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _saveServiceArea,
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
