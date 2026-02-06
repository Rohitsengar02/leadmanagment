class Lead {
  final String? id;
  final String name;
  final String? email;
  final String? phone;
  final String? company;
  final String source;
  final String status;
  final double dealValue;
  final String priority;
  final List<String> tags;
  final List<String> notes;
  final String? assignedTo;
  final DateTime? expectedCloseDate;
  final DateTime? createdAt;

  Lead({
    this.id,
    required this.name,
    this.email,
    this.phone,
    this.company,
    this.source = 'Manual',
    this.status = 'New',
    this.dealValue = 0,
    this.priority = 'Medium',
    this.tags = const [],
    this.notes = const [],
    this.assignedTo,
    this.expectedCloseDate,
    this.createdAt,
  });

  factory Lead.fromJson(Map<String, dynamic> json) {
    return Lead(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      company: json['company'],
      source: json['source'] ?? 'Manual',
      status: json['status'] ?? 'New',
      dealValue: (json['dealValue'] ?? 0).toDouble(),
      priority: json['priority'] ?? 'Medium',
      tags: List<String>.from(json['tags'] ?? []),
      notes: List<String>.from(json['notes'] ?? []),
      assignedTo: json['assignedTo'],
      expectedCloseDate: json['expectedCloseDate'] != null
          ? DateTime.parse(json['expectedCloseDate'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'company': company,
      'source': source,
      'status': status,
      'dealValue': dealValue,
      'priority': priority,
      'tags': tags,
      'notes': notes,
      'assignedTo': assignedTo,
      'expectedCloseDate': expectedCloseDate?.toIso8601String(),
    };
  }
}
