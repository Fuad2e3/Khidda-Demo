import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'feedback_screen.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  int _currentStep = 1;
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(43.6532, -79.3832); // Toronto Center
  final LatLng _riderPos = const LatLng(43.6500, -79.3800);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Order'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 14.0,
              ),
              markers: {
                Marker(markerId: const MarkerId('rider'), position: _riderPos, icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)),
                Marker(markerId: const MarkerId('home'), position: _center),
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Rider: Tanvir Ahmed', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Estimated: 12 mins', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.call, color: Colors.green),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: Stepper(
              physics: const ClampingScrollPhysics(),
              currentStep: _currentStep,
              controlsBuilder: (context, details) => Container(),
              steps: [
                const Step(
                  title: Text('Order Placed'),
                  subtitle: Text('We have received your order'),
                  content: SizedBox.shrink(),
                  isActive: true,
                  state: StepState.complete,
                ),
                Step(
                  title: const Text('Preparing'),
                  subtitle: const Text('Chef is cooking your meal'),
                  content: const SizedBox.shrink(),
                  isActive: _currentStep >= 1,
                  state: _currentStep > 1 ? StepState.complete : StepState.editing,
                ),
                Step(
                  title: const Text('Out for Delivery'),
                  subtitle: const Text('Rider is on the way'),
                  content: const SizedBox.shrink(),
                  isActive: _currentStep >= 2,
                  state: _currentStep > 2 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: const Text('Delivered'),
                  subtitle: const Text('Enjoy your meal!'),
                  content: const SizedBox.shrink(),
                  isActive: _currentStep >= 3,
                  state: _currentStep == 3 ? StepState.complete : StepState.indexed,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_currentStep < 3) {
                  setState(() {
                    _currentStep++;
                  });
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FeedbackScreen()),
                  );
                }
              },
              child: Text(_currentStep < 3 ? 'Next Stage (Demo)' : 'Rate your meal'),
            ),
          ),
        ],
      ),
    );
  }
}
