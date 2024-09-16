class Data {
  final String name;
  final String conventionalUnits;
  final String siUnits;
  final String dog;
  final String cat;
  final String cow;
  final String horse;
  final String pig;

  Data(
      {required this.name,
      required this.conventionalUnits,
      required this.siUnits,
      required this.dog,
      required this.cat,
      required this.cow,
      required this.horse,
      required this.pig});
}

List<Data> getHematologyData() {
  return [
    Data(
        name: 'PCV',
        conventionalUnits: '%',
        siUnits: 'x10^(-2)L/L',
        dog: '35-57',
        cat: '30-45',
        cow: '24-46',
        horse: '27-43',
        pig: '32-50'),
    Data(
        name: 'Hgb',
        conventionalUnits: 'g/dL',
        siUnits: 'x10g/L',
        dog: '11.9-18.9',
        cat: '9.8-15.4',
        cow: '8-15',
        horse: '10.1-16.1',
        pig: '10-16'),
    Data(
        name: 'RBCs',
        conventionalUnits: 'x10^6/mcL',
        siUnits: 'x10^12/L',
        dog: '4.95-7.87',
        cat: '5.0-10.0',
        cow: '5.0-10.0',
        horse: '6.0-10.4',
        pig: '5-8'),
    Data(
        name: 'Reticulocytes',
        conventionalUnits: '%',
        siUnits: '%',
        dog: '0-1.0',
        cat: '0-0.6',
        cow: '',
        horse: '',
        pig: '0-1.0'),
    Data(
        name: 'Absolute reticulocyte',
        conventionalUnits: 'x10^3/mcL',
        siUnits: 'x10^9/L',
        dog: '<80',
        cat: '<60',
        cow: '',
        horse: '',
        pig: ''),
    Data(
        name: 'MCV',
        conventionalUnits: 'fL',
        siUnits: 'fL',
        dog: '66-77',
        cat: '39-55',
        cow: '40-60',
        horse: '37-49',
        pig: '50-68'),
    Data(
        name: 'MCH',
        conventionalUnits: 'pg',
        siUnits: 'pg',
        dog: '21.0-26.2',
        cat: '13-17',
        cow: '11-17',
        horse: '13.7-18.2',
        pig: '17-21'),
    Data(
        name: '',
        conventionalUnits: '',
        siUnits: '',
        dog: '',
        cat: '',
        cow: '',
        horse: '',
        pig: ''),
    Data(
        name: '',
        conventionalUnits: '',
        siUnits: '',
        dog: '',
        cat: '',
        cow: '',
        horse: '',
        pig: ''),
    Data(
        name: '',
        conventionalUnits: '',
        siUnits: '',
        dog: '',
        cat: '',
        cow: '',
        horse: '',
        pig: ''),
  ];
}
