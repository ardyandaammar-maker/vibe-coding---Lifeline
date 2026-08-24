import '../models/medical_data.dart';
import '../models/contact_model.dart';

class UserAccount {
  final String name;
  final String email;
  final String password;

  UserAccount({
    required this.name,
    required this.email,
    required this.password,
  });
}

class UserStore {
  static final UserStore _instance = UserStore._internal();
  factory UserStore() => _instance;

  UserStore._internal() {
    _completedOnboarding.add('Ammar');
    _completedOnboarding.add('Rizky Pratama');
  }

  final Map<String, MedicalData> _medicalDataMap = {};
  final Map<String, List<ContactModel>> _contactsMap = {};
  final Set<String> _completedOnboarding = {};
  final List<UserAccount> _registeredAccounts = [
    UserAccount(
      name: 'Ammar',
      email: 'ammar@lifeline.id',
      password: 'secret123',
    ),
    UserAccount(
      name: 'Rizky Pratama',
      email: 'rizky@lifeline.id',
      password: 'secret123',
    ),
  ];

  List<UserAccount> get registeredAccounts => _registeredAccounts;

  void registerAccount(UserAccount account) {
    _registeredAccounts.add(account);
  }

  bool isEmailRegistered(String email) {
    final search = email.trim().toLowerCase();
    return _registeredAccounts.any((acc) => acc.email.trim().toLowerCase() == search);
  }

  UserAccount? findAccount(String email, String password) {
    final searchEmail = email.trim().toLowerCase();
    for (final acc in _registeredAccounts) {
      if (acc.email.trim().toLowerCase() == searchEmail && acc.password == password) {
        return acc;
      }
    }
    return null;
  }

  bool hasCompletedOnboarding(String userName) {
    return _completedOnboarding.contains(userName);
  }

  void completeOnboarding(String userName) {
    _completedOnboarding.add(userName);
  }

  MedicalData getMedicalData(String userName) {
    if (!_medicalDataMap.containsKey(userName)) {
      _medicalDataMap[userName] = hasCompletedOnboarding(userName) 
          ? MedicalData.initial() 
          : MedicalData.empty();
    }
    return _medicalDataMap[userName]!;
  }

  void updateMedicalData(String userName, MedicalData data) {
    _medicalDataMap[userName] = data;
  }

  List<ContactModel> getContacts(String userName) {
    if (!_contactsMap.containsKey(userName)) {
      if (hasCompletedOnboarding(userName)) {
        _contactsMap[userName] = [
          ContactModel(
            initials: 'BH',
            name: 'Bapak Hendra',
            relation: 'Ayah',
            phone: '+62 812 8899 1122',
            isPrimary: true,
          ),
          ContactModel(
            initials: 'IS',
            name: 'Ibu Sari',
            relation: 'Ibu',
            phone: '+62 813 4455 7788',
          ),
          ContactModel(
            initials: 'DP',
            name: 'Dinda Pratami',
            relation: 'Saudara',
            phone: '+62 821 3344 5566',
          ),
          ContactModel(
            initials: 'dA',
            name: 'dr. Anisa Wijaya',
            relation: 'Dokter Pribadi',
            phone: '+62 811 2233 4455',
          ),
        ];
      } else {
        _contactsMap[userName] = [];
      }
    }
    return _contactsMap[userName]!;
  }

  void updateContacts(String userName, List<ContactModel> contacts) {
    _contactsMap[userName] = contacts;
  }
}
