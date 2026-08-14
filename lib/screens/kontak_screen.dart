import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/contact_model.dart';
import 'add_contact_sheet.dart';
import '../data/user_store.dart';

class KontakScreen extends StatefulWidget {
  final LifelineColors tokens;
  final String userName;

  const KontakScreen({
    Key? key,
    required this.tokens,
    required this.userName,
  }) : super(key: key);

  @override
  State<KontakScreen> createState() => _KontakScreenState();
}

class _KontakScreenState extends State<KontakScreen> {
  late List<ContactModel> _contacts;

  @override
  void initState() {
    super.initState();
    _contacts = UserStore().getContacts(widget.userName);
  }

  void _deleteContact(ContactModel contact) {
    setState(() {
      _contacts.remove(contact);
      UserStore().updateContacts(widget.userName, _contacts);
    });
  }

  Future<void> _makePhoneCall(BuildContext context, String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber.replaceAll(' ', ''),
    );
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('📞 Memanggil $phoneNumber...'),
            backgroundColor: const Color(0xFF2563EB),
          ),
        );
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('📞 Memanggil $phoneNumber...'),
          backgroundColor: const Color(0xFF2563EB),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = widget.tokens;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.xl2, vertical: LifelineSpacing.lg12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Tag
          const Text(
            'Kontak Darurat',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2563EB),
            ),
          ),
          const SizedBox(height: LifelineSpacing.xs),

          // Title
          Text(
            '${_contacts.length} orang siap menerima notifikasimu.',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: tokens.textDisplay,
              letterSpacing: -0.5,
              height: 1.15,
            ),
          ),
          const SizedBox(height: LifelineSpacing.sm),

          // Subtitle
          Text(
            'Otomatis diberi tahu lokasi & kondisi saat SOS aktif.',
            style: TextStyle(
              fontSize: 13,
              color: tokens.textTertiary,
              height: 1.35,
            ),
          ),
          const SizedBox(height: LifelineSpacing.xl2),

          // Contacts List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _contacts.length,
            separatorBuilder: (ctx, idx) => const SizedBox(height: 10),
            itemBuilder: (ctx, idx) {
              final contact = _contacts[idx];
              return _buildContactCard(context, tokens, contact);
            },
          ),
          const SizedBox(height: LifelineSpacing.lg16),

          // Add Contact Button (Max 5)
          OutlinedButton(
            onPressed: _contacts.length >= 5
                ? null
                : () async {
                    final newContact = await showModalBottomSheet<ContactModel>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (ctx) => AddContactSheet(tokens: widget.tokens),
                    );
                    if (newContact != null) {
                      setState(() {
                        _contacts.add(newContact);
                        UserStore().updateContacts(widget.userName, _contacts);
                      });
                    }
                  },
            style: OutlinedButton.styleFrom(
              backgroundColor: tokens.bgPrimary,
              foregroundColor: const Color(0xFFE53935),
              minimumSize: const Size(double.infinity, 52),
              side: BorderSide(color: tokens.borderSecondary, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(LifelineRadius.xl2),
              ),
            ),
            child: const Text(
              '+ Tambah Kontak (maks. 5)',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 28),

          // Footer Note
          Center(
            child: Text(
              'Lifeline • Setiap detik penting',
              style: TextStyle(
                fontSize: 11,
                color: tokens.textTertiary.withValues(alpha: 0.7),
              ),
            ),
          ),
          const SizedBox(height: LifelineSpacing.xl2),
        ],
      ),
    );
  }

  Widget _buildContactCard(BuildContext context, LifelineColors tokens, ContactModel contact) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.lg16, vertical: 14),
      decoration: BoxDecoration(
        color: tokens.bgSecondary,
        borderRadius: BorderRadius.circular(LifelineRadius.xl3),
        border: Border.all(color: tokens.borderPrimary.withValues(alpha: 0.6), width: 1),
      ),
      child: Row(
        children: [
          // Initials Avatar
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: tokens.bgPrimary,
              shape: BoxShape.circle,
              border: Border.all(color: tokens.borderPrimary, width: 1),
            ),
            child: Center(
              child: Text(
                contact.initials,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: tokens.textPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      contact.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: tokens.textPrimary,
                      ),
                    ),
                    if (contact.isPrimary) ...[
                      const SizedBox(width: LifelineSpacing.md),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.md, vertical: LifelineSpacing.xxs),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2563EB),
                          borderRadius: BorderRadius.circular(LifelineRadius.lg),
                        ),
                        child: const Text(
                          'Utama',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: LifelineSpacing.xxs),
                Text(
                  '${contact.relation} · ${contact.phone}',
                  style: TextStyle(
                    fontSize: 12,
                    color: tokens.textTertiary,
                  ),
                ),
              ],
            ),
          ),

          // Call Phone Action Button
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: tokens.bgPrimary,
              shape: BoxShape.circle,
              border: Border.all(color: tokens.borderPrimary, width: 1),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.phone_outlined, size: 18, color: Color(0xFF2563EB)),
              onPressed: () => _makePhoneCall(context, contact.phone),
            ),
          ),
          const SizedBox(width: LifelineSpacing.md),

          // Delete Action Button
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: tokens.bgPrimary,
              shape: BoxShape.circle,
              border: Border.all(color: tokens.borderPrimary, width: 1),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.delete_outline_rounded, size: 18, color: Color(0xFFE53935)),
              onPressed: () => _deleteContact(contact),
            ),
          ),
        ],
      ),
    );
  }
}
