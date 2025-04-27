import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../widgets/custom_button.dart';

class ResultScreen extends StatefulWidget {
  final Map<String, dynamic> formData;
  
  const ResultScreen({
    super.key,
    required this.formData,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _predictions = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _getPredictions();
  }

  Future<void> _getPredictions() async {
    try {
      final response = await http.post(
        Uri.parse('YOUR_RENDER_API_URL/predict'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(widget.formData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            _predictions = List<Map<String, dynamic>>.from(data['predictions']);
            _isLoading = false;
          });
        } else {
          setState(() {
            _error = 'Failed to get predictions';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _error = 'Server error: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommended Crops'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _error!,
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Icon(
                          Icons.eco,
                          size: 120,
                          color: Color(0xFF4CAF50),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Recommended Crops',
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ..._predictions.map((prediction) => Card(
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Text(
                                      prediction['crop'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Confidence: ${(prediction['probability'] * 100).toStringAsFixed(1)}%',
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                            )),
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