import 'package:flutter/material.dart';
import 'package:test_drive/pages/cases.dart';
// import 'package:test_drive/pages/login.dart';
import '../pages/references.dart';
import '../pages/settings.dart';
import '../pages/staffs.dart';
import '../pages/case_details.dart';

//for mock case
import '../models/case_model.dart';

class Sidebar extends StatelessWidget {
  final Function(Widget) onSelectPage;
  final Function onLogout;

  const Sidebar(
      {super.key, required this.onSelectPage, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: Colors.lightBlueAccent,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 80, // Set your desired height here
            child: Center(
              child: Text(
                'PetDreams',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  // backgroundColor: Colors.white70,
                ),
              ),
            ),
          ),
          // const SizedBox(),

          ListTile(
            leading: const Icon(Icons.cases_outlined, color: Colors.white),
            title: const Text('Cases', style: TextStyle(color: Colors.white)),
            onTap: () => onSelectPage(const CasesPage()),
          ),
          ListTile(
            leading: const Icon(Icons.cases_outlined, color: Colors.white),
            title: const Text('Case Details',
                style: TextStyle(color: Colors.white)),
            onTap: () => onSelectPage(CaseDetailsPage(caseItem: (mockCase))),
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.white),
            title:
                const Text('Settings', style: TextStyle(color: Colors.white)),
            onTap: () => onSelectPage(const SettingsPage()),
          ),
          ListTile(
            leading: const Icon(Icons.people_outlined, color: Colors.white),
            title: const Text('Staffs', style: TextStyle(color: Colors.white)),
            onTap: () => onSelectPage(const StaffsPage()),
          ),
          ListTile(
            hoverColor: Colors.lightBlue,
            focusColor: Colors.lightBlue,
            leading: const Icon(Icons.list, color: Colors.white),
            title: const Text('Referencess',
                style: TextStyle(
                  color: Colors.white,
                )),
            onTap: () => onSelectPage(const ReferencesPage()),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => onLogout(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Change color as needed
                minimumSize: const Size(double.infinity, 40), // Full width
              ),
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              // const Icon(
              //   Icons.logout,
              //   color: Colors.white,
              // ),
            ),
          ),
        ],
      ),
    );
  }
}

Case mockCase = Case(
  fileNumber: 'C123456',
  name: 'Buddy',
  age: 5,
  weight: '25 lbs',
  specie: 'Dog',
  breed: 'Golden Retriever',
  sex: 'Male',
  color: 'Golden',
  ownersName: 'John Doe',
  address: '123 Elm Street, Springfield, IL',
  phone: 1234567890,
  email: 'johndoe@example.com',
  allergies: 'Peanuts',
  existingCondition: 'None',
);
