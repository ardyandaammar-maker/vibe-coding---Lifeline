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

  String _key(String userName) => userName.trim().toLowerCase();

  UserStore._internal() {
    completeOnboarding('Ammar');
    completeOnboarding('Rizky Pratama');
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
    return _completedOnboarding.contains(_key(userName));
  }

  void completeOnboarding(String userName) {
    _completedOnboarding.add(_key(userName));
  }

  MedicalData getMedicalData(String userName) {
    final k = _key(userName);
    if (!_medicalDataMap.containsKey(k)) {
      _medicalDataMap[k] = hasCompletedOnboarding(userName) 
          ? MedicalData.initial() 
          : MedicalData.empty();
    }
    return _medicalDataMap[k]!;
  }

  void updateMedicalData(String userName, MedicalData data) {
    final k = _key(userName);
    _medicalDataMap[k] = data;
    _completedOnboarding.add(k);
  }

  List<ContactModel> getContacts(String userName) {
    final k = _key(userName);
    if (!_contactsMap.containsKey(k)) {
      if (hasCompletedOnboarding(userName)) {
        _contactsMap[k] = [
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
        _contactsMap[k] = [];
      }
    }
    return _contactsMap[k]!;
  }

  void updateContacts(String userName, List<ContactModel> contacts) {
    final k = _key(userName);
    _contactsMap[k] = contacts;
  }
}
