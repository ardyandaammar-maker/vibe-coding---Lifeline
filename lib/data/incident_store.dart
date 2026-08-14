import 'package:flutter/foundation.dart';

class IncidentModel {
  final String dateMeta;
  final String status;
  final String title;
  final String location;
  final String outcome;

  IncidentModel({
    required this.dateMeta,
    required this.status,
    required this.title,
    required this.location,
    required this.outcome,
  });
}

class IncidentStore {
  static final IncidentStore _instance = IncidentStore._internal();
  factory IncidentStore() => _instance;
  IncidentStore._internal();

  final ValueNotifier<List<IncidentModel>> incidents = ValueNotifier([
    IncidentModel(
      dateMeta: '18 Jul 2026 · 22:14',
      status: 'Selesai',
      title: 'Uji SOS',
      location: 'Jl. Palmerah Barat',
      outcome: 'Berhasil (uji coba)',
    ),
    IncidentModel(
      dateMeta: '02 Mei 2026 · 07:48',
      status: 'Selesai',
      title: 'SOS Aktif',
      location: 'Tol Jagorawi KM 24',
      outcome: 'Bantuan tiba 9 menit',
    ),
  ]);

  void addIncident(IncidentModel incident) {
    incidents.value = [incident, ...incidents.value];
  }

  void removeIncident(IncidentModel incident) {
    final newList = List<IncidentModel>.from(incidents.value);
    newList.remove(incident);
    incidents.value = newList;
  }
}
