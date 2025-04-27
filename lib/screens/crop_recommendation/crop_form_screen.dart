import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';

class CropFormScreen extends StatefulWidget {
  const CropFormScreen({super.key});

  @override
  State<CropFormScreen> createState() => _CropFormScreenState();
}

class _CropFormScreenState extends State<CropFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedSoilColor = 'Brown';
  final _phController = TextEditingController();
  final _nitrogenController = TextEditingController();
  final _phosphorusController = TextEditingController();
  final _potassiumController = TextEditingController();
  final _temperatureController = TextEditingController();
  final _rainfallController = TextEditingController();
  final _humidityController = TextEditingController();

  final List<String> _soilColors = [
    'Brown',
    'Black',
    'Red',
    'Yellow',
    'White',
    'Gray',
  ];

  @override
  void dispose() {
    _phController.dispose();
    _nitrogenController.dispose();
    _phosphorusController.dispose();
    _potassiumController.dispose();
    _temperatureController.dispose();
    _rainfallController.dispose();
    _humidityController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final formData = {
        'N': _nitrogenController.text,
        'P': _phosphorusController.text,
        'K': _potassiumController.text,
        'temperature': _temperatureController.text,
        'humidity': _humidityController.text,
        'ph': _phController.text,
        'rainfall': _rainfallController.text,
      };

      Navigator.pushNamed(
        context,
        '/result',
        arguments: formData,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Recommendation Form'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Soil Parameters',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedSoilColor,
                  decoration: InputDecoration(
                    labelText: 'Soil Color',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: _soilColors.map((String color) {
                    return DropdownMenuItem<String>(
                      value: color,
                      child: Text(color),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedSoilColor = newValue;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _phController,
                  labelText: 'pH Level (0-14)',
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.science),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter pH level';
                    }
                    final ph = double.tryParse(value);
                    if (ph == null || ph < 0 || ph > 14) {
                      return 'pH must be between 0 and 14';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Nutrient Levels (kg/ha)',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _nitrogenController,
                  labelText: 'Nitrogen (N)',
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.science),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter nitrogen level';
                    }
                    final n = double.tryParse(value);
                    if (n == null || n < 0) {
                      return 'Nitrogen must be a positive number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _phosphorusController,
                  labelText: 'Phosphorus (P)',
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.science),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phosphorus level';
                    }
                    final p = double.tryParse(value);
                    if (p == null || p < 0) {
                      return 'Phosphorus must be a positive number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _potassiumController,
                  labelText: 'Potassium (K)',
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.science),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter potassium level';
                    }
                    final k = double.tryParse(value);
                    if (k == null || k < 0) {
                      return 'Potassium must be a positive number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  'Environmental Parameters',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _temperatureController,
                  labelText: 'Temperature (°C)',
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.thermostat),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter temperature';
                    }
                    final temp = double.tryParse(value);
                    if (temp == null) {
                      return 'Please enter a valid temperature';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _rainfallController,
                  labelText: 'Rainfall (mm)',
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.water_drop),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter rainfall';
                    }
                    final rain = double.tryParse(value);
                    if (rain == null || rain < 0) {
                      return 'Rainfall must be a positive number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _humidityController,
                  labelText: 'Humidity (%)',
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.water),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter humidity';
                    }
                    final hum = double.tryParse(value);
                    if (hum == null || hum < 0 || hum > 100) {
                      return 'Humidity must be between 0 and 100';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                CustomButton(
                  onPressed: _submitForm,
                  text: 'Get Recommendation',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 