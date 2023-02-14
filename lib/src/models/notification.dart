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

class NotificationList {
  List<Notification> _notifications=[];

  NotificationList() {
    this._notifications = [
      new Notification('img/chicagoTavel.jpg', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
          '33min ago', "false"),
      new Notification(
          'img/elu.png', 'It is a long established fact that a reader will be distracted', '32min ago', "true"),
      new Notification(
          'img/sport1.jpg', 'There are many variations of passages of Lorem Ipsum available', '34min ago', "true"),
      new Notification(
          'img/hilton.webp', 'Contrary to popular belief, Lorem Ipsum is not simply random text', '52min ago', "true"),
      new Notification(
          'img/car3.jpg', 'Contrary to popular belief, Lorem Ipsum is not simply random text', '1 day ago', "false"),
    ];
  }

  List<Notification> get notifications => _notifications;
}
