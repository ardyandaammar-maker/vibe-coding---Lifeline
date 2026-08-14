import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/contact_model.dart';

class AddContactSheet extends StatefulWidget {
  final LifelineColors tokens;

  const AddContactSheet({
    Key? key,
    required this.tokens,
  }) : super(key: key);

  @override
  State<AddContactSheet> createState() => _AddContactSheetState();
}

class _AddContactSheetState extends State<AddContactSheet> {
  final _nameCtrl = TextEditingController();
  final _relationCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  bool _isPrimary = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _relationCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  String _getInitials(String name) {
    if (name.isEmpty) return 'NA';
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length > 1) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: widget.tokens.textTertiary,
          ),
        ),
        const SizedBox(height: LifelineSpacing.md),
        TextFormField(
          controller: controller,
          style: TextStyle(
            fontSize: 15,
            color: widget.tokens.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 15,
              color: widget.tokens.textTertiary.withValues(alpha: 0.6),
            ),
            filled: true,
            fillColor: widget.tokens.bgSecondary,
            contentPadding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.lg16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(LifelineRadius.xl2),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Adding viewInsets to pad bottom for keyboard
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: widget.tokens.bgPrimary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.xl2, vertical: 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag Handle
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: widget.tokens.borderSecondary,
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
                      'Tambah Kontak',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: widget.tokens.textDisplay,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: LifelineSpacing.xxs),
                    Text(
                      'Orang ini akan dihubungi saat SOS aktif.',
                      style: TextStyle(
                        fontSize: 13,
                        color: widget.tokens.textTertiary,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: widget.tokens.bgSecondary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.close, size: 18, color: widget.tokens.textTertiary),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: LifelineSpacing.xl3),

            // Form Fields
            _buildTextField('NAMA', 'Nama lengkap', _nameCtrl),
            const SizedBox(height: LifelineSpacing.lg16),

            _buildTextField('HUBUNGAN', 'Ayah, Ibu, Dokter...', _relationCtrl),
            const SizedBox(height: LifelineSpacing.lg16),

            _buildTextField('TELEPON', '+62 812 3456 7890', _phoneCtrl),
            const SizedBox(height: LifelineSpacing.lg16),

            // Primary Contact Switch
            Container(
              padding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.lg16, vertical: 10),
              decoration: BoxDecoration(
                color: widget.tokens.bgSecondary,
                borderRadius: BorderRadius.circular(LifelineRadius.xl2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Jadikan kontak utama',
                    style: TextStyle(
                      fontSize: 15,
                      color: widget.tokens.textPrimary,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        _isPrimary ? 'Ya' : 'Tidak',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: widget.tokens.textTertiary,
                        ),
                      ),
                      const SizedBox(width: LifelineSpacing.md),
                      Switch(
                        value: _isPrimary,
                        onChanged: (val) => setState(() => _isPrimary = val),
                        activeThumbColor: const Color(0xFF2563EB),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: LifelineSpacing.xl3),

            // Save Button
            ElevatedButton(
              onPressed: () {
                final newContact = ContactModel(
                  initials: _getInitials(_nameCtrl.text),
                  name: _nameCtrl.text,
                  relation: _relationCtrl.text,
                  phone: _phoneCtrl.text,
                  isPrimary: _isPrimary,
                );
                Navigator.pop(context, newContact);
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
            const SizedBox(height: LifelineSpacing.xl3),
          ],
        ),
      ),
    );
  }
}
