import 'package:flutter/material.dart';

class CurrencyNewsScreen extends StatelessWidget {
  static const String routeName = '/currency-news';

  const CurrencyNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> newsArticles = [
      {
        'title': 'USD to EUR rates increase by 5% today.',
        'details':
            'USD strengthened significantly against the Euro, reaching a 5% increase. Current rate: 1 USD = 0.94 EUR.',
      },
      {
        'title': 'Bitcoin surges in the crypto market.',
        'details':
            'Bitcoin sees a 7% surge in 24 hours. Current value: \$41,200. Analysts cite ETF approval as the cause.',
      },
      {
        'title': 'Inflation impacts global currency exchanges.',
        'details':
            'Rising inflation rates have caused fluctuations in emerging market currencies, especially in Asia.',
      },
      {
        'title': 'USD expected to dominate in 2025.',
        'details':
            'Financial experts suggest that a strong US economy will boost the dollar\'s dominance worldwide.',
      },
      {
        'title': 'Euro hits a 6-month high.',
        'details':
            'The Euro strengthens due to positive EU economic forecasts. Current rate: 1 EUR = 1.10 USD.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Currency News',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: newsArticles.length,
          itemBuilder: (context, index) {
            final article = newsArticles[index];

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 35, 21, 45),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.2),
                    offset: const Offset(0, 6),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  article['title']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                subtitle: const Text(
                  'Tap the arrow for more details.',
                  style: TextStyle(color: Colors.white60),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: const Color(0xFF1E1B38),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        title: Text(
                          'Details',
                          style: TextStyle(color: Colors.tealAccent[100], fontWeight: FontWeight.bold),
                        ),
                        content: Text(
                          article['details']!,
                          style: const TextStyle(color: Colors.white),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close', style: TextStyle(color: Colors.tealAccent)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
