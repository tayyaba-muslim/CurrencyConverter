import 'package:flutter/material.dart';

class CurrencyNewsScreen extends StatelessWidget {
  static const String routeName = '/currency-news';

  const CurrencyNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample news data (this could be dynamic, e.g., fetched from an API)
    final List<String> newsArticles = [
      'USD to EUR rates increase by 5% today.',
      'The cryptocurrency market shows a surge in Bitcoin value.',
      'Inflation impacts global currency exchanges.',
      'Experts predict a strong year for USD in 2025.',
      'Euro hits a new 6-month high against major currencies.',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency News'),
        backgroundColor: const Color.fromARGB(255, 4, 0, 8), // Custom background color
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(255, 22, 10, 34), // Custom background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: newsArticles.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              color: const Color.fromARGB(255, 35, 21, 45), // Card background color
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  newsArticles[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: const Text(
                  'Stay updated on currency markets.',
                  style: TextStyle(color: Colors.white70),
                ),
                trailing: const Icon(Icons.arrow_forward, color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
