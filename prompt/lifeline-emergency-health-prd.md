# Lifeline – Emergency Health Assistance
## Product Requirements Document (PRD)

**Versi:** 1.0
**Tanggal:** 21 Juli 2026
**Status:** Draft untuk Development
**Platform:** iOS & Android (Mobile Native / Cross-Platform)

---

## 1. Executive Summary

Lifeline adalah aplikasi mobile emergency health assistance yang memungkinkan pengguna meminta bantuan medis darurat hanya dalam hitungan detik melalui satu tombol SOS. Aplikasi ini secara otomatis membagikan lokasi GPS real-time, Medical ID pengguna, dan notifikasi kepada kontak darurat serta layanan darurat terkait, sekaligus menyediakan panduan pertolongan pertama saat menunggu bantuan tiba.

Target pasar utama adalah Indonesia, dengan model bisnis freemium (fitur inti gratis, fitur lanjutan seperti integrasi wearable dan pemantauan keluarga berbayar sebagai Lifeline Premium). Pendapatan jangka menengah-panjang juga direncanakan melalui kemitraan B2B2C dengan rumah sakit, perusahaan asuransi, dan penyedia layanan ambulans.

Dokumen ini adalah single source of truth untuk tim produk, desain, engineering, QA, dan AI coding tools dalam membangun MVP dan roadmap lanjutannya.

---

## 2. Assumptions

Karena brief awal belum mencakup seluruh detail teknis dan bisnis, asumsi berikut dibuat secara eksplisit agar pengembangan dapat berjalan tanpa blocking:

| # | Area | Asumsi |
|---|------|--------|
| 1 | Pasar awal | Peluncuran pertama fokus di Indonesia (Jabodetabek terlebih dahulu), Bahasa Indonesia sebagai bahasa utama, Bahasa Inggris sebagai bahasa kedua. |
| 2 | Layanan darurat | Belum ada integrasi resmi/API langsung dengan nomor darurat nasional (112) atau ambulans pemerintah di fase MVP, sehingga SOS akan melakukan **auto-dial** ke nomor darurat (112) via native phone call API, bukan integrasi data digital ke command center. Integrasi digital penuh menjadi Phase 2 (butuh kemitraan resmi). |
| 3 | Ambulans/ETA | "ETA ambulans" pada MVP bersifat estimasi berbasis mitra pihak ketiga (partner ambulans swasta terverifikasi) yang sudah terintegrasi API; tanpa mitra, status akan menampilkan "Ambulans belum tersedia di area ini". |
| 4 | Autentikasi | Registrasi menggunakan nomor HP + OTP (SMS/WhatsApp) sebagai metode utama karena lebih familiar untuk skenario darurat dibanding email. Email dan login sosial (Google/Apple) sebagai opsi sekunder. |
| 5 | Model data medis | Data medis disimpan terenkripsi dan tunduk pada regulasi perlindungan data pribadi (UU PDP Indonesia) serta prinsip mirip HIPAA/GDPR untuk kesiapan ekspansi internasional. |
| 6 | Monetisasi | Freemium: fitur SOS, Medical ID, kontak darurat, live tracking dasar, first aid guide = gratis selamanya (safety-critical tidak boleh dikunci paywall). Premium: deteksi jatuh via wearable, deteksi kecelakaan kendaraan, riwayat kesehatan lengkap, penyimpanan dokumen medis, family location sharing berkala, pengingat obat. |
| 7 | Device support | Wearable integration (Phase 2) mengasumsikan Apple Watch & Wear OS sebagai target utama. |
| 8 | Offline capability | Saat SOS ditekan tanpa koneksi internet, aplikasi tetap dapat melakukan panggilan telepon native (tidak butuh internet) dan mengirim SMS darurat berisi koordinat GPS sebagai fallback. |
| 9 | Tim engineering | Tim menggunakan arsitektur cross-platform (React Native/Flutter) dengan backend cloud (asumsi: Node.js/NestJS + PostgreSQL + Redis + WebSocket untuk real-time tracking) agar dapat dibangun oleh AI coding tools maupun tim manusia. |
| 10 | Kepatuhan hukum | Aplikasi bukan pengganti layanan medis resmi; seluruh fitur AI diposisikan sebagai *decision support*, bukan diagnosis, dan disclaimer hukum wajib ditampilkan di onboarding. |
| 11 | Skala awal | Target 100.000 unduhan dalam 6 bulan pertama, dengan infra yang dirancang mampu menangani hingga 1 juta pengguna terdaftar dan 10.000 sesi SOS concurrent. |
| 12 | Model bisnis kemitraan | Kemitraan rumah sakit/asuransi/ambulans akan menggunakan model komisi dan/atau biaya integrasi API tahunan, dinegosiasikan di luar cakupan teknis dokumen ini. |

---

## 3. Product Vision

Menjadi aplikasi pendamping darurat kesehatan nomor satu di Indonesia yang memungkinkan siapa pun—dalam kondisi panik atau tidak sadar sekalipun—memperoleh bantuan medis lebih cepat, melalui pengalaman yang sesederhana mungkin: satu tekanan tombol menghubungkan pengguna dengan keluarga, informasi medis, dan bantuan darurat sekaligus.

**North Star Statement:** *"Setiap detik penting. Lifeline memastikan tidak ada satu detik pun terbuang saat nyawa dipertaruhkan."*

---

## 4. Problem Statement

Saat kondisi darurat medis terjadi (kecelakaan, serangan jantung, stroke, dsb.), korban atau orang di sekitarnya menghadapi beberapa hambatan kritis:

1. **Kompleksitas proses meminta bantuan** — harus membuka beberapa aplikasi berbeda (telepon, maps, chat) dalam kondisi panik.
2. **Kesulitan menjelaskan lokasi** — terutama di area tanpa alamat jelas (jalan tol, gang, area rural).
3. **Tidak sempat menghubungi keluarga** — prioritas waktu terbagi antara memanggil bantuan medis dan memberi tahu keluarga.
4. **Informasi medis tidak tersedia untuk petugas** — golongan darah, alergi obat, riwayat penyakit tidak diketahui responder pertama.
5. **Keluarga tidak memiliki visibilitas** — tidak tahu kondisi maupun lokasi anggota keluarga saat kejadian.
6. **Waktu respons yang lama** — akumulasi dari poin 1–5 menyebabkan keterlambatan penanganan yang dalam kasus medis (mis. serangan jantung, stroke) sangat memengaruhi peluang keselamatan ("golden hour").

**Dampak bisnis dari masalah ini:** tidak ada satu platform terpadu di Indonesia yang menyatukan SOS + data medis + notifikasi keluarga + panduan pertolongan pertama dalam satu alur yang dapat diakses dalam <5 detik.

---

## 5. Goals & KPIs

### Goals Produk
- Mengurangi waktu dari "kejadian darurat" ke "bantuan pertama dihubungi" menjadi di bawah 10 detik.
- Menyediakan akses informasi medis penting kepada penolong dalam <3 tap/detik pertama SOS aktif.
- Mencapai tingkat keandalan (uptime) sistem SOS sebesar 99.95%.

### Goals Bisnis
- 100.000 unduhan & 40.000 akun Medical ID lengkap dalam 6 bulan pertama.
- Kemitraan resmi dengan minimal 3 jaringan rumah sakit besar dan 2 provider ambulans swasta dalam tahun pertama.
- Konversi ke Premium sebesar 5% dari MAU dalam 12 bulan.

### KPI Terukur

| KPI | Target MVP (Bulan 1-3) | Target 6 Bulan | Target 12 Bulan |
|---|---|---|---|
| Total unduhan | 20.000 | 100.000 | 300.000 |
| Medical ID completion rate | 60% | 70% | 80% |
| SOS activation success rate (berhasil terkirim) | 99% | 99.5% | 99.9% |
| Rata-rata waktu SOS → kontak darurat notified | < 5 detik | < 3 detik | < 2 detik |
| Crash-free session rate | 99% | 99.5% | 99.8% |
| Retensi 30 hari | 25% | 35% | 45% |
| Konversi Premium | - | 2% | 5% |
| Jumlah mitra RS/ambulans | 0 | 3 | 8 |
| NPS | - | 40+ | 55+ |

---

## 6. Stakeholders

| Peran | Tanggung Jawab |
|---|---|
| CEO / Founder | Visi produk, kemitraan strategis (RS, asuransi, ambulans), fundraising |
| Head of Product | Roadmap, prioritisasi fitur, KPI |
| UX Researcher | Riset pengguna, usability testing (khususnya skenario stres/panik) |
| Product Designer | Desain UI/UX, design system, aksesibilitas |
| Engineering Lead / Tech Lead | Arsitektur sistem, keputusan teknis |
| Backend Engineers | API, database, integrasi pihak ketiga (emergency services, ambulans, maps) |
| Mobile Engineers (iOS/Android) | Implementasi aplikasi native/cross-platform |
| QA Lead | Test plan, khususnya reliability testing untuk fitur safety-critical |
| Security Engineer | Keamanan data medis, kepatuhan UU PDP |
| Data Analyst | Analytics, dashboard KPI, growth insight |
| Growth PM | Akuisisi pengguna, onboarding funnel, retention |
| Partnership Manager | Kemitraan RS, asuransi, ambulans |
| Legal/Compliance | Disclaimer medis, kepatuhan regulasi kesehatan & data pribadi |
| Customer Support | Penanganan keluhan, terutama insiden yang berkaitan dengan kegagalan SOS |

---

## 7. Target Users

### Primary Segment: Individu Aktif Berkendara/Bekerja Sendiri
Usia 20–35 tahun, mobile-first, sering bepergian sendiri (motor/mobil), tinggal jauh dari keluarga, membutuhkan jaring pengaman darurat yang instan.

### Secondary Segment: Lansia & Penderita Penyakit Kronis
Usia 55+ tahun, memiliki kondisi kronis (hipertensi, diabetes, jantung), membutuhkan interface yang sangat sederhana dan dapat diakses dengan mudah, sering ditemani/diawasi anggota keluarga.

### Tertiary Segment: Orang Tua / Anggota Keluarga (sebagai Emergency Contact)
Tidak selalu menginstal Medical Profile lengkap, tapi menerima notifikasi darurat dan memantau lokasi anggota keluarga — perlu app experience yang ringan (bisa via notifikasi/link tanpa install penuh jika diperlukan).

---

## 8. Personas

### Persona 1 — Rizky (Primary)
- **Usia:** 24 tahun, karyawan swasta di Jakarta
- **Situasi:** Tinggal sendiri (kost), commuting dengan motor setiap hari, sering pulang malam.
- **Pain Points:** Takut kecelakaan saat perjalanan sendirian; sulit meminta bantuan cepat; orang tua di kampung halaman tidak tahu kondisinya.
- **Goals:** Bisa memicu bantuan dalam hitungan detik dengan satu tangan; orang tua otomatis mendapat notifikasi lokasi & kondisi.
- **Tech Savviness:** Tinggi. Terbiasa dengan aplikasi ride-hailing, e-wallet, dan wearable fitness.
- **Quote:** *"Kalau saya jatuh dari motor sendirian, saya nggak akan sempat buka aplikasi peta dan telepon satu-satu."*

### Persona 2 — Dewi (Secondary)
- **Usia:** 63 tahun, ibu rumah tangga, memiliki hipertensi
- **Situasi:** Tinggal bersama suami, jarang bepergian jauh, anak-anak tinggal di kota lain.
- **Pain Points:** Kesulitan menggunakan aplikasi yang rumit/banyak menu; khawatir mengalami serangan mendadak tanpa ada yang tahu.
- **Goals:** Tombol SOS besar dan jelas; informasi kesehatannya bisa langsung diakses petugas medis tanpa dia harus menjelaskan.
- **Tech Savviness:** Rendah–menengah. Familiar dengan WhatsApp dan video call, kurang familiar dengan aplikasi kompleks.
- **Quote:** *"Saya cuma butuh satu tombol besar yang saya tahu pasti berfungsi."*

### Persona 3 — Bapak Hendra (Tertiary — Emergency Contact)
- **Usia:** 55 tahun, ayah dari Rizky
- **Situasi:** Tinggal di luar kota, menerima notifikasi darurat sebagai kontak utama anak.
- **Pain Points:** Tidak mau install banyak aplikasi rumit; butuh info cepat dan actionable saat mendapat notifikasi darurat.
- **Goals:** Menerima notifikasi jelas berisi lokasi, status, dan tombol call langsung ke pihak terkait.

---

## 9. Jobs To Be Done

| Situasi (When) | Motivasi (I want to) | Hasil (So I can) |
|---|---|---|
| Saat mengalami kecelakaan sendirian | Memicu bantuan darurat secepat mungkin dengan minimal interaksi | Mendapat pertolongan sebelum kondisi memburuk |
| Saat merasa gejala serangan jantung/stroke | Memberi tahu lokasi dan kondisi medis saya ke petugas | Petugas dapat menangani dengan tepat tanpa saya harus menjelaskan |
| Saat mengaktifkan SOS | Memberi tahu keluarga secara otomatis | Keluarga tidak panik mencari-cari saya dan bisa segera bertindak |
| Sebagai orang tua/kontak darurat | Melihat lokasi & status anak secara real-time saat SOS aktif | Saya bisa mengambil keputusan (datang langsung/hubungi RS terdekat) |
| Sebagai pengguna dengan kondisi kronis | Menyimpan data medis lengkap di satu tempat aman | Data ini bisa diakses cepat oleh siapa pun yang menolong saya |
| Saat tidak dalam kondisi darurat | Mempelajari pertolongan pertama dasar | Saya siap membantu orang lain atau diri sendiri saat situasi darurat terjadi |

---

## 10. Competitive Analysis

| Aplikasi | Fokus | Kelebihan | Kekurangan (Gap yang Lifeline isi) |
|---|---|---|---|
| Aplikasi SOS generik (mis. bSafe, Noonlight) | Keamanan pribadi (personal safety, umumnya untuk kejahatan/predator) | SOS cepat, share lokasi | Tidak fokus pada data medis maupun panduan first aid |
| Aplikasi Medical ID bawaan OS (Apple Health Medical ID, Google Emergency Info) | Menyimpan info medis dasar di lock screen | Terintegrasi OS, tanpa install app tambahan | Tidak ada SOS aktif, tidak ada notifikasi keluarga otomatis, tidak ada live tracking |
| Aplikasi ambulans on-demand lokal | Memanggil ambulans | Terhubung langsung ke armada | Tidak ada Medical ID terintegrasi, tidak ada notifikasi keluarga, tidak ada first aid guide |
| Aplikasi kesehatan umum (Halodoc, Alodokter) | Konsultasi dokter, booking RS | Basis pengguna besar, kepercayaan brand kesehatan | Bukan aplikasi darurat real-time; alur konsultasi terlalu lambat untuk kondisi darurat |

**Positioning Lifeline:** Satu-satunya aplikasi di Indonesia yang menyatukan SOS instan + Medical ID + notifikasi keluarga otomatis + live tracking + panduan pertolongan pertama dalam satu alur <10 detik, dengan desain accessibility-first untuk kondisi panik maupun pengguna lansia.

---

## 11. Product Strategy

1. **Safety-first, monetization-second:** Semua fitur yang berkaitan langsung dengan keselamatan (SOS, Medical ID, kontak darurat, first aid guide, live tracking dasar) selalu gratis. Monetisasi hanya pada fitur kenyamanan/lanjutan.
2. **Trust melalui kemitraan institusional:** Kredibilitas dibangun melalui kemitraan resmi rumah sakit dan asuransi, bukan hanya klaim marketing.
3. **Accessibility-first design:** Karena target termasuk lansia dan kondisi panik, semua interaksi kritikal dirancang dapat diselesaikan dengan satu tangan, maksimal 3 langkah.
4. **Network effect keluarga:** Setiap pengguna yang menambahkan kontak darurat berpotensi mengonversi anggota keluarga tersebut menjadi pengguna baru (viral loop melalui notifikasi).
5. **Data sebagai keunggulan jangka panjang:** Riwayat medis dan histori darurat yang terkumpul (dengan consent) menjadi dasar fitur AI prediktif dan nilai jual kemitraan asuransi di fase lanjut.

---

## 12. Scope (MVP / Phase 2 / Future)

### MVP (Phase 1) — Target: 3–4 bulan development
- Onboarding & Registrasi (OTP)
- Medical Profile (lengkap)
- Emergency Contacts (maks. 5)
- Smart SOS (tekan-tahan, countdown, auto-call, share GPS, share Medical ID, notify family)
- Live Tracking dasar (lokasi real-time selama SOS aktif)
- Nearby Emergency Services (RS, klinik, apotek 24 jam, polisi, damkar) via Maps API
- First Aid Guide (8 kategori dasar)
- Emergency Timeline & History
- Notifikasi push dasar
- Dark mode & aksesibilitas dasar

### Phase 2 — Target: bulan 5–9
- Integrasi resmi API dengan mitra ambulans (ETA real)
- AI Symptom Urgency Checker (penilaian tingkat urgensi berdasarkan gejala)
- AI First Aid Assistant (instruksi interaktif real-time saat menunggu bantuan)
- Family location sharing berkala (bukan hanya saat SOS)
- Pengingat obat
- Integrasi wearable (Apple Watch/Wear OS) untuk fall detection dasar
- Lifeline Premium (paket berbayar)

### Future (Phase 3+)
- Deteksi kecelakaan kendaraan otomatis (crash detection via sensor)
- AI ringkasan kondisi pengguna otomatis untuk dibagikan ke petugas medis
- Integrasi command center 112 nasional (jika kemitraan pemerintah terbentuk)
- Penyimpanan dokumen medis lengkap (rekam medis, hasil lab, resep)
- Ekspansi regional (Asia Tenggara)
- Program asuransi terintegrasi (cashless emergency treatment)

---

## 13. Functional Requirements

| ID | Requirement | Prioritas |
|---|---|---|
| FR-01 | Pengguna dapat mendaftar menggunakan nomor HP + OTP | MVP |
| FR-02 | Pengguna dapat login menggunakan Google/Apple Sign-In | MVP |
| FR-03 | Pengguna dapat mengisi dan mengedit Medical Profile lengkap | MVP |
| FR-04 | Pengguna dapat menambahkan hingga 5 kontak darurat dengan relasi (Ayah, Ibu, dsb.) | MVP |
| FR-05 | Pengguna dapat mengaktifkan SOS melalui tekan-tahan tombol 2 detik + countdown 3 detik yang dapat dibatalkan | MVP |
| FR-06 | Sistem otomatis melakukan panggilan ke nomor darurat saat SOS tidak dibatalkan | MVP |
| FR-07 | Sistem otomatis membagikan lokasi GPS real-time ke kontak darurat saat SOS aktif | MVP |
| FR-08 | Sistem otomatis mengirim ringkasan Medical ID ke kontak darurat via link aman saat SOS aktif | MVP |
| FR-09 | Pengguna dapat melihat daftar layanan darurat terdekat (RS, klinik, apotek, polisi, damkar) berbasis lokasi | MVP |
| FR-10 | Pengguna dapat mengakses panduan pertolongan pertama tanpa harus login | MVP |
| FR-11 | Sistem mencatat timeline setiap kejadian SOS (aktivasi, lokasi terkirim, keluarga diberi tahu, dsb.) | MVP |
| FR-12 | Pengguna dapat melihat riwayat kejadian darurat sebelumnya | MVP |
| FR-13 | Sistem dapat mengirim SMS fallback berisi lokasi jika tidak ada koneksi internet saat SOS aktif | MVP |
| FR-14 | Pengguna dapat mengaktifkan/menonaktifkan dark mode | MVP |
| FR-15 | Sistem menyediakan estimasi ETA ambulans jika mitra ambulans tersedia di area tersebut | Phase 2 |
| FR-16 | AI dapat menilai tingkat urgensi berdasarkan gejala yang dimasukkan pengguna | Phase 2 |
| FR-17 | AI dapat memberikan instruksi pertolongan pertama kontekstual secara real-time | Phase 2 |
| FR-18 | Pengguna Premium dapat menghubungkan smartwatch untuk deteksi jatuh otomatis | Phase 2 |
| FR-19 | Pengguna dapat mengatur pengingat obat rutin | Phase 2 |
| FR-20 | Sistem dapat mendeteksi potensi kecelakaan kendaraan melalui sensor perangkat (Premium) | Phase 3 |

---

## 14. Non-Functional Requirements

| Kategori | Requirement |
|---|---|
| **Performance** | Waktu dari tekan SOS hingga panggilan darurat terhubung: < 3 detik. Waktu update lokasi live tracking: setiap 3–5 detik. |
| **Reliability** | Uptime sistem backend untuk fitur SOS: 99.95%. SOS harus tetap berfungsi (call + SMS fallback) meski server backend down, karena bergantung pada native OS call API. |
| **Scalability** | Backend harus mampu menangani hingga 10.000 sesi SOS concurrent tanpa degradasi performa signifikan. |
| **Security** | Semua data medis dienkripsi at-rest (AES-256) dan in-transit (TLS 1.3). Autentikasi menggunakan JWT dengan refresh token, biometric lock opsional untuk membuka Medical Profile. |
| **Privacy** | Kepatuhan terhadap UU PDP Indonesia; consent eksplisit untuk berbagi data medis; data lokasi hanya disimpan selama sesi SOS + retensi riwayat 12 bulan (dapat dihapus pengguna). |
| **Accessibility** | Kontras warna WCAG AA minimum, ukuran tombol minimal 56–64px, ukuran font minimal 16px, dukungan screen reader (VoiceOver/TalkBack), navigasi satu tangan untuk aksi utama. |
| **Localization** | Bahasa Indonesia default, Bahasa Inggris sebagai opsi; format tanggal & satuan medis (cm/kg) sesuai standar Indonesia. |
| **Offline Support** | SOS tetap berfungsi minimal (call + SMS) tanpa koneksi internet; Medical Profile dapat dibaca offline (cached lokal). |
| **Compatibility** | Android 9+ dan iOS 14+; mendukung ukuran layar dari 5" hingga tablet. |
| **Maintainability** | Arsitektur modular (feature-based), dokumentasi API lengkap (OpenAPI/Swagger), automated testing coverage minimal 70% untuk modul SOS dan Medical Profile. |
| **Battery Efficiency** | Live tracking selama SOS aktif dioptimalkan agar tidak menguras baterai berlebihan (adaptive GPS polling). |

---

## 15. Detailed Feature Specifications

### 15.1 Smart SOS

**Objective**
Memungkinkan pengguna memicu bantuan darurat secepat dan seaman mungkin dengan minimal interaksi fisik dan kognitif, bahkan dalam kondisi panik atau setengah sadar.

**Business Value**
Fitur inti yang membedakan Lifeline dari kompetitor; menjadi alasan utama unduhan dan retensi aplikasi; mengurangi risiko litigasi karena kegagalan bantuan darurat.

**User Story**
Sebagai pengguna yang mengalami kondisi darurat, saya ingin menekan satu tombol untuk memicu bantuan, lokasi, dan notifikasi keluarga sekaligus, agar saya tidak perlu membuka banyak aplikasi dalam kondisi panik.

**Acceptance Criteria**
- Tombol SOS selalu terlihat di Home Screen, minimal ukuran 64px, warna merah (Emergency Red) dengan kontras tinggi.
- Aktivasi memerlukan tekan-dan-tahan selama 2 detik untuk mencegah aktivasi tidak sengaja.
- Setelah tekan-tahan berhasil, muncul countdown 3 detik dengan opsi "Batalkan" yang jelas.
- Jika tidak dibatalkan, sistem menjalankan 4 aksi paralel: (1) memanggil nomor darurat, (2) membagikan lokasi GPS ke kontak darurat, (3) mengirim Medical ID ke kontak darurat, (4) mencatat timeline kejadian.
- Seluruh proses dari tekan awal hingga keempat aksi selesai dikirim: < 5 detik (target < 3 detik).
- Notifikasi konfirmasi ditampilkan ke pengguna bahwa SOS berhasil diaktifkan dan pihak mana saja yang telah diberi tahu.

**Preconditions**
- Pengguna sudah login (atau menggunakan mode darurat tanpa login dengan fungsi terbatas—hanya call, tanpa data medis).
- Izin lokasi (location permission) dan izin telepon (phone permission) sudah diberikan. Jika belum, sistem meminta izin saat onboarding, bukan saat SOS berlangsung.

**Happy Path**
1. Pengguna membuka aplikasi → Home Screen.
2. Pengguna tekan-tahan tombol SOS selama 2 detik.
3. Sistem menampilkan countdown 3 detik dengan tombol besar "Batalkan".
4. Countdown selesai tanpa dibatalkan.
5. Sistem melakukan panggilan ke nomor darurat, membagikan lokasi, mengirim Medical ID, dan mengirim notifikasi push/SMS ke kontak darurat.
6. Layar berpindah ke SOS Active Screen menampilkan status real-time (lokasi terkirim, keluarga diberi tahu, panggilan tersambung).
7. Pengguna dapat melihat Live Tracking dan Emergency Timeline selama sesi berlangsung.

**Alternate Flow**
- Pengguna membatalkan selama countdown → SOS dibatalkan, tidak ada aksi terkirim, kembali ke Home.
- Pengguna mengaktifkan SOS tanpa login (guest mode) → hanya panggilan darurat dan SMS lokasi yang dijalankan (tanpa Medical ID/kontak keluarga karena data tidak tersedia).
- Tidak ada koneksi internet → sistem otomatis fallback ke panggilan telepon native + SMS berisi koordinat GPS ke kontak darurat tersimpan lokal.

**Edge Cases**
- Pengguna menekan SOS berulang kali dalam sesi yang sama → sistem mencegah duplikasi sesi, menampilkan sesi yang sedang aktif.
- GPS tidak dapat mengunci lokasi (sinyal lemah) → sistem tetap mengirim call & notifikasi dengan status "Lokasi tidak tersedia, mencoba ulang..." dan terus mencoba mendapatkan lokasi di background.
- Nomor darurat sibuk/tidak terjawab → sistem menampilkan opsi "Coba ulang" dan tetap melanjutkan pengiriman lokasi & notifikasi ke keluarga.
- Baterai pengguna sangat rendah (<5%) → sistem memprioritaskan pengiriman lokasi & SMS sebelum baterai habis, mengurangi proses non-esensial.
- Semua kontak darurat tidak dapat dihubungi (nomor tidak aktif) → sistem mencoba metode alternatif (WhatsApp API) dan mencatat status "Gagal menghubungi" di timeline.

**Empty State**
- Belum ada kontak darurat ditambahkan → saat SOS aktif, sistem tetap menjalankan call & GPS, dan menampilkan banner "Tambahkan kontak darurat agar keluarga dapat diberi tahu otomatis" di SOS Active Screen.

**Loading State**
- Countdown ditampilkan sebagai animasi lingkaran mundur dengan angka besar (3-2-1); setelah aksi dipicu, setiap aksi (call, share location, notify family, share medical ID) ditampilkan sebagai checklist dengan status "Mengirim..." → "Berhasil"/"Gagal".

**Error State**
- Jika salah satu aksi gagal (mis. gagal mengirim notifikasi karena tidak ada internet), status di checklist berubah menjadi "Gagal – Mencoba ulang" dengan retry otomatis setiap 5 detik hingga 3 kali percobaan, lalu fallback ke SMS.

**Validation Rules**
- Tekan-tahan harus konsisten minimal 2000ms tanpa terputus; jika terputus sebelum 2000ms, aktivasi dibatalkan otomatis.
- Countdown tidak dapat dipercepat maupun dilewati (menghindari human error tetap memberi jeda pembatalan).

**Permissions**
- Location (Always Allow direkomendasikan, When In Use minimum).
- Phone Call.
- SMS (Android) / fallback share sheet (iOS, karena iOS membatasi pengiriman SMS otomatis — gunakan native Message compose API dengan pre-filled content bila auto-send tidak diizinkan OS).
- Contacts (opsional, untuk memilih dari kontak HP saat menambah emergency contact).
- Notifications.

**Data Required**
- User ID, koordinat GPS (lat/long, accuracy, timestamp), Medical ID snapshot, daftar emergency contacts, timestamp aktivasi.

**API Dependencies**
- `POST /sos/activate`
- `POST /sos/{sosId}/location` (streaming update)
- `POST /sos/{sosId}/notify-contacts`
- `GET /sos/{sosId}/status`
- Maps/Geolocation Provider API (Google Maps Platform)
- SMS Gateway Provider (untuk fallback & notifikasi non-push)

**Database Tables**
- `sos_sessions`, `sos_timeline_events`, `emergency_contacts`, `medical_profiles`, `locations_log`

**Analytics Events**
- `sos_button_pressed`, `sos_countdown_started`, `sos_countdown_cancelled`, `sos_activated`, `sos_call_connected`, `sos_location_shared`, `sos_contacts_notified`, `sos_session_ended`

**Success Metrics**
- SOS activation success rate ≥ 99%.
- Rata-rata waktu aktivasi penuh < 3 detik.
- Tingkat pembatalan tidak sengaja < 2% dari total aktivasi.

---

### 15.2 Medical Profile

**Objective**
Menyediakan repositori data medis pengguna yang lengkap, akurat, dan dapat diakses cepat oleh petugas medis maupun kontak darurat saat kondisi darurat terjadi.

**Business Value**
Menjadi nilai jual utama untuk kemitraan RS dan asuransi; meningkatkan completion rate berkorelasi langsung dengan efektivitas SOS.

**User Story**
Sebagai pengguna, saya ingin mengisi data medis saya sekali dan menyimpannya dengan aman, agar informasi ini otomatis tersedia bagi siapa pun yang menolong saya saat darurat.

**Acceptance Criteria**
- Formulir Medical Profile mencakup: nama, foto, tanggal lahir, tinggi, berat, golongan darah, alergi, penyakit bawaan, obat rutin, riwayat operasi, informasi asuransi, status donor organ (opsional).
- Data dapat diedit kapan saja melalui Edit Medical Profile screen.
- Ringkasan Medical ID (versi ringkas, non-sensitif berlebih) dapat dibagikan via link aman berbatas waktu (expire dalam 24 jam) saat SOS aktif.
- Progress completion ditampilkan sebagai persentase di Home/Profile untuk mendorong pengguna melengkapi data.

**Preconditions**
- Pengguna telah membuat akun dan login.

**Happy Path**
1. Pengguna membuka Medical Profile dari Home/Profile.
2. Mengisi data secara bertahap (form multi-section, bisa disimpan parsial).
3. Data tersimpan otomatis (auto-save per section).
4. Progress bar completion terupdate.

**Alternate Flow**
- Pengguna mengimpor sebagian data dari Apple Health / Google Fit (opsional, Phase 2).

**Edge Cases**
- Pengguna memiliki alergi/penyakit yang tidak ada di daftar preset → tersedia free-text field "Lainnya".
- Pengguna menghapus akun → data medis dihapus permanen dalam 30 hari sesuai kebijakan retensi, kecuali diwajibkan hukum untuk disimpan lebih lama.

**Empty State**
- Profile belum diisi sama sekali → tampilkan card "Lengkapi Medical ID Anda sekarang, dibutuhkan hanya 3 menit" dengan CTA jelas di Home.

**Loading State**
- Skeleton loader saat memuat data profile dari server.

**Error State**
- Gagal menyimpan (mis. koneksi terputus) → data tetap tersimpan di local cache, muncul badge "Belum tersinkron" hingga koneksi kembali dan auto-retry sync.

**Validation Rules**
- Golongan darah: dropdown terbatas (A/B/AB/O ± Rh).
- Tanggal lahir: date picker, tidak boleh di masa depan.
- Tinggi/berat: numeric, range realistis (tinggi 30–250cm, berat 2–300kg).
- Foto profil: maks 5MB, format JPG/PNG.

**Permissions**
- Camera/Gallery (untuk foto profil).
- Biometric lock opsional untuk membuka detail Medical Profile dari luar sesi SOS.

**Data Required**
- Seluruh field pada form Medical Profile (lihat Data Model).

**API Dependencies**
- `GET /medical-profile`
- `PUT /medical-profile`
- `POST /medical-profile/photo`

**Database Tables**
- `medical_profiles`, `medical_allergies`, `medical_conditions`, `medical_medications`, `medical_surgeries`

**Analytics Events**
- `medical_profile_started`, `medical_profile_section_completed`, `medical_profile_completed`, `medical_profile_shared`

**Success Metrics**
- Medical ID completion rate ≥ 70% dalam 6 bulan.
- Waktu rata-rata pengisian awal < 5 menit.

---

### 15.3 Emergency Contacts

**Objective**
Memungkinkan pengguna menetapkan hingga 5 kontak yang akan otomatis diberi tahu saat SOS aktif.

**Business Value**
Mendorong viral loop (kontak yang menerima notifikasi berpotensi menjadi pengguna baru); meningkatkan trust karena keluarga terlibat langsung.

**User Story**
Sebagai pengguna, saya ingin menambahkan anggota keluarga/teman sebagai kontak darurat dengan status relasi, agar mereka otomatis mendapat notifikasi saat saya mengaktifkan SOS.

**Acceptance Criteria**
- Maksimal 5 kontak dapat ditambahkan.
- Setiap kontak memiliki nama, nomor telepon, dan status relasi (Ayah, Ibu, Suami/Istri, Teman, Dokter, Lainnya).
- Kontak dapat dipilih langsung dari address book perangkat atau diinput manual.
- Kontak menerima SMS/WhatsApp/push notification (jika sudah install app) berisi link Live Tracking saat SOS aktif.

**Preconditions**
- Pengguna sudah login.

**Happy Path**
1. Pengguna membuka Emergency Contacts.
2. Tap "Tambah Kontak" → pilih dari address book atau input manual.
3. Pilih status relasi.
4. Simpan.

**Alternate Flow**
- Kontak yang ditambahkan sudah menggunakan Lifeline → otomatis terhubung sebagai "Lifeline Connection" dengan notifikasi in-app real-time (bukan hanya SMS).

**Edge Cases**
- Nomor telepon tidak valid/format salah → validasi real-time dengan pesan error.
- Pengguna mencoba menambah kontak ke-6 → sistem menampilkan pesan batas maksimal tercapai dengan opsi upgrade ke Premium untuk kontak tambahan (Phase 2 monetization opportunity).

**Empty State**
- Belum ada kontak → tampilkan ilustrasi + CTA "Tambahkan kontak darurat pertama Anda".

**Loading State**
- Shimmer list saat memuat daftar kontak tersimpan.

**Error State**
- Gagal menyimpan kontak → tampilkan toast error dan pertahankan data di form (tidak hilang).

**Validation Rules**
- Nomor telepon: format Indonesia (+62) divalidasi otomatis.
- Nama: minimal 2 karakter.
- Tidak boleh ada duplikasi nomor telepon dalam daftar kontak yang sama.

**Permissions**
- Contacts (opsional).

**Data Required**
- Nama, nomor telepon, relasi, user_id pemilik.

**API Dependencies**
- `GET /emergency-contacts`
- `POST /emergency-contacts`
- `PUT /emergency-contacts/{id}`
- `DELETE /emergency-contacts/{id}`

**Database Tables**
- `emergency_contacts`

**Analytics Events**
- `emergency_contact_added`, `emergency_contact_removed`, `emergency_contact_limit_reached`

**Success Metrics**
- Rata-rata jumlah kontak per pengguna ≥ 2.
- 60% pengguna menambahkan minimal 1 kontak dalam 24 jam setelah registrasi.

---

### 15.4 Live Tracking

**Objective**
Menyediakan visibilitas lokasi real-time pengguna kepada kontak darurat dan (jika tersedia) petugas selama sesi SOS berlangsung.

**Business Value**
Memberikan rasa aman kepada keluarga; menjadi diferensiator dibanding aplikasi SOS sederhana yang hanya mengirim satu titik lokasi statis.

**User Story**
Sebagai kontak darurat, saya ingin melihat lokasi real-time orang yang mengaktifkan SOS, agar saya bisa mengambil keputusan (datang langsung atau mengarahkan bantuan).

**Acceptance Criteria**
- Lokasi diperbarui setiap 3–5 detik selama SOS aktif.
- Kontak darurat menerima link web (tanpa perlu install app) yang menampilkan peta live location.
- Menampilkan ETA ambulans jika mitra tersedia di area tersebut (Phase 2/kondisional MVP).
- Riwayat pergerakan (breadcrumb trail) ditampilkan di peta selama sesi.

**Preconditions**
- SOS harus dalam status aktif.
- Izin lokasi background diberikan.

**Happy Path**
1. SOS diaktifkan → sesi live tracking otomatis dimulai.
2. Lokasi ter-update secara berkala ke server.
3. Kontak darurat membuka link → melihat peta real-time.
4. Sesi berakhir saat pengguna menekan "Selesai/Aman" atau setelah 2 jam tanpa interaksi (auto-timeout untuk efisiensi baterai & privasi).

**Alternate Flow**
- Pengguna kehilangan sinyal GPS sementara → peta menampilkan lokasi terakhir diketahui dengan label "Lokasi terakhir diketahui pukul [waktu]".

**Edge Cases**
- Baterai HP pengguna habis di tengah sesi → sistem menampilkan lokasi terakhir dan status "Perangkat mungkin mati/kehabisan baterai" kepada kontak darurat.
- Pengguna berpindah ke dalam gedung (sinyal GPS lemah) → gunakan fallback ke network-based location (WiFi/cell tower triangulation).

**Empty State**
- Tidak berlaku (fitur ini hanya muncul saat SOS aktif).

**Loading State**
- Peta menampilkan loading pin saat menunggu sinyal GPS pertama.

**Error State**
- Gagal mengirim update lokasi → retry otomatis dengan exponential backoff, indikator "Menyinkronkan lokasi..." ditampilkan ke pengguna.

**Validation Rules**
- Update lokasi hanya diterima jika accuracy < 100 meter (untuk menghindari data lokasi yang terlalu tidak akurat memicu keputusan salah).

**Permissions**
- Location (Background/Always Allow).

**Data Required**
- sos_session_id, lat, long, accuracy, speed, heading, timestamp.

**API Dependencies**
- WebSocket connection `wss://api.lifeline.app/sos/{sosId}/track`
- `GET /sos/{sosId}/track/history`

**Database Tables**
- `locations_log`, `sos_sessions`

**Analytics Events**
- `live_tracking_started`, `live_tracking_viewed_by_contact`, `live_tracking_ended`, `live_tracking_gps_lost`

**Success Metrics**
- Update lokasi berhasil terkirim ≥ 98% dari total interval selama sesi aktif.
- Rata-rata jeda update ≤ 5 detik.

---

### 15.5 Nearby Emergency Services

**Objective**
Menampilkan layanan darurat terdekat (rumah sakit, klinik, ambulans, apotek 24 jam, polisi, pemadam kebakaran) berdasarkan lokasi pengguna.

**Business Value**
Berguna baik di dalam maupun di luar sesi SOS; meningkatkan engagement harian aplikasi (bukan hanya dipakai saat darurat).

**User Story**
Sebagai pengguna, saya ingin melihat layanan darurat terdekat dari lokasi saya, agar saya bisa langsung menuju atau menghubungi mereka jika dibutuhkan.

**Acceptance Criteria**
- Menampilkan daftar dan peta layanan terdekat berdasarkan kategori (RS, Klinik, Ambulans, Apotek 24 jam, Polisi, Damkar).
- Setiap item menampilkan jarak, estimasi waktu tempuh, nomor telepon, dan tombol "Hubungi" serta "Rute".
- Data bersumber dari Google Places API/Maps Platform dengan filter kategori medis & darurat.

**Preconditions**
- Izin lokasi diberikan.

**Happy Path**
1. Pengguna membuka menu Nearby Services.
2. Pilih kategori.
3. Sistem menampilkan daftar terurut berdasarkan jarak terdekat.
4. Pengguna tap salah satu → melihat Hospital/Service Detail.

**Alternate Flow**
- Pengguna mencari secara manual (search by name) di luar radius default.

**Edge Cases**
- Tidak ada hasil di radius default (5km) → radius otomatis diperluas ke 15km dengan notifikasi "Memperluas area pencarian".
- Data lokasi bisnis tidak akurat (dari pihak ketiga) → sediakan tombol "Laporkan info salah".

**Empty State**
- Tidak ada layanan ditemukan sama sekali → tampilkan pesan "Tidak ditemukan layanan di sekitar Anda, coba hubungi 112".

**Loading State**
- Skeleton list + shimmer map saat memuat data.

**Error State**
- Gagal memuat data (API down) → tampilkan opsi retry dan nomor darurat nasional sebagai fallback informasi statis.

**Validation Rules**
- Radius pencarian default 5km, dapat diperluas manual oleh pengguna.

**Permissions**
- Location.

**Data Required**
- Lokasi pengguna (lat/long), kategori layanan.

**API Dependencies**
- Google Places API / Maps Platform Nearby Search.
- `GET /nearby-services?category=&lat=&long=`

**Database Tables**
- `nearby_services_cache` (caching hasil untuk performa & fallback offline)

**Analytics Events**
- `nearby_services_viewed`, `nearby_service_category_selected`, `nearby_service_called`, `nearby_service_directions_opened`

**Success Metrics**
- Waktu load daftar layanan < 2 detik.
- ≥ 30% pengguna mengakses fitur ini minimal 1x per bulan (non-darurat), menandakan engagement harian.

---

### 15.6 First Aid Guide

**Objective**
Menyediakan panduan pertolongan pertama yang ringkas dan mudah dipahami untuk 8 kategori kondisi darurat umum.

**Business Value**
Meningkatkan value proposition sebagai aplikasi edukasi keselamatan, tidak hanya reaktif; dapat diakses tanpa login untuk memperluas jangkauan/SEO/awareness.

**User Story**
Sebagai pengguna (atau siapa pun di sekitar korban), saya ingin membaca panduan pertolongan pertama singkat untuk kondisi tertentu, agar saya bisa membantu sebelum bantuan medis tiba.

**Acceptance Criteria**
- 8 kategori tersedia: CPR, Choking (Tersedak), Heart Attack, Stroke, Burn (Luka Bakar), Broken Bone (Patah Tulang), Seizure (Kejang), Heavy Bleeding (Pendarahan Hebat).
- Setiap panduan berisi langkah bernomor, ilustrasi/ikon pendukung, dan estimasi waktu tindakan.
- Dapat diakses tanpa perlu login (public access untuk memperluas manfaat sosial).
- Tersedia mode "Baca dengan suara" (text-to-speech) untuk situasi tangan tidak bisa memegang HP (Phase 2).

**Preconditions**
- Tidak ada (dapat diakses kapan saja).

**Happy Path**
1. Pengguna membuka First Aid List dari Home atau saat SOS aktif.
2. Memilih kategori.
3. Melihat First Aid Detail dengan langkah-langkah jelas.

**Alternate Flow**
- Diakses langsung dari SOS Active Screen sebagai shortcut saat menunggu bantuan datang.

**Edge Cases**
- Pengguna offline → konten first aid guide di-cache lokal sepenuhnya agar tetap dapat diakses tanpa internet.

**Empty State**
- Tidak berlaku (konten statis selalu tersedia).

**Loading State**
- Minimal, karena konten di-bundle/cache di aplikasi (tidak bergantung API untuk versi awal).

**Error State**
- Tidak berlaku untuk versi cached; jika versi online-only, tampilkan pesan retry.

**Validation Rules**
- Tidak ada input pengguna pada fitur ini (read-only content).

**Permissions**
- Tidak ada permission khusus.

**Data Required**
- Konten statis per kategori (judul, langkah, ilustrasi, durasi estimasi).

**API Dependencies**
- `GET /first-aid-guides` (untuk update konten dari server, dengan local caching/versioning).

**Database Tables**
- `first_aid_guides`, `first_aid_steps`

**Analytics Events**
- `first_aid_guide_opened`, `first_aid_category_viewed`, `first_aid_guide_accessed_during_sos`

**Success Metrics**
- ≥ 40% pengguna pernah membuka minimal 1 panduan first aid.
- Waktu baca rata-rata sesuai estimasi durasi konten (indikator konten mudah dipahami).

---

### 15.7 Emergency Timeline & History

**Objective**
Mendokumentasikan setiap kejadian darurat secara kronologis untuk transparansi, evaluasi, dan potensi kebutuhan hukum/asuransi.

**Business Value**
Data historis menjadi aset untuk kemitraan asuransi (klaim) dan continuous improvement produk; meningkatkan kepercayaan pengguna terhadap sistem.

**User Story**
Sebagai pengguna, saya ingin melihat ringkasan kejadian darurat setelah selesai, agar saya dan keluarga memiliki catatan lengkap untuk keperluan medis/asuransi di kemudian hari.

**Acceptance Criteria**
- Timeline menampilkan setiap event dengan timestamp: SOS Activated, Location Shared, Family Notified, Emergency Call Connected, Ambulance Dispatched (jika ada), Help Arrived (input manual/dikonfirmasi pengguna).
- Riwayat semua sesi SOS sebelumnya dapat diakses di Emergency History.
- Setiap riwayat dapat dibuka untuk melihat History Detail lengkap termasuk peta rute pergerakan.

**Preconditions**
- Minimal 1 sesi SOS pernah diaktifkan.

**Happy Path**
1. SOS berakhir (ditandai pengguna "Saya Aman" atau auto-timeout).
2. Sistem membuat ringkasan otomatis.
3. Pengguna dapat mengakses ringkasan dari notifikasi atau menu Emergency History.

**Alternate Flow**
- Pengguna membagikan riwayat kejadian ke dokter/RS sebagai referensi kunjungan berikutnya (export PDF, Phase 2).

**Edge Cases**
- Sesi SOS terputus tanpa penutupan jelas (mis. HP mati) → sistem menutup sesi otomatis setelah 2 jam tidak ada update, dengan status "Sesi berakhir otomatis (tidak ada update)".

**Empty State**
- Belum pernah ada kejadian SOS → tampilkan pesan positif "Belum ada riwayat darurat. Semoga tetap aman selalu!"

**Loading State**
- Skeleton list saat memuat riwayat.

**Error State**
- Gagal memuat riwayat → tampilkan retry button dengan pesan error jelas.

**Validation Rules**
- Timeline bersifat read-only (tidak dapat diedit pengguna, hanya sistem yang mencatat, untuk menjaga integritas data).

**Permissions**
- Tidak ada permission tambahan (menggunakan data dari sesi SOS).

**Data Required**
- sos_session_id, list of timeline events dengan timestamp dan tipe event.

**API Dependencies**
- `GET /sos-history`
- `GET /sos-history/{id}`

**Database Tables**
- `sos_sessions`, `sos_timeline_events`

**Analytics Events**
- `sos_history_viewed`, `sos_history_detail_opened`, `sos_marked_safe`

**Success Metrics**
- 100% sesi SOS memiliki timeline lengkap tanpa data hilang.
- ≥ 50% pengguna membuka riwayat setelah menerima ringkasan pasca-kejadian.

---

## 16. User Flows

### Flow 1: Onboarding → Aktivasi Akun
Splash → Onboarding (3 layar) → Permission Request (lokasi, telepon, notifikasi) → Register (nomor HP) → OTP Verification → Isi Medical Profile (dapat di-skip sementara, dengan reminder) → Tambah Emergency Contacts (dapat di-skip sementara) → Home.

### Flow 2: Aktivasi SOS (Kritis)
Home → Tekan-tahan tombol SOS (2 detik) → Countdown 3 detik (opsi batal) → SOS Active (call terhubung, lokasi terkirim, keluarga diberi tahu) → Live Tracking berjalan → Pengguna/petugas menandai "Bantuan Tiba"/"Saya Aman" → Emergency Timeline tersimpan → Ringkasan pasca-kejadian.

### Flow 3: Kontak Darurat Menerima Notifikasi
Notifikasi SMS/WA/Push diterima → Tap link → Buka Live Tracking (web view jika belum install app) → Melihat lokasi, status, nomor yang bisa dihubungi → (Opsional) Install aplikasi untuk pengalaman penuh.

### Flow 4: Eksplorasi Non-Darurat
Home → Nearby Services / First Aid Guide → Browsing tanpa tekanan waktu → Kembali ke Home.

### Flow 5: Upgrade ke Premium
Home/Profile → Menu Premium → Melihat perbandingan fitur Free vs Premium → Pilih paket → Pembayaran (payment gateway) → Aktivasi fitur premium (wearable integration, dsb.).

---

## 17. Information Architecture

```
Lifeline App
├── Auth
│   ├── Splash
│   ├── Onboarding (1-3)
│   ├── Login
│   └── Register (OTP)
├── Home (Root Tab)
│   ├── SOS Button (Primary Action)
│   ├── Quick Access: Nearby Services, First Aid
│   └── Medical ID Completion Reminder
├── SOS Flow
│   ├── SOS Countdown
│   ├── SOS Active
│   └── Live Tracking
├── Medical Profile (Tab)
│   ├── View Profile
│   └── Edit Profile
├── Emergency Contacts (Tab)
├── Services (Tab)
│   ├── Nearby Services List
│   └── Hospital/Service Detail
├── First Aid (Tab)
│   ├── First Aid List
│   └── First Aid Detail
├── History
│   ├── Emergency History List
│   └── History Detail
├── Notifications
└── Profile & Settings
    ├── Account Settings
    ├── Premium
    └── About
```

---

## 18. Screen Inventory

| # | Layar | Deskripsi Singkat |
|---|---|---|
| 1 | Splash | Logo & branding saat app dibuka |
| 2 | Onboarding 1 | Perkenalan value proposition: "Bantuan dalam hitungan detik" |
| 3 | Onboarding 2 | Perkenalan Medical ID & manfaatnya |
| 4 | Onboarding 3 | Perkenalan Emergency Contacts & Live Tracking |
| 5 | Login | Login dengan nomor HP/Google/Apple |
| 6 | Register | Registrasi akun baru + OTP |
| 7 | Permission Request | Meminta izin lokasi, telepon, notifikasi sekaligus dengan penjelasan alasan |
| 8 | Home | Tombol SOS utama, quick access, reminder completion |
| 9 | SOS Countdown | Countdown 3 detik dengan opsi batal |
| 10 | SOS Active | Status real-time: call, lokasi, notifikasi keluarga |
| 11 | Live Tracking | Peta real-time lokasi pengguna |
| 12 | Medical Profile | Ringkasan data medis pengguna |
| 13 | Edit Medical Profile | Form edit data medis |
| 14 | Emergency Contacts | Daftar & kelola kontak darurat |
| 15 | Nearby Services | Daftar layanan darurat terdekat |
| 16 | Hospital Detail | Detail RS/klinik/apotek tertentu |
| 17 | First Aid List | Daftar 8 kategori pertolongan pertama |
| 18 | First Aid Detail | Langkah-langkah detail per kategori |
| 19 | Notifications | Daftar notifikasi sistem & darurat |
| 20 | Emergency History | Riwayat semua kejadian SOS |
| 21 | History Detail | Detail timeline & peta 1 kejadian |
| 22 | Profile | Info akun pengguna |
| 23 | Settings | Pengaturan aplikasi (bahasa, dark mode, notifikasi, privasi) |
| 24 | Premium | Halaman paket berlangganan |
| 25 | About | Info aplikasi, disclaimer medis, kontak support |

**Total: 25 layar** (sesuai brief awal, dipertahankan untuk MVP).

---

## 19. UX Guidelines

1. **Aksi kritis maksimal 3 langkah:** Setiap alur yang berkaitan dengan keselamatan (SOS, akses first aid dari SOS Active) harus dapat diselesaikan dalam maksimal 3 tap.
2. **Desain untuk satu tangan:** Tombol utama diposisikan di zona jangkauan ibu jari (thumb zone), terutama tombol SOS.
3. **Feedback instan:** Setiap aksi (tekan tombol, submit form) harus memberi feedback visual/haptic dalam <100ms.
4. **Minim teks, maksimal ikon:** Terutama pada elemen kritis darurat, gunakan kombinasi ikon besar + teks singkat, bukan paragraf panjang.
5. **Progressive disclosure:** Medical Profile diisi bertahap (bukan satu form panjang) agar tidak membebani pengguna, terutama persona lansia.
6. **Confirmatory, bukan blocking:** Konfirmasi pembatalan SOS harus jelas namun tidak menghambat aktivasi jika memang genuine emergency (hindari terlalu banyak dialog konfirmasi).
7. **Desain untuk stres tinggi:** Hindari animasi berlebihan atau microcopy yang playful di flow SOS; gunakan bahasa tegas, jelas, menenangkan namun serius.
8. **Aksesibilitas sebagai default, bukan opsi tambahan:** Semua komponen dirancang accessible dari awal (bukan retrofit).

---

## 20. UI Guidelines

- **Grid & Spacing:** 8px base grid system untuk konsistensi spacing di seluruh layar.
- **Tombol:** Minimal height 56px (utama) hingga 64px (SOS button), radius rounded-medium (12–16px) untuk kesan friendly namun tetap tegas.
- **Warna status:** Merah (Emergency Red) hanya digunakan untuk elemen darurat/SOS agar maknanya tidak terdilusi; hijau untuk status berhasil/aman; amber untuk peringatan; biru untuk elemen informasi medis netral.
- **Ikon:** Gaya rounded, filled, simple (mengikuti brief), konsisten menggunakan satu icon set (mis. Phosphor Icons atau Material Symbols Rounded).
- **Kartu (Cards):** Digunakan untuk Medical Profile summary, Emergency Contact list, Nearby Service list — shadow minimal, border radius konsisten dengan tombol.
- **Empty & Error States:** Selalu menyertakan ilustrasi ringan + microcopy yang jelas + CTA aksi berikutnya.
- **Dark Mode:** Wajib didukung penuh sejak MVP karena penggunaan darurat sering terjadi malam hari; kontras tetap dijaga WCAG AA di kedua mode.

---

## 21. Design System

### Warna

| Token | Hex (asumsi) | Penggunaan |
|---|---|---|
| `color-primary-emergency` | #E53935 | Tombol SOS, elemen darurat kritis |
| `color-secondary-medical` | #1E88E5 | Elemen medis, Medical ID, informasi netral |
| `color-background` | #FFFFFF (Light) / #121212 (Dark) | Background utama |
| `color-success` | #43A047 | Status berhasil, "Aman" |
| `color-warning` | #FFB300 | Peringatan, status pending |
| `color-text-primary` | #1A1A1A (Light) / #F5F5F5 (Dark) | Teks utama |
| `color-text-secondary` | #6B6B6B (Light) / #B0B0B0 (Dark) | Teks sekunder |

### Tipografi
- **Font Utama:** Inter (Android/Web), SF Pro (iOS native fallback), Poppins (untuk heading/branding marketing).
- **Skala:** Display 32px / Heading 24px / Subheading 18px / Body 16px (minimum untuk aksesibilitas) / Caption 14px.

### Ikonografi
- Style: Rounded, filled, simple, konsisten 24x24px grid.

### Komponen Utama
- SOS Button (primary, floating/fixed di Home).
- Status Checklist Item (untuk SOS Active progress).
- Contact Card (untuk Emergency Contacts).
- Timeline Item (untuk Emergency History).
- Info Card (untuk Medical Profile summary & Nearby Service item).

---

## 22. Data Model

### `users`
| Field | Type | Keterangan |
|---|---|---|
| id | UUID (PK) | |
| phone_number | VARCHAR, unique | Login utama |
| email | VARCHAR, nullable | |
| full_name | VARCHAR | |
| password_hash | VARCHAR, nullable | Null jika login via OTP/social only |
| auth_provider | ENUM (phone, google, apple) | |
| created_at | TIMESTAMP | |
| updated_at | TIMESTAMP | |
| is_premium | BOOLEAN | |
| language_preference | ENUM (id, en) | |

### `medical_profiles`
| Field | Type | Keterangan |
|---|---|---|
| id | UUID (PK) | |
| user_id | UUID (FK → users) | |
| photo_url | VARCHAR, nullable | |
| date_of_birth | DATE | |
| height_cm | INTEGER | |
| weight_kg | INTEGER | |
| blood_type | ENUM (A+, A-, B+, B-, AB+, AB-, O+, O-) | |
| is_organ_donor | BOOLEAN, nullable | |
| insurance_provider | VARCHAR, nullable | |
| insurance_number | VARCHAR, nullable | |
| updated_at | TIMESTAMP | |

### `medical_allergies` / `medical_conditions` / `medical_medications` / `medical_surgeries`
| Field | Type | Keterangan |
|---|---|---|
| id | UUID (PK) | |
| medical_profile_id | UUID (FK) | |
| name | VARCHAR | |
| notes | TEXT, nullable | |
| created_at | TIMESTAMP | |

### `emergency_contacts`
| Field | Type | Keterangan |
|---|---|---|
| id | UUID (PK) | |
| user_id | UUID (FK → users) | |
| name | VARCHAR | |
| phone_number | VARCHAR | |
| relationship | ENUM (father, mother, spouse, friend, doctor, other) | |
| is_lifeline_user | BOOLEAN | Jika kontak juga pengguna Lifeline |
| created_at | TIMESTAMP | |

### `sos_sessions`
| Field | Type | Keterangan |
|---|---|---|
| id | UUID (PK) | |
| user_id | UUID (FK → users, nullable jika guest mode) | |
| status | ENUM (active, resolved, auto_closed, cancelled) | |
| activated_at | TIMESTAMP | |
| resolved_at | TIMESTAMP, nullable | |
| initial_lat | DECIMAL | |
| initial_long | DECIMAL | |

### `sos_timeline_events`
| Field | Type | Keterangan |
|---|---|---|
| id | UUID (PK) | |
| sos_session_id | UUID (FK) | |
| event_type | ENUM (activated, location_shared, family_notified, call_connected, ambulance_dispatched, help_arrived, cancelled, auto_closed) | |
| event_timestamp | TIMESTAMP | |
| metadata | JSONB, nullable | |

### `locations_log`
| Field | Type | Keterangan |
|---|---|---|
| id | UUID (PK) | |
| sos_session_id | UUID (FK) | |
| lat | DECIMAL | |
| long | DECIMAL | |
| accuracy_meters | DECIMAL | |
| recorded_at | TIMESTAMP | |

### `nearby_services_cache`
| Field | Type | Keterangan |
|---|---|---|
| id | UUID (PK) | |
| place_id | VARCHAR (dari Google Places) | |
| category | ENUM (hospital, clinic, ambulance, pharmacy24h, police, fire_station) | |
| name | VARCHAR | |
| lat | DECIMAL | |
| long | DECIMAL | |
| phone_number | VARCHAR, nullable | |
| cached_at | TIMESTAMP | |

### `first_aid_guides` / `first_aid_steps`
| Field | Type | Keterangan |
|---|---|---|
| id | UUID (PK) | |
| category | ENUM (cpr, choking, heart_attack, stroke, burn, broken_bone, seizure, heavy_bleeding) | |
| title | VARCHAR | |
| step_order | INTEGER (untuk `first_aid_steps`) | |
| content | TEXT | |
| icon_url | VARCHAR, nullable | |

---

## 23. API Specification

Base URL: `https://api.lifeline.app/v1`
Autentikasi: Bearer JWT (kecuali endpoint publik seperti First Aid Guide & Auth).

| Method | Endpoint | Deskripsi | Auth |
|---|---|---|---|
| POST | `/auth/register` | Registrasi dengan nomor HP | Publik |
| POST | `/auth/verify-otp` | Verifikasi OTP | Publik |
| POST | `/auth/login` | Login (HP/Google/Apple) | Publik |
| POST | `/auth/refresh-token` | Refresh JWT | Publik (refresh token) |
| GET | `/medical-profile` | Ambil data medis pengguna | JWT |
| PUT | `/medical-profile` | Update data medis | JWT |
| POST | `/medical-profile/photo` | Upload foto profil | JWT |
| GET | `/emergency-contacts` | List kontak darurat | JWT |
| POST | `/emergency-contacts` | Tambah kontak | JWT |
| PUT | `/emergency-contacts/{id}` | Update kontak | JWT |
| DELETE | `/emergency-contacts/{id}` | Hapus kontak | JWT |
| POST | `/sos/activate` | Aktivasi sesi SOS | JWT / Guest Token |
| POST | `/sos/{sosId}/location` | Kirim update lokasi | JWT / Guest Token |
| POST | `/sos/{sosId}/notify-contacts` | Trigger notifikasi kontak darurat | Internal/System |
| GET | `/sos/{sosId}/status` | Cek status sesi SOS | JWT / Public (link terbatas untuk kontak darurat) |
| POST | `/sos/{sosId}/resolve` | Tandai sesi selesai/aman | JWT |
| GET | `/sos-history` | Riwayat sesi SOS pengguna | JWT |
| GET | `/sos-history/{id}` | Detail satu riwayat SOS | JWT |
| GET | `/nearby-services` | Cari layanan darurat terdekat | JWT/Publik |
| GET | `/first-aid-guides` | List panduan pertolongan pertama | Publik |
| GET | `/first-aid-guides/{category}` | Detail panduan per kategori | Publik |
| GET | `/notifications` | List notifikasi pengguna | JWT |
| POST | `/premium/subscribe` | Berlangganan Premium | JWT |
| WS | `/sos/{sosId}/track` | WebSocket live tracking lokasi | JWT / Public token untuk viewer kontak darurat |

**Contoh Request/Response — `POST /sos/activate`**
```json
// Request
{
  "lat": -6.200000,
  "long": 106.816666,
  "accuracy_meters": 8.5,
  "is_guest": false
}

// Response 201
{
  "sos_session_id": "b1a2c3d4-...",
  "status": "active",
  "actions_triggered": [
    "emergency_call_initiated",
    "location_sharing_started",
    "contacts_notification_queued",
    "medical_id_shared"
  ],
  "tracking_ws_url": "wss://api.lifeline.app/v1/sos/b1a2c3d4-.../track"
}
```

---

## 24. Security & Privacy

- **Enkripsi:** Data medis dan lokasi dienkripsi at-rest (AES-256) dan in-transit (TLS 1.3).
- **Autentikasi:** JWT dengan access token (15 menit) + refresh token (30 hari), rotasi token pada setiap refresh.
- **Biometric Lock:** Opsional untuk membuka Medical Profile detail di luar konteks SOS aktif.
- **Consent eksplisit:** Saat onboarding, pengguna wajib menyetujui kebijakan privasi terkait pengumpulan data lokasi & medis, sesuai UU PDP.
- **Guest Mode terbatas:** Pengguna yang mengaktifkan SOS tanpa akun hanya dapat memicu call & share lokasi ke nomor darurat, tanpa akses ke data medis tersimpan (karena tidak ada).
- **Data Retention:** Riwayat lokasi disimpan maksimal 12 bulan, dapat dihapus manual oleh pengguna kapan saja; data dihapus permanen 30 hari setelah penghapusan akun.
- **Akses pihak ketiga (link Live Tracking):** Menggunakan token unik berbatas waktu (expire 2 jam setelah sesi berakhir), tidak dapat diakses ulang setelah expire.
- **Audit Log:** Seluruh akses ke data medis sensitif (terutama oleh sistem/admin support) dicatat dalam audit trail.
- **Rate Limiting:** Endpoint `/sos/activate` diberi pengecualian khusus (prioritas tinggi, tidak boleh terkena throttle standar) mengingat sifatnya safety-critical.

---

## 25. Analytics Events

| Event | Trigger | Properti Utama |
|---|---|---|
| `app_opened` | Aplikasi dibuka | user_id, session_id |
| `onboarding_completed` | Onboarding selesai | user_id |
| `medical_profile_completed` | Semua section Medical Profile terisi | user_id, completion_time |
| `emergency_contact_added` | Kontak darurat ditambahkan | user_id, contact_count |
| `sos_activated` | SOS berhasil diaktifkan | user_id/guest_id, lat, long, has_medical_profile, contact_count |
| `sos_cancelled` | SOS dibatalkan saat countdown | user_id, cancel_time_ms |
| `sos_resolved` | Sesi SOS ditandai selesai | sos_session_id, duration_seconds |
| `first_aid_guide_opened` | Panduan first aid dibuka | category, source (home/sos_active) |
| `nearby_services_viewed` | Fitur nearby services dibuka | category |
| `premium_subscribed` | Pengguna berlangganan Premium | plan_type |
| `app_crash` | Crash terdeteksi | screen_name, error_code |

---

## 26. Notifications

| Notifikasi | Penerima | Trigger | Channel |
|---|---|---|---|
| "SOS Anda telah diaktifkan" | Pengguna | Setelah SOS diaktifkan | Push |
| "[Nama] mengaktifkan SOS - lihat lokasinya" | Kontak Darurat | SOS diaktifkan | Push (jika Lifeline user) / SMS / WhatsApp |
| "Lengkapi Medical ID Anda" | Pengguna | 24 jam setelah registrasi jika belum lengkap | Push |
| "[Nama] telah menandai dirinya aman" | Kontak Darurat | Sesi SOS di-resolve | Push/SMS |
| "Ringkasan kejadian darurat Anda" | Pengguna | Setelah sesi SOS selesai | Push + In-app |
| "Pengingat obat: [Nama Obat]" | Pengguna (Premium) | Sesuai jadwal yang diatur | Push |
| "Langganan Premium akan berakhir" | Pengguna Premium | 3 hari sebelum expired | Push |

---

## 27. AI Opportunities

Sesuai arahan awal, fitur AI diposisikan sebagai **pendukung keputusan, bukan pengganti tenaga medis**, dengan disclaimer jelas di setiap interaksi AI.

1. **AI Symptom Urgency Checker (Phase 2)** — Pengguna memasukkan gejala (mis. nyeri dada, sesak napas) melalui chat/quick-select, AI memberikan estimasi tingkat urgensi (Rendah/Sedang/Tinggi/Kritis) beserta rekomendasi tindakan (hubungi 112, ke IGD terdekat, atau observasi mandiri). Selalu disertai disclaimer: *"Ini bukan diagnosis medis. Jika ragu, segera hubungi layanan darurat."*
2. **AI First Aid Assistant (Phase 2)** — Saat SOS aktif dan bantuan belum tiba, AI dapat memberikan instruksi pertolongan pertama step-by-step yang disesuaikan dengan situasi yang dijelaskan pengguna/penolong (mis. "korban tidak sadarkan diri, tidak bernapas" → panduan CPR interaktif dengan hitungan).
3. **AI Incident Summary Generator (Phase 2/3)** — AI menyusun ringkasan otomatis dari data Medical Profile + timeline kejadian menjadi format singkat yang mudah dibaca petugas medis/keluarga dalam hitungan detik saat SOS diaktifkan.
4. **AI Risk Pattern Detection (Future)** — Menganalisis pola riwayat kesehatan (dengan consent) untuk memberikan peringatan preventif, mis. "Anda telah 3x mengalami gejala serupa dalam sebulan terakhir, pertimbangkan konsultasi ke dokter."

**Prinsip Desain AI:** Semua output AI harus (a) menyertakan disclaimer non-diagnosis, (b) memberikan opsi eskalasi jelas ke layanan darurat resmi, (c) dapat diaudit (log input-output untuk continuous improvement dan tanggung jawab hukum).

---

## 28. Technical Architecture

### Arsitektur Tingkat Tinggi
```
[Mobile App: React Native]
        |
        | REST + WebSocket
        v
[API Gateway] --- [Auth Service (JWT/OTP)]
        |
        v
[Backend Services (NestJS, modular monolith → microservices siap)]
   ├── SOS Service (real-time, high priority queue)
   ├── Medical Profile Service
   ├── Emergency Contacts Service
   ├── Notification Service (Push/SMS/WhatsApp Gateway)
   ├── Nearby Services Aggregator (Google Places API cache layer)
   ├── First Aid Content Service
   └── AI Service (Phase 2, terhubung ke LLM provider API)
        |
        v
[PostgreSQL] + [Redis (cache, session, rate limit)] + [WebSocket Server]
        |
        v
[Third-Party Integrations]
   ├── Google Maps Platform (Geolocation, Places, Directions)
   ├── SMS/WhatsApp Gateway (mis. Twilio/Vonage/lokal provider)
   ├── Payment Gateway (Midtrans/Xendit untuk Premium)
   └── Partner Ambulance API (Phase 2)
```

### Justifikasi Keputusan Teknis
- **React Native:** Mempercepat development cross-platform sambil tetap mampu mengakses native module (call, SMS, background location) yang krusial untuk fitur SOS.
- **NestJS + PostgreSQL:** Struktur modular memudahkan tim scale dari monolith ke microservices seiring fitur bertambah (mis. AI Service dapat dipisah di Phase 2).
- **Redis:** Digunakan untuk session management, rate limiting (dengan pengecualian prioritas untuk endpoint SOS), dan caching nearby services agar respons cepat.
- **WebSocket untuk Live Tracking:** Dibutuhkan update lokasi sub-5-detik yang tidak efisien jika menggunakan polling REST biasa.
- **SOS sebagai high-priority queue terpisah:** Semua request terkait SOS diproses melalui jalur prioritas tertinggi di infrastruktur (dedicated worker/queue), terpisah dari trafik non-kritis, untuk menjamin SLA 99.95%.

---

## 29. Risks & Mitigation

| Risiko | Dampak | Mitigasi |
|---|---|---|
| Kegagalan sistem SOS saat dibutuhkan (server down) | Sangat Tinggi — risiko nyawa & reputasi | Fallback native call/SMS tidak bergantung server; dedicated infra dengan redundansi multi-region; SLA monitoring 24/7 |
| Data medis bocor/disalahgunakan | Tinggi — pelanggaran privasi, litigasi | Enkripsi end-to-end, audit trail, kepatuhan UU PDP, penetration testing rutin |
| Aktivasi SOS palsu/tidak sengaja (prank) | Sedang — membebani layanan darurat riil | Tekan-tahan 2 detik + countdown 3 detik sebagai friction wajar; deteksi pola abuse (rate limiting per akun) |
| Ketergantungan pada API pihak ketiga (Maps, SMS Gateway) down | Sedang-Tinggi | Multi-provider fallback (mis. 2 SMS gateway berbeda); caching lokal untuk nearby services |
| Regulasi kesehatan/data pribadi berubah | Sedang | Kolaborasi dengan Legal/Compliance sejak awal; arsitektur data yang fleksibel untuk audit |
| Kepercayaan pengguna rendah di awal (aplikasi baru, belum ada kemitraan RS resmi) | Sedang | Kampanye edukasi, transparansi disclaimer, early partnership dengan minimal 1 RS untuk kredibilitas awal |
| AI memberikan rekomendasi yang salah/menyesatkan (Phase 2) | Tinggi jika tidak dimitigasi | Disclaimer eksplisit, human-in-the-loop untuk kasus kritis, testing ekstensif sebelum rilis fitur AI |
| Baterai HP pengguna habis saat darurat | Sedang | Fallback SMS (tidak butuh data), optimasi battery usage, edukasi pengguna via onboarding |

---

## 30. QA Plan

### Prioritas Testing
1. **SOS Flow (Critical Path)** — Testing paling ketat: unit test, integration test, dan end-to-end test untuk setiap kombinasi skenario (online/offline, dengan/tanpa Medical Profile, dengan/tanpa kontak darurat, GPS lemah, baterai rendah).
2. **Load & Stress Testing** — Simulasi 10.000 sesi SOS concurrent untuk memvalidasi non-functional requirement scalability.
3. **Reliability/Chaos Testing** — Simulasi server down, network partition, untuk memastikan fallback native call/SMS tetap berjalan.
4. **Accessibility Testing** — Manual testing dengan screen reader (VoiceOver/TalkBack), color contrast checker, dan usability testing bersama persona lansia (Dewi) untuk memastikan interface benar-benar dapat digunakan tanpa bantuan.
5. **Security Testing** — Penetration testing terhadap endpoint medis & SOS, terutama terhadap risiko unauthorized access ke Medical Profile.
6. **Regression Testing** — Automated test suite dijalankan di setiap CI/CD pipeline sebelum deployment, minimal coverage 70% untuk modul SOS dan Medical Profile.
7. **Device & OS Fragmentation Testing** — Testing di berbagai device Android low-end (RAM rendah) mengingat target pengguna termasuk segmen non-tech-savvy dengan device lebih lama.

### Kriteria Rilis (Release Criteria)
- Zero critical/high severity bug pada modul SOS.
- SOS activation success rate ≥ 99% pada staging environment dengan simulasi 1.000 concurrent sessions.
- Semua acceptance criteria pada Feature Specifications (Section 15) terverifikasi lulus.

---

## 31. Development Roadmap

| Fase | Durasi | Fokus Utama |
|---|---|---|
| **Sprint 0 — Setup** | 2 minggu | Setup arsitektur, CI/CD, design system, infra dasar |
| **Sprint 1-2** | 4 minggu | Auth, Onboarding, Medical Profile, Emergency Contacts |
| **Sprint 3-4** | 4 minggu | Smart SOS (core), Live Tracking, fallback call/SMS |
| **Sprint 5** | 2 minggu | Nearby Services, First Aid Guide |
| **Sprint 6** | 2 minggu | Emergency Timeline & History, Notifications |
| **Sprint 7** | 2 minggu | QA intensif, accessibility & security testing, bug fixing |
| **Sprint 8** | 2 minggu | Beta testing terbatas (closed beta 500 pengguna), iterasi berdasarkan feedback |
| **Launch MVP** | — | Peluncuran publik (Bulan 4) |
| **Phase 2 (Bulan 5-9)** | 20 minggu | AI Urgency Checker, AI First Aid Assistant, integrasi mitra ambulans, wearable integration, Lifeline Premium |
| **Phase 3 (Bulan 10+)** | — | Crash detection, AI incident summary, ekspansi regional, integrasi asuransi |

---

## 32. Launch Strategy

1. **Closed Beta (500 pengguna):** Fokus di Jabodetabek, rekrut melalui komunitas ojek online, mahasiswa, dan pekerja commuter untuk validasi flow SOS di kondisi nyata (bukan hanya lab testing).
2. **Kemitraan Peluncuran:** Umumkan peluncuran bersamaan dengan minimal 1 kemitraan rumah sakit untuk kredibilitas awal ("Didukung oleh RS [Nama]").
3. **Kampanye Edukasi Publik:** Konten media sosial tentang pentingnya "golden hour" dalam kondisi darurat medis, mendorong instalasi sebagai bagian dari kesiapsiagaan pribadi.
4. **Growth Loop via Emergency Contacts:** Setiap kontak darurat yang menerima notifikasi mendapat CTA halus untuk install aplikasi (bukan hard-sell, tetap fokus pada value keselamatan).
5. **PR & Media Kesehatan:** Kerja sama dengan media kesehatan dan influencer keselamatan berkendara (khususnya komunitas motor) untuk menjangkau persona primer (Rizky).
6. **App Store Optimization (ASO):** Optimasi kata kunci seperti "SOS darurat", "medical ID Indonesia", "aplikasi darurat kesehatan".

---

## 33. Appendix

### A. Glosarium
- **Medical ID:** Ringkasan data medis penting pengguna (golongan darah, alergi, penyakit, obat rutin).
- **SOS Session:** Satu sesi aktivasi darurat, dari tombol ditekan hingga ditandai selesai/aman.
- **Golden Hour:** Periode kritis (umumnya 1 jam pertama) setelah kejadian darurat medis di mana penanganan cepat sangat memengaruhi peluang keselamatan.
- **Guest Mode:** Mode penggunaan SOS tanpa akun terdaftar, dengan fungsi terbatas.

### B. Referensi Desain (dari Brief Awal)
- Style: Modern, Minimal, High Accessibility, Medical, Friendly, Reliable.
- Warna: Emergency Red (primary), Medical Blue (secondary), White (background), Green (success), Amber (warning).
- Tipografi: Inter, SF Pro, Poppins.
- Ikon: Rounded, filled, simple.

### C. Disclaimer Legal (Wajib Ditampilkan Saat Onboarding & di Halaman About)
*"Lifeline adalah aplikasi pendukung dalam situasi darurat dan bukan pengganti layanan medis profesional atau layanan darurat resmi. Dalam kondisi darurat, selalu hubungi layanan darurat resmi (112) sesegera mungkin. Fitur berbasis AI dalam aplikasi ini bersifat sebagai alat bantu (decision support) dan tidak memberikan diagnosis medis."*

### D. Open Questions untuk Stakeholder
- Apakah sudah ada MoU awal dengan mitra ambulans/RS untuk mendukung ETA real-time sejak MVP, atau seluruhnya diasumsikan Phase 2?
- Apakah target ekspansi internasional sudah menjadi prioritas dalam 12 bulan pertama, mengingat ini akan memengaruhi arsitektur multi-bahasa & multi-regulasi sejak awal?
- Apakah model bisnis kemitraan asuransi akan berbentuk komisi rujukan, integrasi klaim langsung, atau keduanya?

---

*Dokumen ini adalah living document dan akan diperbarui seiring validasi pasar, feedback pengguna beta, dan keputusan bisnis lanjutan.*
