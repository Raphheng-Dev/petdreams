import 'package:flutter/material.dart';
import 'package:test_drive/services/cases_service.dart';

class CasesPage extends StatefulWidget {
  const CasesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CasesPageState createState() => _CasesPageState();
}

class _CasesPageState extends State<CasesPage> {
  List<Map<String, String>> patients = [];
  final CasesService casesService = CasesService();

  @override
  void initState() {
    super.initState();
    _fetchPatients();
  }

  Future<void> _fetchPatients() async {
    try {
      final fetchedPatients = await casesService.fetchPatients();
      setState(() {
        patients = fetchedPatients;
      });
    } catch (e) {
      // Handle errors (e.g., show a message)
      print(e);
    }
  }

  void _addPatient(Map<String, String> patient) async {
    setState(() {
      patients.add(patient);
    });
    try {
      await casesService.addPatient(patient);
      _fetchPatients(); // Refresh the patient list after adding
    } catch (e) {
      // Handle errors (e.g., show a message)
      print(e);
    }
  }

  // void _addPatient(Map<String, String> patient) {
  //   setState(() {
  //     patients.add(patient);
  //   });
  // }

  void _showAddPatientModal() {
    showDialog(
      context: context,
      builder: (context) {
        return AddPatientModal(onAddPatient: _addPatient);
      },
    );
  }

  void _onRowTapped(Map<String, String> patient) {
    // Handle the row tap (e.g., show details)
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Patient Details'),
          content:
              Text('Patient Name: ${patient['name']}\nAge: ${patient['age']}'),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
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
          title: const Text('Cases'),
        ),
        body: Stack(children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context)
                  .size
                  .height, // Minimum height to 100% of viewport height
              minWidth:
                  MediaQuery.of(context).size.width, // 100% of viewport width
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              // Adjust padding to accommodate the button
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('File Number')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Age')),
                  DataColumn(label: Text('Weight')),
                  DataColumn(label: Text('Specie')),
                  DataColumn(label: Text('Breed')),
                  DataColumn(label: Text('Sex')),
                  DataColumn(label: Text('color')),
                  DataColumn(label: Text('OwnersName')),
                  // DataColumn(label: Text('Address')),
                  // DataColumn(label: Text('Phone')),
                  // DataColumn(label: Text('Email')),
                  // DataColumn(label: Text('Allergies')),
                  // DataColumn(label: Text('Existing Condition')),
                ],
                rows: patients
                    .map((patient) => DataRow(
                          cells: [
                            DataCell(Text(patient['fileNumber']!)),
                            DataCell(Text(patient['name']!)),
                            DataCell(Text(patient['age']!)),
                            DataCell(Text(patient['weight']!)),
                            DataCell(Text(patient['specie']!)),
                            DataCell(Text(patient['breed']!)),
                            DataCell(Text(patient['sex']!)),
                            DataCell(Text(patient['color']!)),
                            DataCell(Text(patient['ownersName']!)),
                            // DataCell(Text(patient['address']!)),
                            // DataCell(Text(patient['phone']!)),
                            // DataCell(Text(patient['email']!)),
                            // DataCell(Text(patient['allergies']!)),
                            // DataCell(Text(patient['existingCondition']!)),
                          ],
                          onSelectChanged: (selected) {
                            if (selected!) {
                              _onRowTapped(patient);
                            }
                          },
                        ))
                    .toList(),
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 26,
            child: FloatingActionButton(
              onPressed: _showAddPatientModal,
              tooltip: 'New Case',
              child: const Icon(Icons.add),
            ),
          ),
        ]));
  }
}

class AddPatientModal extends StatefulWidget {
  final Function(Map<String, String>) onAddPatient;

  const AddPatientModal({super.key, required this.onAddPatient});

  @override
  // ignore: library_private_types_in_public_api
  _AddPatientModalState createState() => _AddPatientModalState();
}

class _AddPatientModalState extends State<AddPatientModal> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _newPatient = {
    'fileNumber': '',
    'name': '',
    'age': '',
    'weight': '',
    'specie': '',
    'breed': '',
    'sex': '',
    'color': '',
    'ownersName': '',
    'address': '',
    'phone': '',
    'email': '',
    'allergies': '',
    'existingCondition': '',
  };

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onAddPatient(Map.from(_newPatient));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Case'),
      content: SizedBox(
        width: 500, // Set a fixed width for the dialog form
        child: Form(
          key: _formKey,
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            children: [
              Row(children: [
                const Expanded(
                  child: SizedBox(),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'File Number'),
                    onChanged: (value) {
                      _newPatient['fileNumber'] = value;
                    },
                    validator: (value) =>
                        value!.isEmpty ? 'Enter File Number' : null,
                  ),
                )
              ]),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  _newPatient['name'] = value;
                },
                validator: (value) => value!.isEmpty ? 'Enter Name' : null,
              ),
              Row(children: [
                Expanded(
                    child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Age'),
                  onChanged: (value) {
                    _newPatient['age'] = value;
                  },
                  validator: (value) => value!.isEmpty ? 'Enter Age' : null,
                )),
                const SizedBox(width: 20),
                Expanded(
                    child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Weight'),
                  onChanged: (value) {
                    _newPatient['weight'] = value;
                  },
                  validator: (value) => value!.isEmpty ? 'Enter Weight' : null,
                )),
              ]),
              Row(children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Specie'),
                    onChanged: (value) {
                      _newPatient['specie'] = value;
                    },
                    validator: (value) =>
                        value!.isEmpty ? 'Enter Specie' : null,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Breed'),
                    onChanged: (value) {
                      _newPatient['breed'] = value;
                    },
                    validator: (value) => value!.isEmpty ? 'Enter Breed' : null,
                  ),
                )
              ]),
              Row(children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Sex'),
                    onChanged: (value) {
                      _newPatient['sex'] = value;
                    },
                    validator: (value) => value!.isEmpty ? 'Enter Sex' : null,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Color'),
                    onChanged: (value) {
                      _newPatient['color'] = value;
                    },
                    validator: (value) => value!.isEmpty ? 'Enter Color' : null,
                  ),
                )
              ]),
              TextFormField(
                decoration: const InputDecoration(labelText: 'OwnersName'),
                onChanged: (value) {
                  _newPatient['ownersName'] = value;
                },
                validator: (value) =>
                    value!.isEmpty ? "Enter Owner's Name" : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
                onChanged: (value) {
                  _newPatient['address'] = value;
                },
                validator: (value) => value!.isEmpty ? 'Enter Address' : null,
              ),
              Row(children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Phone'),
                    onChanged: (value) {
                      _newPatient['phone'] = value;
                    },
                    validator: (value) => value!.isEmpty ? 'Enter Phone' : null,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    onChanged: (value) {
                      _newPatient['email'] = value;
                    },
                    validator: (value) => value!.isEmpty ? 'Enter Email' : null,
                  ),
                )
              ]),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Allergies'),
                onChanged: (value) {
                  _newPatient['allergies'] = value;
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Existing Condition'),
                onChanged: (value) {
                  _newPatient['existingCondition'] = value;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _submit,
          child: const Text('Add Patient'),
        ),
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

















// import 'package:flutter/material.dart';
// import '../models/case_model.dart'; // Update the import to your Case model

// class CasesPage extends StatefulWidget {
//   const CasesPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _CasesPageState createState() => _CasesPageState();
// }

// class _CasesPageState extends State<CasesPage> {
//   void _showAddCaseDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Add Case'),
//           content: AddCaseForm(onAddCase: (Case caseItem) {
//             setState(() {
//               CaseData.addCase(caseItem);
//             });
//             Navigator.of(context).pop(); // Close the dialog
//           }),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(), // Close dialog
//               child: const Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('All Cases'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add),
//             tooltip: 'Add Case',
//             onPressed: _showAddCaseDialog,
//           ),
//         ],
//       ),
//       body: DataTable(
//         columns: const [
//           DataColumn(label: Text('Name')),
//           DataColumn(label: Text('Age')),
//           DataColumn(label: Text('Weight')),
//           DataColumn(label: Text('Specie')),
//           DataColumn(label: Text('Breed')),
//           DataColumn(label: Text('Sex')),
//           DataColumn(label: Text('Color')),
//           DataColumn(label: Text('Owner')),
//         ],
//         rows: CaseData.cases.map((caseItem) {
//           return DataRow(cells: [
//             DataCell(Text(caseItem.name)),
//             DataCell(Text(caseItem.age as String)),
//             DataCell(Text(caseItem.weight)),
//             DataCell(Text(caseItem.specie)),
//             DataCell(Text(caseItem.breed)),
//             DataCell(Text(caseItem.sex)),
//             DataCell(Text(caseItem.color)),
//             DataCell(Text(caseItem.ownersName)),
//           ]);
//         }).toList(),
//       ),
//     );
//   }
// }

// class AddCaseForm extends StatefulWidget {
//   final Function(Case) onAddCase;

//   const AddCaseForm({super.key, required this.onAddCase});

//   @override
//   // ignore: library_private_types_in_public_api
//   _AddCaseFormState createState() => _AddCaseFormState();
// }

// class _AddCaseFormState extends State<AddCaseForm> {
//   final _formKey = GlobalKey<FormState>();
//   final String _fileNumber = '';
//   String _name = '';
//   int _age = 0;
//   final String _weight = '';
//   final String _specie = '';
//   final String _breed = '';
//   final String _sex = '';
//   final String _color = '';
//   final String _ownersName = '';
//   final String _address = '';
//   final int _phone = 0;
//   String _email = '';
//   final String _allergies = '';
//   final String _existingCondition = '';

//   void _submit() {
//     if (_formKey.currentState!.validate()) {
//       widget.onAddCase(Case(
//         fileNumber: _fileNumber,
//         weight: _weight,
//         specie: _specie,
//         breed: _breed,
//         sex: _sex,
//         color: _color,
//         name: _name,
//         age: _age,
//         address: _address,
//         phone: _phone,
//         ownersName: _ownersName,
//         email: _email,
//         allergies: _allergies,
//         existingCondition: _existingCondition,
//       ));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 400, // Set a fixed width for the dialog form
//       child: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextFormField(
//               decoration: const InputDecoration(labelText: 'Name'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter a name';
//                 }
//                 return null;
//               },
//               onChanged: (value) {
//                 _name = value;
//               },
//             ),
//             Row(
//               children: [
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: 'Name'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a name';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     _name = value;
//                   },
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: 'Age'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter an age';
//                     }
//                     if (int.tryParse(value) == null) {
//                       return 'Please enter a valid number';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     _age = int.parse(value);
//                   },
//                 ),
//               ],
//             ),
//             TextFormField(
//               decoration: const InputDecoration(labelText: 'Email'),
//               keyboardType: TextInputType.emailAddress,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter an email';
//                 }
//                 if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
//                     .hasMatch(value)) {
//                   return 'Please enter a valid email';
//                 }
//                 return null;
//               },
//               onChanged: (value) {
//                 _email = value;
//               },
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _submit,
//               child: const Text('Add Staff'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CaseData {
//   static List<Case> cases = [];

//   static void addCase(Case caseItem) {
//     cases.add(caseItem);
//   }
// }