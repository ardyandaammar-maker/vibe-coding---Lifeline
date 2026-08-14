import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'panduan_detail_sheet.dart';

class FirstAidCategory {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String callForHelpText;
  final List<String> steps;
  final List<String> warnings;
  final String note;

  FirstAidCategory({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.callForHelpText,
    required this.steps,
    required this.warnings,
    required this.note,
  });
}

class PanduanScreen extends StatefulWidget {
  final LifelineColors tokens;

  const PanduanScreen({
    Key? key,
    required this.tokens,
  }) : super(key: key);

  @override
  State<PanduanScreen> createState() => _PanduanScreenState();
}

class _PanduanScreenState extends State<PanduanScreen> {
  String _searchQuery = '';

  List<FirstAidCategory> get _categories => [
        FirstAidCategory(
          title: 'CPR / RJP',
          description: 'Kompresi dada dewasa',
          icon: Icons.favorite_border_rounded,
          iconColor: const Color(0xFFE53935),
          iconBg: const Color(0xFFFEF2F2),
          callForHelpText: 'Korban tidak merespons, tidak bernapas, atau hanya terengah-engah.',
          steps: [
            'Pastikan area aman dan panggil bantuan / aktifkan SOS.',
            'Letakkan telapak tangan satu di tengah dada, tangan lain di atasnya.',
            'Kompresi dengan kedalaman 5-6 cm pada kecepatan 100-120 kali per menit.',
            'Setelah 30 kompresi, beri 2 napas bantuan jika terlatih.',
            'Lanjutkan siklus 30:2 hingga petugas medis tiba atau AED tersedia.',
          ],
          warnings: [
            'Hentikan jika korban mulai bernapas normal atau merespons.',
            'Jika lelah, minta orang lain bergantian setiap 2 menit.',
          ],
          note: 'Resusitasi jantung paru (RJP) mempertahankan aliran darah ke otak dan organ vital.',
        ),
        FirstAidCategory(
          title: 'Tersedak',
          description: 'Manover Heimlich',
          icon: Icons.warning_amber_rounded,
          iconColor: const Color(0xFF2563EB),
          iconBg: const Color(0xFFEFF6FF),
          callForHelpText: 'Korban tidak bisa batuk, bicara, atau bernapas dan wajah mulai membiru.',
          steps: [
            'Berdiri di belakang korban dan peluk pinggangnya.',
            'Kepalkan satu tangan dan letakkan tepat di atas pusar korban.',
            'Genggam kepalan dengan tangan satunya.',
            'Lakukan hentakan kuat ke dalam dan ke atas (J-stroke).',
            'Ulangi hentakan hingga benda asing keluar atau korban tidak sadar.',
          ],
          warnings: [
            'Jangan lakukan sapuan jari buta di dalam mulut korban.',
            'Lakukan CPR segera jika korban kehilangan kesadaran.',
          ],
          note: 'Manuver Heimlich (abdominal thrusts) mendorong udara keluar dari paru-paru untuk melepaskan sumbatan.',
        ),
        FirstAidCategory(
          title: 'Pendarahan',
          description: 'Menghentikan darah',
          icon: Icons.water_drop_outlined,
          iconColor: const Color(0xFFE53935),
          iconBg: const Color(0xFFFEF2F2),
          callForHelpText: 'Pendarahan mengucur deras, darah memompa, atau tidak berhenti setelah ditekan 10 menit.',
          steps: [
            'Cuci tangan atau gunakan sarung tangan medis jika tersedia.',
            'Tekan kuat pada luka dengan kain bersih atau kasa.',
            'Angkat area tubuh yang terluka lebih tinggi dari jantung jika memungkinkan.',
            'Balut luka dengan kuat, jangan lepas kasa jika darah menembus, tambahkan kasa baru di atasnya.',
            'Gunakan torniket HANYA jika darah mengancam nyawa dan tidak berhenti ditekan.',
          ],
          warnings: [
            'Jangan cabut benda yang tertancap pada luka.',
            'Catat waktu jika menggunakan torniket dan segera hubungi medis.',
          ],
          note: 'Tekanan langsung adalah cara paling efektif untuk menghentikan sebagian besar pendarahan luar.',
        ),
        FirstAidCategory(
          title: 'Luka Bakar',
          description: 'Derajat 1, 2, 3',
          icon: Icons.warning_amber_rounded,
          iconColor: const Color(0xFFD97706),
          iconBg: const Color(0xFFFFFBEB),
          callForHelpText: 'Luka bakar luas, pada wajah/saluran napas, disebabkan listrik atau bahan kimia.',
          steps: [
            'Jauhkan korban dari sumber panas.',
            'Aliri area yang terbakar dengan air bersih mengalir bersuhu ruangan selama 10-20 menit.',
            'Lepaskan pakaian atau perhiasan yang ketat di area luka SEBELUM membengkak.',
            'Tutup luka bakar secara longgar dengan kasa steril atau kain bersih (tidak berbulu).',
          ],
          warnings: [
            'JANGAN gunakan es atau air es batu, karena bisa merusak jaringan.',
            'JANGAN pecahkan lepuhan luka.',
            'JANGAN oleskan odol, mentega, atau salep.',
          ],
          note: 'Pendinginan segera sangat penting untuk menghentikan proses pembakaran berlanjut di bawah kulit.',
        ),
        FirstAidCategory(
          title: 'Patah Tulang',
          description: 'Imobilisasi',
          icon: Icons.monitor_heart_outlined,
          iconColor: const Color(0xFF4B5563),
          iconBg: const Color(0xFFF3F4F6),
          callForHelpText: 'Tulang menonjol keluar dari kulit (patah tulang terbuka), pendarahan hebat, atau di leher/punggung.',
          steps: [
            'Jangan coba meluruskan atau mengembalikan tulang ke posisinya.',
            'Hentikan pendarahan (jika ada) dengan tekanan lembut menggunakan kain bersih.',
            'Imobilisasi (batasi gerakan) area yang cedera, buat bidai dari papan/majalah gulung.',
            'Kompres dengan es (dibungkus kain) selama 20 menit untuk mengurangi bengkak.',
            'Tinggikan area jika memungkinkan dan aman untuk dilakukan.',
          ],
          warnings: [
            'JANGAN pindahkan korban jika dicurigai ada cedera tulang belakang.',
            'Jangan beri makan atau minum pada korban untuk jaga-jaga bila butuh operasi.',
          ],
          note: 'Menstabilkan tulang akan mengurangi rasa sakit secara signifikan dan mencegah kerusakan lebih lanjut.',
        ),
        FirstAidCategory(
          title: 'Serangan Jantung',
          description: 'Tanda & tindakan',
          icon: Icons.favorite_border_rounded,
          iconColor: const Color(0xFFE53935),
          iconBg: const Color(0xFFFEF2F2),
          callForHelpText: 'Nyeri dada tertekan hebat, menjalar ke lengan, rahang, keringat dingin, dan sesak napas.',
          steps: [
            'Segera hubungi ambulans / aktifkan SOS, jangan biarkan korban menyetir sendiri.',
            'Bantu korban duduk, beristirahat santai, longgarkan pakaian yang ketat.',
            'Tanyakan apakah korban memiliki obat jantung (seperti Nitrogliserin) dan bantu meminumnya.',
            'Jika korban disarankan dokter, berikan Aspirin dewasa (300mg) untuk dikunyah.',
            'Siapkan diri untuk melakukan CPR jika korban tiba-tiba pingsan dan henti napas.',
          ],
          warnings: [
            'Jangan berikan Aspirin jika korban alergi, pendarahan aktif, atau di bawah umur.',
            'Jangan berikan apa pun lewat mulut jika korban tidak sepenuhnya sadar.',
          ],
          note: 'Waktu adalah otot jantung. Intervensi medis secepat mungkin adalah kunci keselamatan.',
        ),
        FirstAidCategory(
          title: 'Stroke',
          description: 'Metode FAST',
          icon: Icons.monitor_heart_outlined,
          iconColor: const Color(0xFF2563EB),
          iconBg: const Color(0xFFEFF6FF),
          callForHelpText: 'Salah satu sisi wajah turun, lengan lemah, atau bicara pelo secara tiba-tiba.',
          steps: [
            'Gunakan metode FAST: F (Face - Minta senyum), A (Arms - Minta angkat kedua lengan).',
            'S (Speech - Minta ulangi kalimat sederhana, perhatikan pelafalan), T (Time - Panggil ambulans).',
            'Hubungi medis SEGERA, catat jam tepat saat gejala pertama kali muncul.',
            'Baringkan korban dengan nyaman dan tetap temani hingga bantuan datang.',
          ],
          warnings: [
            'JANGAN memberikan aspirin atau obat penipis darah lainnya.',
            'Jangan memberikan makanan atau minuman karena stroke sering mengganggu kemampuan menelan.',
          ],
          note: 'Sama seperti jantung, pengobatan stroke kritis bergantung pada kecepatan penanganan dalam Golden Hour (biasanya <4 jam).',
        ),
        FirstAidCategory(
          title: 'Reaksi Alergi',
          description: 'Anafilaksis',
          icon: Icons.medication_outlined,
          iconColor: const Color(0xFFD97706),
          iconBg: const Color(0xFFFFFBEB),
          callForHelpText: 'Bengkak pada tenggorokan/lidah, sesak napas berat, ruam gatal seluruh tubuh, denyut nadi lemah.',
          steps: [
            'Hubungi layanan darurat atau aktifkan SOS segera.',
            'Tanyakan apakah korban memiliki EpiPen (Epinefrin Auto-Injector) dan bantu mereka menggunakannya.',
            'Suntikkan EpiPen pada paha bagian luar (bisa tembus pakaian) dan tahan selama 10 detik.',
            'Baringkan korban datar dengan kaki sedikit terangkat. Jika muntah, miringkan.',
            'Longgarkan pakaian dan tetap awasi pernapasan hingga petugas medis datang.',
          ],
          warnings: [
            'Jangan gunakan inhaler asma sebagai pengganti EpiPen pada kasus reaksi anafilaksis.',
            'Jika gejala tidak membaik setelah 5-15 menit, dosis EpiPen kedua mungkin diperlukan jika disarankan.',
          ],
          note: 'Anafilaksis adalah reaksi alergi parah dan berpotensi fatal yang terjadi dengan sangat cepat.',
        ),
      ];

  void _openGuideDetail(BuildContext context, FirstAidCategory cat) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => FractionallySizedBox(
        heightFactor: 0.9,
        child: PanduanDetailSheet(
          tokens: widget.tokens,
          guide: cat,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredCategories = _categories.where((c) {
      final query = _searchQuery.toLowerCase();
      return c.title.toLowerCase().contains(query) || c.description.toLowerCase().contains(query);
    }).toList();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.xl2, vertical: LifelineSpacing.lg12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Tag
          const Text(
            'Panduan',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2563EB),
            ),
          ),
          const SizedBox(height: LifelineSpacing.xs),

          // Title
          Text(
            'Pertolongan pertama,\ndijelaskan sederhana.',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: widget.tokens.textDisplay,
              letterSpacing: -0.5,
              height: 1.15,
            ),
          ),
          const SizedBox(height: LifelineSpacing.lg16),

          // Search Field
          TextField(
            onChanged: (val) {
              setState(() {
                _searchQuery = val;
              });
            },
            style: TextStyle(fontSize: 14, color: widget.tokens.textPrimary),
            decoration: InputDecoration(
              hintText: 'Cari panduan...',
              hintStyle: TextStyle(color: widget.tokens.textTertiary),
              prefixIcon: Icon(Icons.search_rounded, color: widget.tokens.textTertiary, size: 20),
              filled: true,
              fillColor: widget.tokens.bgSecondary,
              contentPadding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.lg16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(LifelineRadius.xl2),
                borderSide: BorderSide(color: widget.tokens.borderPrimary.withValues(alpha: 0.6)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(LifelineRadius.xl2),
                borderSide: BorderSide(color: widget.tokens.borderPrimary.withValues(alpha: 0.6)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(LifelineRadius.xl2),
                borderSide: const BorderSide(color: Color(0xFF2563EB)),
              ),
            ),
          ),
          const SizedBox(height: LifelineSpacing.xl2),

          // 2x4 Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredCategories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.25,
            ),
            itemBuilder: (ctx, idx) {
              final cat = filteredCategories[idx];
              return InkWell(
                onTap: () => _openGuideDetail(context, cat),
                borderRadius: BorderRadius.circular(LifelineRadius.xl3),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: widget.tokens.bgSecondary,
                    borderRadius: BorderRadius.circular(LifelineRadius.xl3),
                    border: Border.all(color: widget.tokens.borderPrimary.withValues(alpha: 0.6), width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: cat.iconBg,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(cat.icon, color: cat.iconColor, size: 18),
                      ),
                      const Spacer(),
                      Text(
                        cat.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: widget.tokens.textPrimary,
                        ),
                      ),
                      const SizedBox(height: LifelineSpacing.xxs),
                      Text(
                        cat.description,
                        style: TextStyle(
                          fontSize: 10,
                          color: widget.tokens.textTertiary,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 28),

          // Footer Note
          Center(
            child: Text(
              'Lifeline • Setiap detik penting',
              style: TextStyle(
                fontSize: 11,
                color: widget.tokens.textTertiary.withValues(alpha: 0.7),
              ),
            ),
          ),
          const SizedBox(height: LifelineSpacing.xl2),
        ],
      ),
    );
  }
}
