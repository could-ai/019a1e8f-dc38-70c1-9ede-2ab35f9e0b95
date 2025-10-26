import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mobile Number Info",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const InfoFinderScreen(),
    );
  }
}

class InfoFinderScreen extends StatefulWidget {
  const InfoFinderScreen({super.key});

  @override
  State<InfoFinderScreen> createState() => _InfoFinderScreenState();
}

class _InfoFinderScreenState extends State<InfoFinderScreen> {
  final TextEditingController _numberController = TextEditingController();
  String? _ownerName;
  String? _cnic;
  String? _address;
  String? _location;
  bool _isLoading = false;

  void _searchNumber() {
    // IMPORTANT: This is a simulation.
    // Real data retrieval is not possible without access to sensitive databases.
    // This functionality requires a secure backend and database.
    final String phoneNumber = _numberController.text;
    if (phoneNumber.isNotEmpty) {
      setState(() {
        _isLoading = true;
        _ownerName = null;
        _cnic = null;
        _address = null;
        _location = null;
      });

      // Simulate a network call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          // Using dummy data for demonstration
          _ownerName = "John Doe";
          _cnic = "12345-6789012-3";
          _address = "123, Main Street, City, Country";
          _location = "City, Country";
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mobile Number Information"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Enter Mobile Number",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _searchNumber,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text("Search"),
            ),
            const SizedBox(height: 30),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_ownerName != null)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(Icons.person, "Owner Name", _ownerName),
                      _buildInfoRow(Icons.credit_card, "CNIC", _cnic),
                      _buildInfoRow(Icons.home, "Address", _address),
                      _buildInfoRow(Icons.location_on, "Location", _location),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value ?? "N/A",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
