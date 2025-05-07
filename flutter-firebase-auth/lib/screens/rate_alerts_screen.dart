import 'dart:convert';
import 'package:firebase_auth_demo/widgets/page_with_loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RateAlertsScreen extends StatefulWidget {
  static const String routeName = '/rate-alerts';

  const RateAlertsScreen({Key? key}) : super(key: key);

  @override
  State<RateAlertsScreen> createState() => _RateAlertsScreenState();
}

class _RateAlertsScreenState extends State<RateAlertsScreen> {
  bool _isLoading = true;
  final Color bgColor = const Color.fromARGB(255, 26, 5, 19);
  final Color cardColor = const Color.fromARGB(255, 35, 21, 45);

  final List<String> currencies = ['USD', 'PKR', 'EUR', 'INR', 'CAD', 'GBP', 'AUD', 'CNY', 'JPY'];
  final Map<String, Map<String, double>> _allRates = {}; // base -> {to -> rate}

  @override
  void initState() {
    super.initState();
    _fetchAllRates();
  }

  Future<void> _fetchAllRates() async {
    try {
      for (String base in currencies) {
        // Construct the list of other currencies to convert to
        List<String> targets = currencies.where((c) => c != base).toList();
        final url = Uri.parse('https://api.frankfurter.app/latest?from=$base&to=${targets.join(',')}');
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final rates = Map<String, dynamic>.from(data['rates']);
          final parsedRates = rates.map((key, value) => MapEntry(key, double.tryParse(value.toString()) ?? 0.0));
          _allRates[base] = parsedRates;
        }
      }
    } catch (e) {
      print('Error fetching rates: $e');
    }

    setState(() => _isLoading = false);
  }

  Widget _buildRateSection(String base, Map<String, double> rates) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Base: $base',
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ...rates.entries.map((entry) => _buildRateCard(base, entry.key, entry.value)).toList(),
        const Divider(color: Colors.white24, thickness: 1, height: 32),
      ],
    );
  }
Widget _buildRateCard(String from, String to, double rate) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
    decoration: BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
          offset: const Offset(0, 5),
          blurRadius: 6,
          spreadRadius: 0,
        ),
      ],
    ),
    child: ListTile(
      contentPadding: const EdgeInsets.all(16),
      title: Text(
        '$from → $to',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      subtitle: Text(
        '1 $from = ${rate.toStringAsFixed(4)} $to',
        style: const TextStyle(color: Colors.white70),
      ),
      trailing: const Icon(Icons.trending_up, color: Colors.greenAccent),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Live Currency Rates'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 45, 20, 55),
        foregroundColor: Colors.white,
      ),
       body: PageWithLoader(
        key: const ValueKey('rate_alerts_loader'), // Optionally set a key for better widget tree management
        isLoading: _isLoading,
        child: _allRates.isEmpty
            ? const Center(
                child: Text(
                  'No rates available.',
                  style: TextStyle(color: Colors.white70),
                ),
              )
            : ListView(
                children: _allRates.entries
                    .map((entry) => _buildRateSection(entry.key, entry.value))
                    .toList(),
              ),
      ),
    );
  }
}
