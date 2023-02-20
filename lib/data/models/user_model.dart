

class Invoice {
  final  String? id;
  final  String name; //!  Invoice Name and user name is the same 
  final  String total;
  final  String imageUrl;
  final  String notes;
  final  bool isDelivered;
  final  DateTime date;

  Invoice({
    this.id,
    required this.name,
    required this.total,
    required this.imageUrl,
    required this.notes,
    required this.isDelivered,
    required this.date,
  });


  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'total': total,
      'imageUrl':imageUrl,
      'notes':notes,
      'isDelivered':isDelivered,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory Invoice.fromJson(Map<String, dynamic> map) {
    return Invoice(
      id: map['id'] as String,
      name: map['name'] as String,
      total: map['total'] as String,
      imageUrl: map['imageUrl'],
      notes: map['notes'],
      isDelivered: map['isDelivered'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }


}
