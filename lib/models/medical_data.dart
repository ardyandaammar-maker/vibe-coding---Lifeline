class MedicalData {
  final String name;
  final String age;
  final String gender;
  final String bloodType;
  final String weight;
  final String height;
  final String allergies;
  final String medications;
  final String conditions;
  final String donor;

  const MedicalData({
    required this.name,
    required this.age,
    required this.gender,
    required this.bloodType,
    required this.weight,
    required this.height,
    required this.allergies,
    required this.medications,
    required this.conditions,
    required this.donor,
  });

  factory MedicalData.initial() {
    return const MedicalData(
      name: 'Rizky Pratama',
      age: '28',
      gender: 'Pria',
      bloodType: 'O+',
      weight: '72 kg',
      height: '176',
      allergies: 'Penisilin, Udang',
      medications: 'Amlodipine 5mg',
      conditions: 'Hipertensi',
      donor: 'Ya',
    );
  }

  factory MedicalData.empty() {
    return const MedicalData(
      name: '',
      age: '',
      gender: '',
      bloodType: '',
      weight: '',
      height: '',
      allergies: '',
      medications: '',
      conditions: '',
      donor: '',
    );
  }
}
