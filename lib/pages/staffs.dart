import 'package:flutter/material.dart';
import '../models/staff_model.dart';

class StaffsPage extends StatefulWidget {
  const StaffsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StaffsPageState createState() => _StaffsPageState();
}

class _StaffsPageState extends State<StaffsPage> {
  void _showAddStaffDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Staff'),
          content: AddStaffForm(onAddStaff: (Staff staff) {
            setState(() {
              StaffData.addStaff(staff);
            });
            Navigator.of(context).pop(); // Close the dialog
          }),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close dialog
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Staffs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Staff',
            onPressed: _showAddStaffDialog,
          ),
        ],
      ),
      body: DataTable(
        columns: const [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Age')),
          DataColumn(label: Text('Email')),
        ],
        rows: StaffData.staffs.map((staff) {
          return DataRow(cells: [
            DataCell(Text(staff.name)),
            DataCell(Text(staff.age.toString())),
            DataCell(Text(staff.email)),
          ]);
        }).toList(),
      ),
    );
  }
}

class AddStaffForm extends StatefulWidget {
  final Function(Staff) onAddStaff;

  const AddStaffForm({super.key, required this.onAddStaff});

  @override
  // ignore: library_private_types_in_public_api
  _AddStaffFormState createState() => _AddStaffFormState();
}

class _AddStaffFormState extends State<AddStaffForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  int _age = 0;
  String _email = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onAddStaff(Staff(name: _name, age: _age, email: _email));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400, // Set a fixed width for the dialog form
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
              onChanged: (value) {
                _name = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an age';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              onChanged: (value) {
                _age = int.parse(value);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                }
                if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              onChanged: (value) {
                _email = value;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Add Staff'),
            ),
          ],
        ),
      ),
    );
  }
}

class StaffData {
  static List<Staff> staffs = [];

  static void addStaff(Staff staff) {
    staffs.add(staff);
  }
}
