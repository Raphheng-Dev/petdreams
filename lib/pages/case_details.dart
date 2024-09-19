// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../models/case_model.dart'; // Ensure this model is defined

class CaseDetailsPage extends StatefulWidget {
  final Case caseItem;

  const CaseDetailsPage({super.key, required this.caseItem});

  @override
  // ignore: library_private_types_in_public_api
  _CaseDetailsPageState createState() => _CaseDetailsPageState();
}

class _CaseDetailsPageState extends State<CaseDetailsPage> {
  // Variables for diagnosis input
  String _diagnosisName = '';
  String _diagnosisResult = '';
  String? _uploadedDocument;

  void _uploadDocument() async {
    // Implement document upload functionality using file_picker
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _uploadedDocument =
            result.files.single.name; // Store the uploaded document name
      });
      print("Document uploaded: $_uploadedDocument");
    } else {
      // User canceled the picker
      print("No document selected");
    }
  }

  void _updateCase() {
    // Logic to update the case can be implemented here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Case updated successfully!')),
    );
  }

  void _addDiagnosis() {
    // Logic to handle adding a diagnosis (e.g., save to a database or state)
    if (_diagnosisName.isNotEmpty && _diagnosisResult.isNotEmpty) {
      // Here you would typically save the diagnosis information
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Diagnosis added successfully: $_diagnosisName')),
      );
      // Reset fields after adding
      setState(() {
        _diagnosisName = '';
        _diagnosisResult = '';
        _uploadedDocument = null; // Reset the document
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Case Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _updateCase,
            tooltip: 'Update Case',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: ResponsiveLayout(
            children: [
              _buildInfoCard('Basic Information', [
                _buildInfoRow('File Number:', widget.caseItem.fileNumber),
                _buildInfoRow('Name:', widget.caseItem.name),
                _buildInfoRow('Age:', widget.caseItem.age.toString()),
                _buildInfoRow('Weight:', widget.caseItem.weight),
                _buildInfoRow('Specie:', widget.caseItem.specie),
                _buildInfoRow('Breed:', widget.caseItem.breed),
                _buildInfoRow('Sex:', widget.caseItem.sex),
                _buildInfoRow('Color:', widget.caseItem.color),
              ]),
              _buildInfoCard('Owner Information', [
                _buildInfoRow('Owner\'s Name:', widget.caseItem.ownersName),
                _buildInfoRow('Address:', widget.caseItem.address),
                _buildInfoRow('Phone:', widget.caseItem.phone.toString()),
                _buildInfoRow('Email:', widget.caseItem.email),
              ]),
              _buildInfoCard('Health Information', [
                _buildInfoRow('Allergies:', widget.caseItem.allergies),
                _buildInfoRow(
                    'Existing Condition:', widget.caseItem.existingCondition),
              ]),
              // New section for Diagnosis Input
              const SizedBox(height: 20),
              _buildDiagnosisInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiagnosisInput() {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Diagnosis',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(labelText: 'Diagnosis Name'),
              onChanged: (value) => _diagnosisName = value,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(labelText: 'Diagnosis Result'),
              onChanged: (value) => _diagnosisResult = value,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _uploadDocument,
              child: const Text('Upload Document (Optional)'),
            ),
            if (_uploadedDocument !=
                null) // Display uploaded document name if available
              Text('Uploaded Document: $_uploadedDocument'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addDiagnosis,
              child: const Text('Add Diagnosis'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> infoRows) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...infoRows,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  final List<Widget> children;

  const ResponsiveLayout({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          // Desktop layout
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children.map((child) => Expanded(child: child)).toList(),
          );
        } else {
          // Mobile layout
          return Column(
            children: children,
          );
        }
      },
    );
  }
}
