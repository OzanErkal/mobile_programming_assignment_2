// lib/main.dart
import 'package:flutter/material.dart';
import 'smart_devices.dart';

void main() => runApp(const SmartHomeApp());

class SmartHomeApp extends StatelessWidget {
  const SmartHomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home Controller',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SmartHomeScreen(),
    );
  }
}

class SmartHomeScreen extends StatefulWidget {
  const SmartHomeScreen({Key? key}) : super(key: key);

  @override
  _SmartHomeScreenState createState() => _SmartHomeScreenState();
}

class _SmartHomeScreenState extends State<SmartHomeScreen> {
  // Object Instantiation for all 5 devices
  final SmartLight livingRoomLight = SmartLight("Living Room", isOn: true, brightness: 75.0);
  final Thermostat bedroomThermostat = Thermostat("Bedroom", temperature: 22.0);
  final SmartSpeaker kitchenSpeaker = SmartSpeaker.named(name: "Kitchen", volume: 40.0);
  
  // New device instantiations
  final SmartLock frontDoorLock = SmartLock("Front Door", isLocked: true, batteryLevel: 85);
  final SmartCamera porchCamera = SmartCamera("Porch", isRecording: false, resolution: "4K");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Home Controller'),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildLightCard(livingRoomLight),
                _buildThermostatCard(bedroomThermostat),
                _buildSpeakerCard(kitchenSpeaker),
                _buildLockCard(frontDoorLock),     // New Card
                _buildCameraCard(porchCamera),     // New Card
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            color: Colors.grey[200],
            child: Text(
              'Total Devices: ${SmartDevice.totalDevices}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLightCard(SmartLight light) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Smart Light: ${light.name}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Switch(
                  value: light.isOn,
                  onChanged: (val) {
                    setState(() {
                      light.toggleStatus();
                    });
                  },
                )
              ],
            ),
            Text("Brightness: ${light.brightness.toInt()}%"),
            Text("Status: ${light.isOn ? 'ON' : 'OFF'}"),
          ],
        ),
      ),
    );
  }

  Widget _buildThermostatCard(Thermostat thermostat) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Thermostat: ${thermostat.name}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text("Temperature: ${thermostat.temperature.toStringAsFixed(1)}°C"),
                Text("Status: ${thermostat.isOn ? 'Heating' : 'OFF'}"),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    setState(() { thermostat.temperature--; });
                  }
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    setState(() { thermostat.temperature++; });
                  }
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSpeakerCard(SmartSpeaker speaker) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Smart Speaker: ${speaker.name}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text("Volume: ${speaker.volume.toInt()}%"),
                Text("Status: ${speaker.isOn ? 'Playing' : 'Paused'}"),
              ],
            ),
            IconButton(
              icon: Icon(speaker.isOn ? Icons.pause_circle_filled : Icons.play_circle_filled),
              iconSize: 40,
              color: Colors.blue,
              onPressed: () {
                setState(() { speaker.toggleStatus(); });
              },
            )
          ],
        ),
      ),
    );
  }

  // --- NEW UI CARDS BELOW ---

  Widget _buildLockCard(SmartLock lock) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Smart Lock: ${lock.name}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text("Battery: ${lock.batteryLevel}%"),
                Text("Status: ${lock.isOn ? 'LOCKED' : 'UNLOCKED'}"),
              ],
            ),
            IconButton(
              icon: Icon(lock.isOn ? Icons.lock : Icons.lock_open),
              iconSize: 35,
              color: lock.isOn ? Colors.red : Colors.green,
              onPressed: () {
                setState(() { lock.toggleStatus(); });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCameraCard(SmartCamera camera) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Smart Camera: ${camera.name}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text("Resolution: ${camera.resolution}"),
                Text("Status: ${camera.isOn ? 'RECORDING' : 'IDLE'}"),
              ],
            ),
            IconButton(
              icon: Icon(camera.isOn ? Icons.videocam : Icons.videocam_off),
              iconSize: 35,
              color: camera.isOn ? Colors.red : Colors.grey,
              onPressed: () {
                setState(() { camera.toggleStatus(); });
              },
            )
          ],
        ),
      ),
    );
  }
}