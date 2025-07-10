import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/snack_bar.dart';
import 'package:save_heaven/features/donation/data/data_source/donation_remote_data_source.dart';
import 'package:save_heaven/screens/pickup_details_screen.dart';
import 'package:save_heaven/features/kids/data/models/orphanages_response.dart';

class DonateLocationScreen extends StatefulWidget {
  final DonationItems donationItems;
  final Orphanage orphanage;

  const DonateLocationScreen({
    super.key,
    required this.donationItems,
    required this.orphanage,
  });

  @override
  State<DonateLocationScreen> createState() => _DonateLocationScreenState();
}

class _DonateLocationScreenState extends State<DonateLocationScreen> {
  LatLng? _pickedLocation;
  final MapController _mapController = MapController();

  Future<LatLng> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      return LatLng(0, 0);
    }

    Position position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    final currentLoc = await _getCurrentLocation();
    setState(() {
      _pickedLocation = currentLoc;
    });
    _mapController.move(currentLoc, 15);
  }

  void _handleTap(TapPosition tapPosition, LatLng point) {
    setState(() {
      _pickedLocation = point;
    });
  }

  // ✅ Safe wrapper for placemarkFromCoordinates
  Future<List<Placemark>> safePlacemarkFromCoordinates(
    double lat,
    double lng,
  ) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks == null) {
        print('Native geocoder returned null');
        return [];
      }
      return placemarks;
    } catch (e, s) {
      print('safePlacemarkFromCoordinates error: $e');
      print(s);
      return [];
    }
  }

  void _confirmSelection() async {
    if (_pickedLocation != null) {
      final lat = _pickedLocation!.latitude;
      final lng = _pickedLocation!.longitude;

      print('Picked Location: lat=$lat, lng=$lng');

      if (lat.isNaN || lng.isNaN) {
        print('Coordinates are invalid');
        return;
      }

      final placemarks = await safePlacemarkFromCoordinates(lat, lng);

      if (placemarks.isEmpty) {
        showSnackBar(context, 'No address found for this location.');
        context.push(
          PickupDetailsScreen(
            orphanage: widget.orphanage,
            isCloth: true,
            donationItems: widget.donationItems.copyWith(deliveryLocation: ''),
          ),
        );
        return;
      }

      final place = placemarks.first;

      final addressParts = [
        place.street,
        place.subLocality,
        place.locality,
        place.administrativeArea,
        place.country,
      ].where((part) => part != null && part.trim().isNotEmpty).toList();

      final myAddress = addressParts.join(', ');

      myAddress;
      context.push(
        PickupDetailsScreen(
          isCloth: true,
          orphanage: widget.orphanage,
          donationItems: widget.donationItems.copyWith(
            deliveryLocation: myAddress,
          ),
        ),
      );
    } else {
      showSnackBar(context, 'No address found for this location.');
      context.push(
        PickupDetailsScreen(
          isCloth: true,
          orphanage: widget.orphanage,
          donationItems: widget.donationItems.copyWith(deliveryLocation: ''),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick Delivery Location')),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _pickedLocation ?? LatLng(0, 0),
                initialZoom: 15,
                onTap: _handleTap,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.your.package.name',
                ),
                if (_pickedLocation != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _pickedLocation!,
                        width: 40,
                        height: 40,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '© OpenStreetMap contributors',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _confirmSelection,
        backgroundColor: AppPalette.primaryColor,
        child: const Icon(Icons.check, color: Colors.white),
      ),
    );
  }
}
