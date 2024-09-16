import 'package:flutter/material.dart';
import '../components/references/hematology.dart';
import '../components/references/heart-rate.dart';

class ReferencesPage extends StatelessWidget {
  const ReferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const TabBarExample(),
    );
  }
}

class TabBarExample extends StatelessWidget {
  const TabBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('References'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.bloodtype_outlined),
                text: 'Hematology (Complete Blood Count) Reference Ranges',
              ),
              Tab(
                icon: Icon(Icons.monitor_heart_outlined),
                text: 'Resting Heart Rates',
              ),
              Tab(
                icon: Icon(Icons.heat_pump_outlined),
                text: 'Normal Rectal Tempereture',
              ),
              Tab(
                icon: Icon(Icons.rate_review_outlined),
                text: 'Resting Respiratory Rates',
              ),
              Tab(
                icon: Icon(Icons.biotech_outlined),
                text: 'Secrum Biochemical Analysis Reference Range',
              ),
              Tab(
                icon: Icon(Icons.type_specimen_outlined),
                text: 'Urin Volume and Specific Gravity',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: Hematology(),
            ),
            Center(
              child: HeartRate(),
            ),
            Center(
              child: Hematology(),
            ),
            Center(
              child: Hematology(),
            ),
            Center(
              child: Hematology(),
            ),
            Center(
              child: Hematology(),
            ),
            // const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class Hematology extends StatelessWidget {
  Hematology({super.key});
  final datas = getHematologyData();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('')),
              DataColumn(label: Text('Conventional Units(USA)')),
              DataColumn(label: Text('SI Units')),
              DataColumn(label: Text('Dog')),
              DataColumn(label: Text('Cat')),
              DataColumn(label: Text('Cow')),
              DataColumn(label: Text('Horse')),
              DataColumn(label: Text('Pig')),
            ],
            rows: datas.map((user) {
              return DataRow(cells: [
                DataCell(Text(user.name)),
                DataCell(Text(user.conventionalUnits)),
                DataCell(Text(user.siUnits)),
                DataCell(Text(user.dog)),
                DataCell(Text(user.cat)),
                DataCell(Text(user.cow)),
                DataCell(Text(user.horse)),
                DataCell(Text(user.pig)),
              ]);
            }).toList(),
          ),
        ));
  }
}

class HeartRate extends StatelessWidget {
  HeartRate({super.key});
  final datas = getHeartRateData();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Species')),
              DataColumn(label: Text('bpm (range)')),
            ],
            rows: datas.map((user) {
              return DataRow(cells: [
                DataCell(Text(user.specie)),
                DataCell(Text(user.bpm)),
              ]);
            }).toList(),
          ),
        ));
  }
}
