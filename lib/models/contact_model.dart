class ContactModel {
  final String initials;
  final String name;
  final String relation;
  final String phone;
  final bool isPrimary;

  ContactModel({
    required this.initials,
    required this.name,
    required this.relation,
    required this.phone,
    this.isPrimary = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'initials': initials,
      'name': name,
      'relation': relation,
      'phone': phone,
      'isPrimary': isPrimary,
    };
  }

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      initials: json['initials'] ?? '',
      name: json['name'] ?? '',
      relation: json['relation'] ?? '',
      phone: json['phone'] ?? '',
      isPrimary: json['isPrimary'] ?? false,
    );
  }
}
