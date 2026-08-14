import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/color_tokens.dart';
import '../models/medical_data.dart';
import '../models/contact_model.dart';
import '../data/user_store.dart';
import 'add_contact_sheet.dart';

class OnboardingScreen extends StatefulWidget {
  final String userName;
  final VoidCallback onFinish;

  const OnboardingScreen({
    Key? key,
    required this.userName,
    required this.onFinish,
  }) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  // Step 1: Personal Data
  final _nameCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  final _genderCtrl = TextEditingController();
  final _bloodTypeCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();

  // Step 2: Medical History
  final _allergiesCtrl = TextEditingController();
  final _medsCtrl = TextEditingController();
  final _conditionsCtrl = TextEditingController();
  final _donorCtrl = TextEditingController();

  // Step 3: Contacts
  final List<ContactModel> _contacts = [];

  @override
  void initState() {
    super.initState();
    _nameCtrl.text = widget.userName; // Pre-fill name with userName
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameCtrl.dispose();
    _ageCtrl.dispose();
    _genderCtrl.dispose();
    _bloodTypeCtrl.dispose();
    _weightCtrl.dispose();
    _heightCtrl.dispose();
    _allergiesCtrl.dispose();
    _medsCtrl.dispose();
    _conditionsCtrl.dispose();
    _donorCtrl.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _finishOnboarding() {
    // Save MedicalData
    final medicalData = MedicalData(
      name: _nameCtrl.text.trim(),
      age: _ageCtrl.text.trim(),
      gender: _genderCtrl.text.trim(),
      bloodType: _bloodTypeCtrl.text.trim(),
      weight: _weightCtrl.text.trim(),
      height: _heightCtrl.text.trim(),
      allergies: _allergiesCtrl.text.trim(),
      medications: _medsCtrl.text.trim(),
      conditions: _conditionsCtrl.text.trim(),
      donor: _donorCtrl.text.trim(),
    );
    UserStore().updateMedicalData(widget.userName, medicalData);

    // Save Contacts
    UserStore().updateContacts(widget.userName, _contacts);

    // Mark as completed
    UserStore().completeOnboarding(widget.userName);

    // Navigate to Home
    widget.onFinish();
  }

  Future<void> _addContact(LifelineColors tokens) async {
    if (_contacts.length >= 5) return;
    
    final newContact = await showModalBottomSheet<ContactModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => AddContactSheet(tokens: tokens),
    );
    if (newContact != null) {
      setState(() {
        if (_contacts.isEmpty) {
          // First contact is primary
          _contacts.add(ContactModel(
            initials: newContact.initials,
            name: newContact.name,
            relation: newContact.relation,
            phone: newContact.phone,
            isPrimary: true,
          ));
        } else {
          _contacts.add(newContact);
        }
      });
    }
  }

  Widget _buildTextField(String label, TextEditingController controller, LifelineColors tokens) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: tokens.textTertiary,
          ),
        ),
        const SizedBox(height: LifelineSpacing.sm),
        TextField(
          controller: controller,
          style: TextStyle(
            fontSize: 15,
            color: tokens.textPrimary,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: tokens.bgQuaternary.withValues(alpha: 0.4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(LifelineRadius.xl2),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.lg16, vertical: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildStep1(LifelineColors tokens) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(LifelineSpacing.xl2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Langkah 1 dari 3',
            style: TextStyle(color: tokens.textTertiary, fontSize: 13),
          ),
          const SizedBox(height: LifelineSpacing.xs),
          Text(
            'Data Diri & Fisik',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: tokens.textDisplay,
            ),
          ),
          const SizedBox(height: LifelineSpacing.xl3),
          _buildTextField('NAMA LENGKAP', _nameCtrl, tokens),
          const SizedBox(height: LifelineSpacing.lg16),
          Row(
            children: [
              Expanded(child: _buildTextField('UMUR', _ageCtrl, tokens)),
              const SizedBox(width: LifelineSpacing.lg12),
              Expanded(child: _buildTextField('JENIS KELAMIN', _genderCtrl, tokens)),
            ],
          ),
          const SizedBox(height: LifelineSpacing.lg16),
          _buildTextField('GOLONGAN DARAH', _bloodTypeCtrl, tokens),
          const SizedBox(height: LifelineSpacing.lg16),
          Row(
            children: [
              Expanded(child: _buildTextField('BERAT BADAN (KG)', _weightCtrl, tokens)),
              const SizedBox(width: LifelineSpacing.lg12),
              Expanded(child: _buildTextField('TINGGI BADAN (CM)', _heightCtrl, tokens)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStep2(LifelineColors tokens) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(LifelineSpacing.xl2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Langkah 2 dari 3',
            style: TextStyle(color: tokens.textTertiary, fontSize: 13),
          ),
          const SizedBox(height: LifelineSpacing.xs),
          Text(
            'Riwayat Medis',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: tokens.textDisplay,
            ),
          ),
          const SizedBox(height: LifelineSpacing.xl3),
          _buildTextField('ALERGI', _allergiesCtrl, tokens),
          const SizedBox(height: LifelineSpacing.lg16),
          _buildTextField('OBAT RUTIN', _medsCtrl, tokens),
          const SizedBox(height: LifelineSpacing.lg16),
          _buildTextField('PENYAKIT BAWAAN / KONDISI', _conditionsCtrl, tokens),
          const SizedBox(height: LifelineSpacing.lg16),
          _buildTextField('STATUS DONOR ORGAN', _donorCtrl, tokens),
        ],
      ),
    );
  }

  Widget _buildStep3(LifelineColors tokens) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(LifelineSpacing.xl2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Langkah 3 dari 3',
            style: TextStyle(color: tokens.textTertiary, fontSize: 13),
          ),
          const SizedBox(height: LifelineSpacing.xs),
          Text(
            'Kontak Darurat',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: tokens.textDisplay,
            ),
          ),
          const SizedBox(height: LifelineSpacing.sm),
          Text(
            'Tambahkan maksimal 5 kontak yang akan dihubungi saat keadaan darurat. Kontak pertama otomatis menjadi Utama.',
            style: TextStyle(color: tokens.textTertiary, fontSize: 14),
          ),
          const SizedBox(height: LifelineSpacing.xl3),
          
          if (_contacts.isEmpty)
            Container(
              padding: const EdgeInsets.all(LifelineSpacing.xl2),
              decoration: BoxDecoration(
                color: tokens.bgSecondary,
                borderRadius: BorderRadius.circular(LifelineRadius.xl2),
                border: Border.all(color: tokens.borderSecondary),
              ),
              child: Center(
                child: Text(
                  'Belum ada kontak darurat.',
                  style: TextStyle(color: tokens.textTertiary),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _contacts.length,
              separatorBuilder: (ctx, idx) => const SizedBox(height: 10),
              itemBuilder: (ctx, idx) {
                final c = _contacts[idx];
                return Container(
                  padding: const EdgeInsets.all(LifelineSpacing.lg16),
                  decoration: BoxDecoration(
                    color: tokens.bgSecondary,
                    borderRadius: BorderRadius.circular(LifelineRadius.xl2),
                    border: Border.all(
                      color: c.isPrimary ? const Color(0xFF2563EB).withValues(alpha: 0.5) : tokens.borderSecondary,
                      width: c.isPrimary ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: tokens.bgQuaternary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            c.initials,
                            style: TextStyle(
                              color: tokens.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: LifelineSpacing.lg12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              c.name,
                              style: TextStyle(
                                color: tokens.textPrimary,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              '${c.relation} • ${c.phone}',
                              style: TextStyle(
                                color: tokens.textTertiary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (c.isPrimary)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2563EB).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Text(
                            'Utama',
                            style: TextStyle(
                              color: Color(0xFF2563EB),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      else
                        IconButton(
                          icon: Icon(Icons.delete_outline, color: tokens.textTertiary, size: 20),
                          onPressed: () {
                            setState(() {
                              _contacts.removeAt(idx);
                            });
                          },
                        ),
                    ],
                  ),
                );
              },
            ),
          
          const SizedBox(height: LifelineSpacing.lg16),
          OutlinedButton.icon(
            onPressed: _contacts.length >= 5 ? null : () => _addContact(tokens),
            icon: const Icon(Icons.add),
            label: const Text('Tambah Kontak'),
            style: OutlinedButton.styleFrom(
              foregroundColor: tokens.textPrimary,
              side: BorderSide(color: tokens.borderSecondary),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(LifelineRadius.xl)),
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<LifelineColors>() ?? LifelineColors.light;

    return Scaffold(
      backgroundColor: tokens.bgPrimary,
      appBar: AppBar(
        leading: _currentStep > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _previousStep,
              )
            : null,
        title: const Text('Profil Medis Darurat'),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Prevent swipe to make them use buttons
        onPageChanged: (idx) {
          setState(() {
            _currentStep = idx;
          });
        },
        children: [
          _buildStep1(tokens),
          _buildStep2(tokens),
          _buildStep3(tokens),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(LifelineSpacing.xl2),
          child: ElevatedButton(
            onPressed: _nextStep,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935), // Red
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(LifelineRadius.xl)),
              minimumSize: const Size(double.infinity, 52),
            ),
            child: Text(_currentStep == 2 ? 'Selesai & Simpan' : 'Selanjutnya'),
          ),
        ),
      ),
    );
  }
}
