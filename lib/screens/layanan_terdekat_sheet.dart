import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class FacilityModel {
  final String id;
  final String name;
  final String category;
  final String distance;
  final String duration;
  final String address;
  final String hours;
  final IconData icon;

  FacilityModel({
    required this.id,
    required this.name,
    required this.category,
    required this.distance,
    required this.duration,
    required this.address,
    required this.hours,
    required this.icon,
  });
}

class LayananTerdekatSheet extends StatefulWidget {
  final LifelineColors tokens;

  const LayananTerdekatSheet({
    Key? key,
    required this.tokens,
  }) : super(key: key);

  @override
  State<LayananTerdekatSheet> createState() => _LayananTerdekatSheetState();
}

class _LayananTerdekatSheetState extends State<LayananTerdekatSheet> {
  late List<FacilityModel> _facilities;
  late FacilityModel _selectedFacility;

  @override
  void initState() {
    super.initState();
    _initFacilities();
  }

  void _initFacilities() {
    _facilities = [
      FacilityModel(
        id: 'siloam',
        name: 'RS Siloam Kebon Jeruk',
        category: 'Rumah Sakit',
        distance: '1.2 km',
        duration: '6 mnt',
        address: 'Jl. Raya Pejuangan No.8, Kebon Jeruk, Jakarta',
        hours: 'Buka 24 Jam',
        icon: Icons.local_hospital_outlined,
      ),
      FacilityModel(
        id: 'kimia_farma',
        name: 'Klinik Kimia Farma',
        category: 'Klinik 24 Jam',
        distance: '0.8 km',
        duration: '4 mnt',
        address: 'Jl. Palmerah Barat No.42, Jakarta',
        hours: 'Buka 24 Jam',
        icon: Icons.medical_services_outlined,
      ),
      FacilityModel(
        id: 'k24',
        name: 'Apotek K-24',
        category: 'Apotek 24 Jam',
        distance: '0.5 km',
        duration: '2 mnt',
        address: 'Jl. Kemanggisan Utama No.12, Jakarta',
        hours: 'Buka 24 Jam',
        icon: Icons.local_pharmacy_outlined,
      ),
      FacilityModel(
        id: 'cengkareng',
        name: 'RSUD Cengkareng',
        category: 'Rumah Sakit',
        distance: '3.4 km',
        duration: '11 mnt',
        address: 'Jl. Kamarung No.1, Cengkareng, Jakarta',
        hours: 'Buka 24 Jam',
        icon: Icons.local_hospital_outlined,
      ),
    ];
    _selectedFacility = _facilities[0];
  }

  void _selectFacility(FacilityModel facility) {
    setState(() {
      _selectedFacility = facility;
    });
  }

  Future<void> _openGoogleMapsDirections() async {
    final String urlString =
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(_selectedFacility.name)}';

    final Uri googleMapsUri = Uri.parse(urlString);

    try {
      if (await canLaunchUrl(googleMapsUri)) {
        await launchUrl(googleMapsUri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(googleMapsUri, mode: LaunchMode.platformDefault);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('🗺️ Mengalihkan ke Google Maps (${_selectedFacility.name})...'),
            backgroundColor: const Color(0xFFE53935),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = widget.tokens;

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
                    'Layanan Terdekat',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: tokens.textDisplay,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: LifelineSpacing.xxs),
                  Text(
                    'Berdasarkan lokasi kamu saat ini.',
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
          const SizedBox(height: LifelineSpacing.lg16),

          // Facilities List View
          SizedBox(
            height: 220,
            child: ListView.separated(
              itemCount: _facilities.length,
              separatorBuilder: (ctx, idx) => const SizedBox(height: LifelineSpacing.md),
              itemBuilder: (ctx, idx) {
                final facility = _facilities[idx];
                final bool isSelected = facility.id == _selectedFacility.id;

                return InkWell(
                  onTap: () => _selectFacility(facility),
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: LifelineSpacing.lg12),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF141721) : tokens.bgSecondary,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF141721) : tokens.borderPrimary,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white.withValues(alpha: 0.12) : const Color(0xFFEFF6FF),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            facility.icon,
                            color: isSelected ? Colors.white : const Color(0xFF2563EB),
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: LifelineSpacing.lg12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                facility.name,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected ? Colors.white : tokens.textPrimary,
                                ),
                              ),
                              const SizedBox(height: LifelineSpacing.xxs),
                              Text(
                                '${facility.category} · ${facility.distance} · ${facility.duration}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected ? Colors.white.withValues(alpha: 0.65) : tokens.textTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: isSelected ? Colors.white70 : tokens.textTertiary,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: LifelineSpacing.lg16),

          // EMPTY FRAME FOR MAPS (Figma exact empty container frame)
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: tokens.bgQuaternary.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: tokens.borderPrimary, width: 1),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.map_outlined,
                      size: 32,
                      color: tokens.textTertiary.withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: LifelineSpacing.sm),
                    Text(
                      'Frame Peta (Kosong)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: tokens.textTertiary.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: LifelineSpacing.lg16),

          // Bottom Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _openGoogleMapsDirections,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE53935),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(LifelineRadius.xl2),
                    ),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.navigation_rounded, size: 18),
                  label: const Text(
                    'Rute',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: LifelineSpacing.lg12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(_selectedFacility.name),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Kategori: ${_selectedFacility.category}'),
                            const SizedBox(height: LifelineSpacing.sm),
                            Text('Jarak: ${_selectedFacility.distance} (${_selectedFacility.duration})'),
                            const SizedBox(height: LifelineSpacing.sm),
                            Text('Jam Operasional: ${_selectedFacility.hours}'),
                            const SizedBox(height: LifelineSpacing.sm),
                            Text('Alamat: ${_selectedFacility.address}'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('Tutup'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: tokens.bgPrimary,
                    foregroundColor: tokens.textPrimary,
                    minimumSize: const Size(double.infinity, 50),
                    side: BorderSide(color: tokens.borderSecondary, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(LifelineRadius.xl2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Detail',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: LifelineSpacing.xs),
                      Icon(Icons.chevron_right_rounded, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: LifelineSpacing.md),
        ],
      ),
    );
  }
}
