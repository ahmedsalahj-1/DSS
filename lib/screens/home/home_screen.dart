import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = context.watch<AuthProvider>().userName ?? 'User';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Recommendation'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await context.read<AuthProvider>().signOut();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/signin');
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.eco,
                size: 120,
                color: Color(0xFF4CAF50),
              ),
              const SizedBox(height: 32),
              Text(
                'Welcome, $userName!',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Get personalized crop recommendations based on your soil and environmental conditions.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              CustomButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/crop-form');
                },
                text: 'Start Recommendation',
              ),
              const SizedBox(height: 16),
              CustomButton(
                onPressed: () {
                  // TODO: Navigate to history screen
                },
                text: 'View History',
                backgroundColor: Theme.of(context).colorScheme.surface,
                textColor: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 