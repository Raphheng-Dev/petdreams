class Data {
  final String specie;
  final String bpm;

  Data({
    required this.specie,
    required this.bpm,
  });
}

List<Data> getHeartRateData() {
  return [
    Data(
      specie: 'Cat',
      bpm: '120-140',
    ),
    Data(
      specie: 'Dog',
      bpm: '70-120',
    ),
    Data(
      specie: 'Horse',
      bpm: '28-40',
    ),
    Data(
      specie: 'Rabbit',
      bpm: '180-350',
    ),
    Data(
      specie: 'Guinea pig',
      bpm: '200-300',
    ),
    Data(
      specie: 'Hamster',
      bpm: '300-600',
    ),
    Data(
      specie: 'Mouse',
      bpm: '450-750',
    ),
    Data(
      specie: 'Rat',
      bpm: '250-400',
    ),
    Data(
      specie: 'Dairy cow',
      bpm: '48-84',
    ),
    Data(
      specie: 'Goat',
      bpm: '70-80',
    ),
    Data(
      specie: 'Sheep',
      bpm: '70-80',
    ),
    Data(
      specie: 'Pig',
      bpm: '70-120',
    ),
    Data(
      specie: 'Chick',
      bpm: '350-450',
    ),
    Data(
      specie: 'Chicken(adult)',
      bpm: '250-300',
    ),
    Data(
      specie: 'Ox',
      bpm: '36-60',
    ),
    Data(
      specie: 'Rhesus monkey (anesthetized)',
      bpm: '160-330',
    ),
    Data(
      specie: 'Elephant',
      bpm: '25-35',
    ),
  ];
}
