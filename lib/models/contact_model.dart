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
}
