import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory UserAccount.fromJson(Map<String, dynamic> json) {
    return UserAccount(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }
}

class UserStore {
  static final UserStore _instance = UserStore._internal();
  factory UserStore() => _instance;

  String _key(String userName) => userName.trim().toLowerCase();

  UserStore._internal();

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

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _loadFromDisk();
  }

  void _loadFromDisk() {
    if (_prefs == null) return;

    // Load registered accounts
    final String? accountsJson = _prefs!.getString('user_store_registered_accounts');
    if (accountsJson != null && accountsJson.isNotEmpty) {
      try {
        final List<dynamic> decoded = jsonDecode(accountsJson);
        _registeredAccounts.clear();
        for (final item in decoded) {
          _registeredAccounts.add(UserAccount.fromJson(Map<String, dynamic>.from(item)));
        }
      } catch (_) {}
    }

    // Load completed onboarding set
    final List<String>? onboardingList = _prefs!.getStringList('user_store_completed_onboarding');
    if (onboardingList != null) {
      _completedOnboarding.clear();
      _completedOnboarding.addAll(onboardingList);
    } else {
      completeOnboarding('Ammar');
      completeOnboarding('Rizky Pratama');
    }

    // Load medical data map
    final String? medicalJson = _prefs!.getString('user_store_medical_data_map');
    if (medicalJson != null && medicalJson.isNotEmpty) {
      try {
        final Map<String, dynamic> decoded = jsonDecode(medicalJson);
        _medicalDataMap.clear();
        decoded.forEach((key, val) {
          _medicalDataMap[key] = MedicalData.fromJson(Map<String, dynamic>.from(val));
        });
      } catch (_) {}
    }

    // Load contacts map
    final String? contactsJson = _prefs!.getString('user_store_contacts_map');
    if (contactsJson != null && contactsJson.isNotEmpty) {
      try {
        final Map<String, dynamic> decoded = jsonDecode(contactsJson);
        _contactsMap.clear();
        decoded.forEach((key, val) {
          final List<dynamic> list = val;
          _contactsMap[key] = list.map((c) => ContactModel.fromJson(Map<String, dynamic>.from(c))).toList();
        });
      } catch (_) {}
    }
  }

  void _saveAccounts() {
    if (_prefs == null) return;
    final String jsonStr = jsonEncode(_registeredAccounts.map((a) => a.toJson()).toList());
    _prefs!.setString('user_store_registered_accounts', jsonStr);
  }

  void _saveCompletedOnboarding() {
    if (_prefs == null) return;
    _prefs!.setStringList('user_store_completed_onboarding', _completedOnboarding.toList());
  }

  void _saveMedicalData() {
    if (_prefs == null) return;
    final Map<String, dynamic> encodable = {};
    _medicalDataMap.forEach((k, v) {
      encodable[k] = v.toJson();
    });
    _prefs!.setString('user_store_medical_data_map', jsonEncode(encodable));
  }

  void _saveContacts() {
    if (_prefs == null) return;
    final Map<String, dynamic> encodable = {};
    _contactsMap.forEach((k, v) {
      encodable[k] = v.map((c) => c.toJson()).toList();
    });
    _prefs!.setString('user_store_contacts_map', jsonEncode(encodable));
  }

  List<UserAccount> get registeredAccounts => _registeredAccounts;

  void registerAccount(UserAccount account) {
    _registeredAccounts.add(account);
    _saveAccounts();
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
    _saveCompletedOnboarding();
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
    _saveMedicalData();
    _saveCompletedOnboarding();
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
    _saveContacts();
  }
}
