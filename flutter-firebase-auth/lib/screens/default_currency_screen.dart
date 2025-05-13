import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class DefaultCurrencyScreen extends StatelessWidget {
  const DefaultCurrencyScreen({super.key});
  static const String routeName = '/default-currency';

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    TextEditingController currencyController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Set Default Currency',
          style: TextStyle(color: Colors.white), // <-- set text color white
        ),
        backgroundColor: const Color.fromARGB(255, 4, 0, 8),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(255, 26, 5, 19),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your default currency (e.g. USD, EUR, PKR)',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 35, 21, 45),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 255, 255, 255)
                        .withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: currencyController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Enter currency',
                  hintStyle: TextStyle(color: Colors.white60),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final newCurrency =
                    currencyController.text.trim().toUpperCase();
                final uid = userProvider.settings.userId;
                final currentCurrency =
                    userProvider.settings.defaultCurrency.toUpperCase();

                if (uid.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Unable to fetch user ID, default currency not updated.')),
                  );
                  return;
                }

                // ✅ Check if newCurrency is same as currentCurrency
                if (newCurrency == currentCurrency) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Currency is already set to $currentCurrency! Please enter a different one.')),
                  );
                  return; // 👈 Stop here, no saving
                }

                // ✅ If currency is different, update
                await userProvider.setDefaultCurrency(newCurrency);

                print('New Default Currency: $newCurrency');

                // Optionally clear field
                currencyController.clear();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                          Text('Default currency updated to $newCurrency!')),
                );

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 4, 0, 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
