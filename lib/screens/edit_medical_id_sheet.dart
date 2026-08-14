import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/medical_data.dart';


class EditMedicalIdSheet extends StatefulWidget {
  final LifelineColors tokens;
  final MedicalData initialData;

  const EditMedicalIdSheet({
    Key? key,
    required this.tokens,
    required this.initialData,
  }) : super(key: key);

  @override
  State<EditMedicalIdSheet> createState() => _EditMedicalIdSheetState();
}

class _EditMedicalIdSheetState extends State<EditMedicalIdSheet> {
  // Controllers
  late final TextEditingController _nameCtrl;
  late final TextEditingController _ageCtrl;
  late final TextEditingController _genderCtrl;
  late final TextEditingController _bloodCtrl;
  late final TextEditingController _weightCtrl;
  late final TextEditingController _heightCtrl;
  late final TextEditingController _allergyCtrl;
  late final TextEditingController _medsCtrl;
  late final TextEditingController _conditionsCtrl;
  late final TextEditingController _donorCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.initialData.name);
    _ageCtrl = TextEditingController(text: widget.initialData.age);
    _genderCtrl = TextEditingController(text: widget.initialData.gender);
    _bloodCtrl = TextEditingController(text: widget.initialData.bloodType);
    _weightCtrl = TextEditingController(text: widget.initialData.weight);
    _heightCtrl = TextEditingController(text: widget.initialData.height);
    _allergyCtrl = TextEditingController(text: widget.initialData.allergies);
    _medsCtrl = TextEditingController(text: widget.initialData.medications);
    _conditionsCtrl = TextEditingController(text: widget.initialData.conditions);
    _donorCtrl = TextEditingController(text: widget.initialData.donor);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _ageCtrl.dispose();
    _genderCtrl.dispose();
    _bloodCtrl.dispose();
    _weightCtrl.dispose();
    _heightCtrl.dispose();
    _allergyCtrl.dispose();
    _medsCtrl.dispose();
    _conditionsCtrl.dispose();
    _donorCtrl.dispose();
    super.dispose();
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: widget.tokens.textTertiary,
          ),
        ),
        const SizedBox(height: LifelineSpacing.sm),
        TextField(
          controller: controller,
          style: TextStyle(
            fontSize: 15,
            color: widget.tokens.textPrimary,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: widget.tokens.bgQuaternary.withValues(alpha: 0.4),
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

  @override
  Widget build(BuildContext context) {
    final tokens = widget.tokens;
    
    // Calculate a good height based on screen size (usually around 90%)
    return Container(
      height: MediaQuery.of(context).size.height * 0.90,
      decoration: BoxDecoration(
        color: tokens.bgPrimary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.xl2, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: tokens.borderSecondary,
                borderRadius: BorderRadius.circular(LifelineRadius.xxs),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit Medical ID',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: tokens.textDisplay,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: LifelineSpacing.xxs),
                  Text(
                    'Perbarui informasi medismu kapan saja.',
                    style: TextStyle(
                      fontSize: 13,
                      color: tokens.textTertiary,
                    ),
                  ),
                ],
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: tokens.bgSecondary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.close, size: 18, color: tokens.textTertiary),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: LifelineSpacing.xl3),

          // Form fields (Scrollable)
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildTextField('NAMA LENGKAP', _nameCtrl),
                  const SizedBox(height: LifelineSpacing.lg16),
                  
                  Row(
                    children: [
                      Expanded(child: _buildTextField('USIA', _ageCtrl)),
                      const SizedBox(width: LifelineSpacing.lg12),
                      Expanded(child: _buildTextField('JENIS KELAMIN', _genderCtrl)),
                    ],
                  ),
                  const SizedBox(height: LifelineSpacing.lg16),
                  
                  Row(
                    children: [
                      Expanded(flex: 2, child: _buildTextField('GOL. DARAH', _bloodCtrl)),
                      const SizedBox(width: LifelineSpacing.lg12),
                      Expanded(flex: 3, child: _buildTextField('BERAT', _weightCtrl)),
                      const SizedBox(width: LifelineSpacing.lg12),
                      Expanded(flex: 3, child: _buildTextField('TINGGI', _heightCtrl)),
                    ],
                  ),
                  const SizedBox(height: LifelineSpacing.lg16),
                  
                  _buildTextField('ALERGI', _allergyCtrl),
                  const SizedBox(height: LifelineSpacing.lg16),
                  
                  _buildTextField('OBAT RUTIN', _medsCtrl),
                  const SizedBox(height: LifelineSpacing.lg16),
                  
                  _buildTextField('KONDISI', _conditionsCtrl),
                  const SizedBox(height: LifelineSpacing.lg16),
                  
                  _buildTextField('DONOR ORGAN', _donorCtrl),
                  const SizedBox(height: LifelineSpacing.xl3),
                ],
              ),
            ),
          ),

          // Action Buttons
          const SizedBox(height: LifelineSpacing.lg16),
          ElevatedButton(
            onPressed: () {
              final newData = MedicalData(
                name: _nameCtrl.text,
                age: _ageCtrl.text,
                gender: _genderCtrl.text,
                bloodType: _bloodCtrl.text,
                weight: _weightCtrl.text,
                height: _heightCtrl.text,
                allergies: _allergyCtrl.text,
                medications: _medsCtrl.text,
                conditions: _conditionsCtrl.text,
                donor: _donorCtrl.text,
              );
              Navigator.pop(context, newData);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(LifelineRadius.xl),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Simpan Perubahan',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: LifelineSpacing.lg12),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              backgroundColor: tokens.bgPrimary,
              foregroundColor: tokens.textPrimary,
              minimumSize: const Size(double.infinity, 50),
              side: BorderSide(color: tokens.borderSecondary, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(LifelineRadius.xl),
              ),
            ),
            child: const Text(
              'Batal',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: LifelineSpacing.md),
        ],
      ),
    );
  }
}
