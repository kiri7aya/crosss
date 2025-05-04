import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapController _mapController;
  LatLng? _currentCenter;

  // Список магазинов
  final List<Map<String, dynamic>> _shops = [
    {
      'name': 'Flower Shop A',
      'location': LatLng(51.1694, 71.4491), // Пример координат
    },
    {
      'name': 'Flower Shop B',
      'location': LatLng(51.1605, 71.4704),
    },
    {
      'name': 'Flower Shop C',
      'location': LatLng(51.1280, 71.4300),
    },
  ];

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _initLocation();
  }

  Future<void> _initLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentCenter = LatLng(position.latitude, position.longitude);
        _mapController.move(_currentCenter!, 13);
      });
    } catch (e) {
      setState(() {
        _currentCenter = LatLng(51.0907, 71.4182); // AITU
      });
    }
  }

  void _zoomIn() {
    _mapController.move(_mapController.center, _mapController.zoom + 1);
  }

  void _zoomOut() {
    _mapController.move(_mapController.center, _mapController.zoom - 1);
  }

  void _recenter() {
    if (_currentCenter != null) {
      _mapController.move(_currentCenter!, 13.0);
    }
  }

  void _showShopInfo(String shopName) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(shopName),
        content: const Text('Welcome to our flower shop! 🌸'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flower Shops Map'),
      ),
      body: _currentCenter == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: _currentCenter,
          zoom: 13.0,
          interactiveFlags: InteractiveFlag.all,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              // Маркер пользователя
              Marker(
                point: _currentCenter!,
                width: 50,
                height: 50,
                builder: (ctx) => const Icon(
                  Icons.my_location,
                  color: Colors.blue,
                  size: 40,
                ),
              ),
              // Маркеры магазинов
              ..._shops.map(
                    (shop) => Marker(
                  point: shop['location'],
                  width: 50,
                  height: 50,
                  builder: (ctx) => GestureDetector(
                    onTap: () => _showShopInfo(shop['name']),
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'zoomIn',
            onPressed: _zoomIn,
            child: const Icon(Icons.zoom_in),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'zoomOut',
            onPressed: _zoomOut,
            child: const Icon(Icons.zoom_out),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'recenter',
            onPressed: _recenter,
            child: const Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }
}
