import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SIM Info Finder",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.tealAccent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
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
  bool _noResults = false;

  void _searchNumber() {
    final String phoneNumber = _numberController.text;
    if (phoneNumber.isNotEmpty) {
      setState(() {
        _isLoading = true;
        _ownerName = null;
        _cnic = null;
        _address = null;
        _location = null;
        _noResults = false;
      });

      // Simulate a network call
      Future.delayed(const Duration(seconds: 2), () {
        // Using dummy data for demonstration
        // IMPORTANT: This is a simulation.
        // Real data retrieval is not possible without access to sensitive databases.
        if (phoneNumber == "00000000000") {
          setState(() {
            _isLoading = false;
            _noResults = true;
          });
        } else {
          setState(() {
            _ownerName = "Jane Doe";
            _cnic = "98765-4321098-7";
            _address = "456, Park Avenue, Metropolis, USA";
            _location = "Metropolis, USA";
            _isLoading = false;
          });
        }
      });
    }
  }

  void _clearSearch() {
    _numberController.clear();
    setState(() {
      _ownerName = null;
      _cnic = null;
      _address = null;
      _location = null;
      _noResults = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SIM Information Finder"),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[900]!, Colors.grey[850]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  "Enter a mobile number to get owner details.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _numberController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Enter Mobile Number",
                    labelStyle: TextStyle(color: Colors.tealAccent),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.tealAccent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                    prefixIcon: const Icon(Icons.phone_android, color: Colors.tealAccent),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.search),
                        onPressed: _searchNumber,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          textStyle: const TextStyle(fontSize: 18),
                        ),
                        label: const Text("Search"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.clear, color: Colors.redAccent),
                      onPressed: _clearSearch,
                      tooltip: "Clear",
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                if (_isLoading)
                  const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.tealAccent)))
                else if (_noResults)
                  const Center(
                    child: Text(
                      "No information found for this number.",
                      style: TextStyle(fontSize: 16, color: Colors.redAccent),
                    ),
                  )
                else if (_ownerName != null)
                  _buildResultsCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultsCard() {
    return Card(
      color: Colors.grey[850],
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Owner Information",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.tealAccent),
            ),
            const Divider(color: Colors.tealAccent, thickness: 1, height: 20),
            _buildInfoRow(Icons.person_outline, "Owner Name", _ownerName),
            _buildInfoRow(Icons.credit_card, "CNIC", _cnic),
            _buildInfoRow(Icons.home_outlined, "Address", _address),
            _buildInfoRow(Icons.location_on_outlined, "Location", _location),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.tealAccent, size: 28),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value ?? "N/A",
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
