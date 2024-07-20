import 'package:flutter/material.dart';
import 'package:read_from_file/models/gender_model.dart';
import 'package:read_from_file/services/gender_service.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String? gender;
  double? probability;

  Future<GenderModel> fetchGenderData(String fullName) async {
    final GenderModel genderModel =
        await GenderService().fetchGenderData(fullName);

    setState(() {
      gender = genderModel.gender;
      probability = genderModel.probability;
    });
    return genderModel;
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analyze Gender'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _firstNameController,
            decoration: const InputDecoration(labelText: 'First Name'),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _lastNameController,
            decoration: const InputDecoration(labelText: 'Last Name'),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              String fullName =
                  '${_firstNameController.text} ${_lastNameController.text}';
              fetchGenderData(fullName);
            },
            child: const Text('Analyze'),
          ),
          const SizedBox(
            height: 10,
          ),
          Text("Gender: $gender"),
          const SizedBox(
            height: 10,
          ),
          Text("Probabilitty: $probability")
        ],
      ),
    );
  }
}
