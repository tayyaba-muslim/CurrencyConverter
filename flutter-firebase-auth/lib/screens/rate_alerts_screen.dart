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
  bool _disposed = false;
  final Color bgColor = const Color.fromARGB(255, 26, 5, 19);
  final Color cardColor = const Color.fromARGB(255, 35, 21, 45);

  final List<String> currencies = [
    'USD',
    'PKR',
    'EUR',
    'INR',
    'CAD',
    'GBP',
    'AUD',
    'CNY',
    'JPY'
  ];
  final Map<String, Map<String, double>> _allRates = {};

  @override
  void initState() {
    super.initState();
    _fetchAllRates();
  }

  void dispose() {
    _disposed = true;
    super.dispose();
  }

  Future<void> _fetchAllRates() async {
    const String apiKey =
        '03a85ceec4f1b8e243e2c87e'; // no leading/trailing spaces

    try {
      for (String base in currencies) {
        final url = Uri.parse(
            'https://v6.exchangerate-api.com/v6/03a85ceec4f1b8e243e2c87e/latest/USD');
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);

          if (data['result'] == 'success' && data['conversion_rates'] != null) {
            final rawRates =
                Map<String, dynamic>.from(data['conversion_rates']);
            final Map<String, double> filteredRates = {};

            for (String target in currencies) {
              if (target != base && rawRates.containsKey(target)) {
                filteredRates[target] =
                    double.tryParse(rawRates[target].toString()) ?? 0.0;
              }
            }
            if (mounted && !_disposed) {
              setState(() {
                _allRates[base] = filteredRates;
              });
            }
          } else {
            print(
                'API error for $base: ${data['error-type'] ?? 'Unexpected response'}');
          }
        } else {
          print('HTTP error for $base: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error fetching rates: $e');
    }

    if (mounted && !_disposed) {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildRateSection(String base, Map<String, double> rates) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Base: $base',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...rates.entries
            .map((entry) => _buildRateCard(base, entry.key, entry.value))
            .toList(),
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
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          '$from → $to',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
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
        key: const ValueKey('rate_alerts_loader'),
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
