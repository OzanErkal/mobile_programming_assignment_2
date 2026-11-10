// lib/smart_devices.dart

// 1. INTERFACE[cite: 30]
abstract class Connectable {
  void connect();
}

// 2. MIXIN[cite: 35]
mixin Schedulable {
  String scheduleTime = "Not scheduled";
  void setSchedule(String time) {
    scheduleTime = time;
  }
}

// 3. BASE ABSTRACT CLASS[cite: 27]
abstract class SmartDevice implements Connectable {
  static int totalDevices = 0; 
  String name;
  bool isOn;

  SmartDevice(this.name, this.isOn) {
    totalDevices++;
  }

  SmartDevice.named({required this.name, this.isOn = false}) {
    totalDevices++;
  }

  void toggleStatus(); 
}

// 4. SUBCLASSES (Inheritance)[cite: 21]

class SmartLight extends SmartDevice with Schedulable {
  double brightness;

  SmartLight(String name, {bool isOn = false, this.brightness = 0.0})
      : super(name, isOn); 

  @override
  void toggleStatus() {
    isOn = !isOn;
    if (!isOn) brightness = 0.0;
    if (isOn && brightness == 0) brightness = 100.0;
  }

  @override
  void connect() => print("SmartLight connected to WiFi.");
}

class Thermostat extends SmartDevice {
  double temperature;

  Thermostat(String name, {bool isOn = true, this.temperature = 22.0})
      : super(name, isOn);

  @override
  void toggleStatus() {
    isOn = !isOn;
  }

  @override
  void connect() => print("Thermostat connected to Hub.");
}

class SmartSpeaker extends SmartDevice with Schedulable {
  double volume;

  SmartSpeaker.named({required String name, bool isOn = false, this.volume = 50.0})
      : super.named(name: name, isOn: isOn);

  @override
  void toggleStatus() {
    isOn = !isOn;
  }

  @override
  void connect() => print("SmartSpeaker paired via Bluetooth.");
}

// --- NEW DEVICES ADDED BELOW ---

class SmartLock extends SmartDevice {
  int batteryLevel;

  // We map 'isOn' to represent 'isLocked' for this specific device
  SmartLock(String name, {bool isLocked = true, this.batteryLevel = 100})
      : super(name, isLocked);

  @override
  void toggleStatus() {
    isOn = !isOn; // Toggles the lock
  }

  @override
  void connect() => print("SmartLock connected to Zigbee network.");
}

class SmartCamera extends SmartDevice with Schedulable {
  String resolution;

  // We map 'isOn' to represent 'isRecording'
  SmartCamera(String name, {bool isRecording = false, this.resolution = "1080p"})
      : super(name, isRecording);

  @override
  void toggleStatus() {
    isOn = !isOn; // Toggles recording state
  }

  @override
  void connect() => print("SmartCamera connected to WiFi.");
}