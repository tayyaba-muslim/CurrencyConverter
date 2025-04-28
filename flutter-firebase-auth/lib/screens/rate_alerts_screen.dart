import 'package:flutter/material.dart';



class RateAlertsScreen extends StatelessWidget {
  static const String routeName = '/rate-alerts';

  const RateAlertsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rate Alerts')),
      body: const Center(
        child: Text('Manage your rate alerts here.'),
      ),
    );
  }
}
