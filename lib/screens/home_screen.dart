import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'layanan_terdekat_sheet.dart';
import 'facility_detail_sheet.dart';
import 'medical_id_screen.dart';
import 'kontak_screen.dart';
import 'panduan_screen.dart';
import 'riwayat_screen.dart';
import 'edit_medical_id_sheet.dart';
import '../models/medical_data.dart';
import '../data/user_store.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  final VoidCallback onSignOut;
  final VoidCallback onToggleTheme;
  final VoidCallback onTriggerSos;
  final bool isDarkMode;

  const HomeScreen({
    Key? key,
    this.userName = 'Ammar',
    required this.onSignOut,
    required this.onToggleTheme,
    required this.onTriggerSos,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBottomTab = 0;
  bool _isSosPressed = false;
  late MedicalData _medicalData;

  @override
  void initState() {
    super.initState();
    _medicalData = UserStore().getMedicalData(widget.userName);
  }

  void _showLayananTerdekatBottomSheet(
      BuildContext context, LifelineColors tokens) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return LayananTerdekatSheet(tokens: tokens);
      },
    );
  }

  void _showFacilityDetailBottomSheet(
      BuildContext context, LifelineColors tokens, FacilityModel facility) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FacilityDetailSheet(
          facility: facility,
          tokens: tokens,
          onCall112: () {
            Navigator.pop(context);
            _showPanggil112BottomSheet(context, tokens);
          },
        );
      },
    );
  }

  void _showPanggil112BottomSheet(BuildContext context, LifelineColors tokens) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: tokens.bgPrimary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: LifelineSpacing.xl2, vertical: LifelineSpacing.lg16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: tokens.borderSecondary,
                  borderRadius: BorderRadius.circular(LifelineRadius.xxs),
                ),
              ),
              const SizedBox(height: LifelineSpacing.lg16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Panggil 112',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: tokens.textDisplay,
                      letterSpacing: -0.3,
                    ),
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
                      icon: Icon(Icons.close,
                          size: 18, color: tokens.textTertiary),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: LifelineSpacing.xs),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Layanan darurat nasional — polisi, ambulans, pemadam.',
                  style: TextStyle(
                    fontSize: 13,
                    color: tokens.textTertiary,
                    height: 1.35,
                  ),
                ),
              ),
              const SizedBox(height: LifelineSpacing.xl2),
              Container(
                padding: const EdgeInsets.all(LifelineSpacing.lg16),
                decoration: BoxDecoration(
                  color: tokens.bgSecondary,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: tokens.borderPrimary, width: 1),
                ),
                child: Column(
                  children: [
                    _buildModalInfoRow(
                      tokens: tokens,
                      icon: Icons.navigation_outlined,
                      text: 'Lokasi GPS dikirim otomatis',
                    ),
                    const SizedBox(height: 14),
                    _buildModalInfoRow(
                      tokens: tokens,
                      icon: Icons.favorite_outline_rounded,
                      text: 'Medical ID dibagikan ke petugas',
                    ),
                    const SizedBox(height: 14),
                    _buildModalInfoRow(
                      tokens: tokens,
                      icon: Icons.people_outline_rounded,
                      text: 'Kontak darurat diberi notifikasi',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: LifelineSpacing.xl3),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('🚨 Menghubungi 112... Sinyal darurat dikirim.'),
                      backgroundColor: Color(0xFFE53935),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE53935),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(LifelineRadius.xl2),
                  ),
                  elevation: 0,
                ),
                icon: const Icon(Icons.phone_in_talk_rounded, size: 20),
                label: const Text(
                  'Panggil sekarang',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  backgroundColor: tokens.bgPrimary,
                  foregroundColor: tokens.textPrimary,
                  minimumSize: const Size(double.infinity, 52),
                  side: BorderSide(color: tokens.borderSecondary, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(LifelineRadius.xl2),
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
              const SizedBox(height: LifelineSpacing.lg12),
            ],
          ),
        );
      },
    );
  }

  Widget _buildModalInfoRow({
    required LifelineColors tokens,
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF2563EB)),
        const SizedBox(width: LifelineSpacing.lg12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
              color: tokens.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokens =
        Theme.of(context).extension<LifelineColors>() ?? LifelineColors.light;

    return Scaffold(
      backgroundColor: tokens.bgPrimary,
      body: SafeArea(
        child: IndexedStack(
          index: _currentBottomTab,
          children: [
            _buildBerandaContent(tokens),
            MedicalIdScreen(
              data: _medicalData,
              tokens: tokens,
              onEditMedicalId: () async {
                final result = await showModalBottomSheet<MedicalData>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (ctx) => EditMedicalIdSheet(
                    tokens: tokens,
                    initialData: _medicalData,
                  ),
                );

                if (result != null) {
                  setState(() {
                    _medicalData = result;
                    UserStore().updateMedicalData(widget.userName, result);
                  });
                }
              },
            ),
            KontakScreen(
              tokens: tokens,
              userName: widget.userName,
            ),
            PanduanScreen(tokens: tokens),
            RiwayatScreen(tokens: tokens),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: tokens.bgPrimary,
          border:
              Border(top: BorderSide(color: tokens.borderPrimary, width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentBottomTab,
          onTap: (index) {
            setState(() {
              _currentBottomTab = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: tokens.bgPrimary,
          selectedItemColor: const Color(0xFFE53935),
          unselectedItemColor: const Color(0xFF717680),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w600, height: 1.4),
          unselectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w500, height: 1.4),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 3.0),
                child: Icon(Icons.home_rounded, size: 24),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 3.0),
                child: Icon(Icons.home_rounded, size: 24),
              ),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 3.0),
                child: Icon(Icons.add_rounded, size: 24),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 3.0),
                child: Icon(Icons.add_rounded, size: 24),
              ),
              label: 'Medical',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 3.0),
                child: Icon(Icons.people_outline_rounded, size: 24),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 3.0),
                child: Icon(Icons.people_rounded, size: 24),
              ),
              label: 'Kontak',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 3.0),
                child: Icon(Icons.menu_book_rounded, size: 24),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 3.0),
                child: Icon(Icons.menu_book_rounded, size: 24),
              ),
              label: 'Panduan',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 3.0),
                child: Icon(Icons.access_time_rounded, size: 24),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 3.0),
                child: Icon(Icons.access_time_filled_rounded, size: 24),
              ),
              label: 'Riwayat',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBerandaContent(LifelineColors tokens) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
          horizontal: LifelineSpacing.xl2, vertical: LifelineSpacing.lg12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(tokens),
          const SizedBox(height: LifelineSpacing.lg16),
          _buildEmergencyHeroCard(tokens),
          const SizedBox(height: LifelineSpacing.lg16),
          _buildStatusGrid(tokens),
          const SizedBox(height: LifelineSpacing.xl3),
          _buildQuickAccessSection(tokens),
          const SizedBox(height: LifelineSpacing.xl3),
          _buildNearbySection(tokens),
          const SizedBox(height: LifelineSpacing.xl3),
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

  Widget _buildHeader(LifelineColors tokens) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Halo, ${widget.userName}',
              style: TextStyle(
                fontSize: 13,
                color: tokens.textTertiary,
              ),
            ),
            const SizedBox(height: LifelineSpacing.xxs),
            Text(
              'Kamu terlindungi.',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: tokens.textDisplay,
                letterSpacing: -0.4,
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(
                widget.isDarkMode
                    ? Icons.wb_sunny_outlined
                    : Icons.nightlight_round_outlined,
                color: tokens.fgPrimary,
                size: 20,
              ),
              onPressed: widget.onToggleTheme,
              tooltip: widget.isDarkMode ? 'Light Mode' : 'Dark Mode',
            ),
            Container(
              decoration: BoxDecoration(
                color: tokens.bgSecondary,
                shape: BoxShape.circle,
                border: Border.all(color: tokens.borderPrimary, width: 1),
              ),
              child: IconButton(
                icon: Icon(Icons.logout_rounded,
                    color: tokens.fgPrimary, size: 20),
                onPressed: widget.onSignOut,
                tooltip: 'Keluar',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmergencyHeroCard(LifelineColors tokens) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: LifelineSpacing.xl2, vertical: LifelineSpacing.xl3),
      decoration: BoxDecoration(
        color: const Color(0xFF14171F),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Tombol Darurat',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withValues(alpha: 0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: LifelineSpacing.sm),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Satu tekanan.\n',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.15,
                      letterSpacing: -0.5,
                    ),
                  ),
                  TextSpan(
                    text: 'Bantuan datang.',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withValues(alpha: 0.7),
                      height: 1.15,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),
          GestureDetector(
            onLongPressStart: (_) {
              setState(() {
                _isSosPressed = true;
              });
            },
            onLongPressEnd: (_) {
              setState(() {
                _isSosPressed = false;
              });
              widget.onTriggerSos();
            },
            onTap: widget.onTriggerSos,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 175,
              height: 175,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const RadialGradient(
                  colors: [
                    Color(0xFFE53935),
                    Color(0xFFC62828),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE53935)
                        .withValues(alpha: _isSosPressed ? 0.8 : 0.4),
                    blurRadius: _isSosPressed ? 36 : 24,
                    spreadRadius: _isSosPressed ? 8 : 4,
                  ),
                ],
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.25),
                  width: 6,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'SOS',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(height: LifelineSpacing.xxs),
                    Text(
                      'TEKAN & TAHAN',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: Colors.white70,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: LifelineSpacing.xl3),
          Text(
            'Tekan & tahan 2 detik untuk mengaktifkan.\nPanggilan, lokasi, dan Medical ID akan dibagikan otomatis.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withValues(alpha: 0.55),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusGrid(LifelineColors tokens) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2.3,
      children: [
        _buildStatusChip(
          tokens: tokens,
          icon: Icons.check_circle_outline_rounded,
          iconColor: const Color(0xFF079455),
          subtitle: 'Medical ID',
          title: 'Lengkap',
          onTap: () {
            setState(() {
              _currentBottomTab = 1;
            });
          },
        ),
        _buildStatusChip(
          tokens: tokens,
          icon: Icons.people_outline_rounded,
          iconColor: const Color(0xFF2563EB),
          subtitle: 'Kontak Darurat',
          title: '4 aktif',
          onTap: () {
            setState(() {
              _currentBottomTab = 2;
            });
          },
        ),
        _buildStatusChip(
          tokens: tokens,
          icon: Icons.navigation_outlined,
          iconColor: const Color(0xFF2563EB),
          subtitle: 'Lokasi GPS',
          title: 'Akurat',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    const Text('Lokasi GPS saat ini terdeteksi dengan akurat.'),
                backgroundColor: tokens.bgSecondary,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
        _buildStatusChip(
          tokens: tokens,
          icon: Icons.shield_outlined,
          iconColor: const Color(0xFF079455),
          subtitle: 'Sistem',
          title: 'Siap',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                    'Semua sistem LifeLine siap dan berjalan normal.'),
                backgroundColor: tokens.bgSecondary,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildStatusChip({
    required LifelineColors tokens,
    required IconData icon,
    required Color iconColor,
    required String subtitle,
    required String title,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(LifelineRadius.xl2),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: LifelineSpacing.lg12, vertical: 10),
        decoration: BoxDecoration(
          color: tokens.bgSecondary,
          borderRadius: BorderRadius.circular(LifelineRadius.xl2),
          border: Border.all(
              color: tokens.borderPrimary.withValues(alpha: 0.6), width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 10,
                      color: tokens.textTertiary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: LifelineSpacing.xxs),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: tokens.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessSection(LifelineColors tokens) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Akses Cepat',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: tokens.textPrimary,
              ),
            ),
            GestureDetector(
              onTap: () => _showLayananTerdekatBottomSheet(context, tokens),
              child: const Text(
                'Lihat semua',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2563EB),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: LifelineSpacing.lg12),
        _buildQuickAccessCard(
          tokens: tokens,
          icon: Icons.phone_in_talk_outlined,
          iconColor: const Color(0xFFE53935),
          iconBg: const Color(0xFFFEF2F2),
          title: 'Panggil 112',
          subtitle: 'Nomor darurat nasional',
          onTap: () => _showPanggil112BottomSheet(context, tokens),
        ),
        const SizedBox(height: LifelineSpacing.md),
        _buildQuickAccessCard(
          tokens: tokens,
          icon: Icons.location_on_outlined,
          iconColor: tokens.textPrimary,
          iconBg: tokens.bgPrimary,
          title: 'Layanan Terdekat',
          subtitle: 'RS, klinik, apotek 24 jam',
          onTap: () => _showLayananTerdekatBottomSheet(context, tokens),
        ),
        const SizedBox(height: LifelineSpacing.md),
        _buildQuickAccessCard(
          tokens: tokens,
          icon: Icons.menu_book_outlined,
          iconColor: tokens.textPrimary,
          iconBg: tokens.bgPrimary,
          title: 'Panduan Pertolongan Pertama',
          subtitle: '8 kategori — tanpa perlu login',
          onTap: () {
            setState(() {
              _currentBottomTab = 3;
            });
          },
        ),
      ],
    );
  }

  Widget _buildQuickAccessCard({
    required LifelineColors tokens,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(LifelineRadius.xl2),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: tokens.bgSecondary,
          borderRadius: BorderRadius.circular(LifelineRadius.xl2),
          border: Border.all(
              color: tokens.borderPrimary.withValues(alpha: 0.5), width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
                border: Border.all(color: tokens.borderPrimary, width: 1),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: tokens.textPrimary,
                    ),
                  ),
                  const SizedBox(height: LifelineSpacing.xxs),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: tokens.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                color: tokens.textTertiary, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildNearbySection(LifelineColors tokens) {
    final facilities = [
      FacilityModel(
        id: 'siloam',
        name: 'RS Siloam Kebon Jeruk',
        category: 'RUMAH SAKIT',
        distance: '1.2 km',
        duration: '6 mnt',
        address: 'Jl. Raya Pejuangan No.8, Kebon Jeruk, Jakarta',
        hours: 'Buka 24 Jam',
        icon: Icons.local_hospital_outlined,
      ),
      FacilityModel(
        id: 'kimia_farma',
        name: 'Klinik Kimia Farma',
        category: 'KLINIK 24 JAM',
        distance: '0.8 km',
        duration: '4 mnt',
        address: 'Jl. Palmerah Barat No.42, Jakarta',
        hours: 'Buka 24 Jam',
        icon: Icons.medical_services_outlined,
      ),
      FacilityModel(
        id: 'k24',
        name: 'Apotek K-24',
        category: 'APOTEK',
        distance: '1.5 km',
        duration: '8 mnt',
        address: 'Jl. Palmerah Utara No.21, Jakarta',
        hours: 'Buka 24 Jam',
        icon: Icons.local_pharmacy_outlined,
      ),
      FacilityModel(
        id: 'puskesmas',
        name: 'Puskesmas Palmerah',
        category: 'PUSKESMAS',
        distance: '2.1 km',
        duration: '10 mnt',
        address: 'Jl. Palmerah III, Jakarta',
        hours: 'Tutup Pukul 15:00',
        icon: Icons.health_and_safety_outlined,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.none),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Di Sekitarmu',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: tokens.textPrimary,
                ),
              ),
              GestureDetector(
                onTap: () => _showLayananTerdekatBottomSheet(context, tokens),
                child: const Text(
                  'Peta',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2563EB),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: LifelineSpacing.lg12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          clipBehavior: Clip.none,
          child: Row(
            children: facilities.asMap().entries.map((entry) {
              final idx = entry.key;
              final facility = entry.value;
              return Padding(
                padding: EdgeInsets.only(
                    right: idx == facilities.length - 1 ? 0 : 12.0),
                child: SizedBox(
                  width: 160,
                  height: 160,
                  child: _buildNearbyCard(
                    tokens: tokens,
                    category: facility.category,
                    name: facility.name,
                    distance: facility.distance,
                    time: facility.duration,
                    icon: facility.icon,
                    onTap: () => _showFacilityDetailBottomSheet(
                        context, tokens, facility),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildNearbyCard({
    required LifelineColors tokens,
    required String category,
    required String name,
    required String distance,
    required String time,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: tokens.bgSecondary,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
              color: tokens.borderPrimary.withValues(alpha: 0.5), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Color(0xFFEFF6FF),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF2563EB), size: 16),
            ),
            const SizedBox(height: LifelineSpacing.lg12),
            Text(
              category,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: tokens.textTertiary,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              name,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: tokens.textPrimary,
                height: 1.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.navigation_outlined,
                    size: 12, color: tokens.textTertiary),
                const SizedBox(width: 3),
                Text(
                  distance,
                  style: TextStyle(fontSize: 11, color: tokens.textTertiary),
                ),
                const SizedBox(width: LifelineSpacing.md),
                Icon(Icons.access_time_rounded,
                    size: 12, color: tokens.textTertiary),
                const SizedBox(width: 3),
                Text(
                  time,
                  style: TextStyle(fontSize: 11, color: tokens.textTertiary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
