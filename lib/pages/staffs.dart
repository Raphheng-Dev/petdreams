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
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.add),
          //     tooltip: 'Add Staff',
          //     onPressed: _showAddStaffDialog,
          //   ),
          // ],
        ),
        body: Stack(
          children: [
            ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context)
                      .size
                      .height, // Minimum height to 100% of viewport height
                  minWidth: MediaQuery.of(context)
                      .size
                      .width, // 100% of viewport width
                ),
                // 100% of viewport height
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Age')),
                      DataColumn(label: Text('Email')),
                      DataColumn(label: Text('Phone')),
                      DataColumn(label: Text('Next of kin')),
                      DataColumn(label: Text('Address')),
                      DataColumn(label: Text('Gender')),
                      DataColumn(label: Text('Role')),
                      // DataColumn(label: Text('')),
                    ],
                    rows: StaffData.staffs.map((staff) {
                      return DataRow(cells: [
                        DataCell(Text(staff.name)),
                        DataCell(Text(staff.age.toString())),
                        DataCell(Text(staff.phone as String)),
                        DataCell(Text(staff.nextOfKin)),
                        DataCell(Text(staff.address)),
                        DataCell(Text(staff.gender)),
                        DataCell(Text(staff.role)),
                      ]);
                    }).toList(),
                  ),
                )),
            // ),
            Positioned(
              right: 20,
              bottom: 26,
              child: FloatingActionButton(
                onPressed: _showAddStaffDialog,
                tooltip: 'New Case',
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ));
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
  int _phone = 0;
  String _nextOfKin = '';
  String _address = '';
  String _gender = '';
  String _role = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onAddStaff(Staff(
          name: _name,
          age: _age,
          email: _email,
          phone: _phone,
          nextOfKin: _nextOfKin,
          address: _address,
          gender: _gender,
          role: _role));
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
            TextFormField(
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an phone number';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid phone number';
                }
                return null;
              },
              onChanged: (value) {
                _phone = int.parse(value);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Next Of Kin'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a next of kin';
                }
                return null;
              },
              onChanged: (value) {
                _nextOfKin = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Address'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a address';
                }
                return null;
              },
              onChanged: (value) {
                _address = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Gender'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a gender';
                }
                return null;
              },
              onChanged: (value) {
                _gender = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Role'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a role';
                }
                return null;
              },
              onChanged: (value) {
                _role = value;
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
