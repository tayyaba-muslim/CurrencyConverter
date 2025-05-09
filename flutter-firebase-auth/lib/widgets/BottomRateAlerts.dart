import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BottomRateAlerts extends StatefulWidget {
  const BottomRateAlerts({super.key});

  @override
  State<BottomRateAlerts> createState() => _BottomRateAlertsState();
}

class _BottomRateAlertsState extends State<BottomRateAlerts> {
  final String apiKey = '03a85ceec4f1b8e243e2c87e';
  final String baseCurrency = 'USD';
  final List<String> showRatesFor = ['PKR', 'EUR', 'INR', 'GBP', 'AUD', 'CNY']; // Added more rates
  final Color cardColor = const Color.fromARGB(255, 35, 21, 45);
  final Color bgColor = const Color.fromARGB(255, 26, 5, 19); // Used for other elements, not card

  Map<String, double> _rates = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRates();
  }

  Future<void> _fetchRates() async {
    try {
      final url = Uri.parse('https://v6.exchangerate-api.com/v6/$apiKey/latest/$baseCurrency');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['result'] == 'success') {
          final rates = Map<String, dynamic>.from(data['conversion_rates']);
          final Map<String, double> filtered = {};

          // Filtering the rates for the selected currencies
          for (var currency in showRatesFor) {
            filtered[currency] = double.tryParse(rates[currency].toString()) ?? 0.0;
          }

          setState(() {
            _rates = filtered;
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      print('Rate fetch error: $e');
      setState(() => _isLoading = false);
    }
  }

  Widget _buildRateCard(String to, double rate) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.2),
            offset: const Offset(0, 4),
            blurRadius: 6,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          '$baseCurrency → $to',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        subtitle: Text(
          '1 $baseCurrency = ${rate.toStringAsFixed(4)} $to',
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: const Icon(Icons.trending_up, color: Colors.greenAccent),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent, // Set container background to transparent
      padding: const EdgeInsets.only(bottom: 20, top: 10),
      child: Column(
        children: [
          // const Text(
          //   "Live Rate Alerts",
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 24, // Increased size for better visibility
          //     fontWeight: FontWeight.bold,
          //     letterSpacing: 1.5, // Spacing to make it look cleaner
          //   ),
          // ),
          const SizedBox(height: 16), // Added space between heading and content
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(color: Colors.white),
            )
          else
            ..._rates.entries.map((e) => _buildRateCard(e.key, e.value)).toList(),
        ],
      ),
    );
  }
}
