import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/customer_model.dart';

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({super.key});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  // Mock data
  final List<Customer> _customers = [
    Customer(
      id: '1',
      last4Digits: '4587',
      locationName: 'مسقط – الخوير',
      latitude: 23.6100,
      longitude: 58.5400,
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      orderId: 'ORD-001',
    ),
    Customer(
      id: '2',
      last4Digits: '9921',
      locationName: 'السيب - المعبيلة',
      latitude: 23.6700,
      longitude: 58.1000,
      timestamp: DateTime.now().subtract(const Duration(minutes: 20)),
    ),
    Customer(
      id: '3',
      last4Digits: '1102',
      locationName: 'بوشر',
      latitude: 23.5900,
      longitude: 58.4000,
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
  ];

  GoogleMapController? _mapController;
  final LatLng _center = const LatLng(23.6100, 58.5400); // Muscat coordinates

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map Layer
          GoogleMap(
            onMapCreated: (controller) => _mapController = controller,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            markers: _customers.map((c) {
              return Marker(
                markerId: MarkerId(c.id),
                position: LatLng(c.latitude, c.longitude),
                infoWindow: InfoWindow(
                  title: 'زبون: ${c.last4Digits}',
                  snippet: c.locationName,
                ),
              );
            }).toSet(),
          ),
          
          // Bottom Sheet / List Overlay
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _customers.length,
                itemBuilder: (context, index) {
                  final customer = _customers[index];
                  return _buildCustomerCard(customer);
                },
              ),
            ),
          ),

          // Action Buttons
          Positioned(
            top: 16,
            left: 16,
            child: FloatingActionButton.extended(
              heroTag: 'sort_btn',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('جاري ترتيب المسار الأقرب...')),
                );
              },
              label: const Text('رتّب الأقرب'),
              icon: const Icon(Icons.sort),
            ),
          ),
          
          Positioned(
            top: 16,
            right: 16,
            child: FloatingActionButton(
              heroTag: 'add_btn',
              onPressed: () {
                 ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('محاكاة: استلام موقع من واتساب...')),
                );
                // Simulate adding a customer
                setState(() {
                  _customers.add(
                    Customer(
                      id: DateTime.now().toString(),
                      last4Digits: '8888',
                      locationName: 'موقع جديد',
                      latitude: 23.6200,
                      longitude: 58.5500,
                      timestamp: DateTime.now(),
                    ),
                  );
                });
              },
              child: const Icon(Icons.add_location_alt),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerCard(Customer customer) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'زبون: ${customer.last4Digits}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${DateTime.now().difference(customer.timestamp).inMinutes} دقيقة',
                      style: const TextStyle(color: Colors.blue, fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      customer.locationName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.navigation, size: 16),
                      label: const Text('ملاحة'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.message, color: Colors.green),
                    tooltip: 'واتساب',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
