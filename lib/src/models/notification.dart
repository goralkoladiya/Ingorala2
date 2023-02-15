class Notification {
  String id;
  String notes;
  String date;
  String status;

  Notification(this.id, this.notes, this.date, this.status);

  static Notification fromJson(Map m)
  {
    return Notification(m['id'], m['notes'], m['date'], m['status']);
  }

  @override
  String toString() {
    return 'Notification{id: $id, notes: $notes, date: $date, status: $status}';
  }
}
