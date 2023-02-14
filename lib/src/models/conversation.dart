import '../models/chat.dart';
import '../models/user.dart';
import 'package:flutter/material.dart';

class Contacts {
  int id,fav;
  String cid,name,e_name,address,home_address,contact,contact2,image,business,b_address;

  Contacts(this.id, this.cid,this.name, this.e_name, this.address, this.home_address,
      this.contact, this.contact2, this.image, this.business, this.b_address,this.fav);

  static Contacts fromJson(Map m)
  {
    return Contacts(m['id'], m['cid'],m['name'], m['e_name'], m['address'], m['home_address'],
        m['contact'], m['contact2'], m['image'], m['business'], m['b_address'],m['fav']);
  }

  @override
  String toString() {
    return 'Contacts{id: $id, fav: $fav, cid: $cid, name: $name, e_name: $e_name, address: $address, home_address: $home_address, contact: $contact, contact2: $contact2, image: $image, business: $business, b_address: $b_address}';
  }
}

class ConversationsList {
  List<Conversation> _conversations=[];
  User _currentUser = new User.init().getCurrentUser();

  ConversationsList() {
    this._conversations = [
      new Conversation(
          new User.basic('Kelly R. Hart', 'img/user2.jpg', UserState.available),
          [
            new Chat('Supports overlappi', '63min ago',
                new User.basic('Kelly R. Hart', 'img/user2.jpg', UserState.available)),
            new Chat('Accepts one sliver as content.', '15min ago', _currentUser),
            new Chat(
                'Header can ov', '16min ago', new User.basic('Kelly R. Hart', 'img/user2.jpg', UserState.available))
          ],
          false),
      new Conversation(
          new User.basic('Carol R. Hansen', 'img/user0.jpg', UserState.busy),
          [
            new Chat('Flutter project, add the following dependency ', '32min ago',
                new User.basic('Carol R. Hansen', 'img/user1.jpg', UserState.available)),
            new Chat('Can scroll in any direction. ', '42min ago', _currentUser),
            new Chat('Notifies when the header scrolls outside the viewport. ', '12min ago',
                new User.basic('Carol R. Hansen', 'img/user1.jpg', UserState.available))
          ],
          true),
      new Conversation(
          new User.basic('Jordan P. Jeffries', 'img/user0.jpg', UserState.away),
          [
            new Chat('For help getting started with Flutter ', '31min ago',
                new User.basic('Jordan P. Jeffries', 'img/user1.jpg', UserState.available)),
            new Chat('Supports overlapping (AppBars for example). ', '31min ago', _currentUser),
            new Chat('Accepts one sliver as content. ', '43min ago',
                new User.basic('Jordan P. Jeffries', 'img/user1.jpg', UserState.available))
          ],
          false),
      new Conversation(
          new User.basic('Michele J. Dunn', 'img/user0.jpg', UserState.available),
          [
            new Chat('Accepts one sliver as content.', '45min ago',
                new User.basic('Michele J. Dunn', 'img/user1.jpg', UserState.available)),
            new Chat('Supports overlapping (AppBars for example).', '12min ago', _currentUser),
            new Chat('Can scroll in any direction. ', '31min ago',
                new User.basic('Michele J. Dunn', 'img/user1.jpg', UserState.available))
          ],
          false),
      new Conversation(
          new User.basic('Regina R. Risner', 'img/user1.jpg', UserState.away),
          [
            new Chat('Can scroll in any direction.  ', '33min ago',
                new User.basic('Regina R. Risner', 'img/user1.jpg', UserState.available)),
            new Chat('Supports overlapping (AppBars for example). ', '33min ago', _currentUser),
            new Chat('Accepts one sliver as content. ', '33min ago',
                new User.basic('Regina R. Risner', 'img/user1.jpg', UserState.available))
          ],
          true),
    ];
  }

  List<Conversation> get conversations => _conversations;
}

class Conversation {
  var chats;

  Conversation(User user, List<Chat> list, bool bool);
}
