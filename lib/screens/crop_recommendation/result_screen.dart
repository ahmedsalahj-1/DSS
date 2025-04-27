import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual crop recommendation data
    const recommendedCrop = 'Rice';
    const farmingTips = '''
1. Prepare the soil by plowing and leveling
2. Maintain proper water management
3. Use recommended fertilizers
4. Monitor for pests and diseases
5. Harvest at the right time
''';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommended Crop'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                'Recommended Crop',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  recommendedCrop,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Farming Tips',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  farmingTips,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 32),
              CustomButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                text: 'Back to Home',
              ),
              const SizedBox(height: 16),
              CustomButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/crop-form');
                },
                text: 'New Recommendation',
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