import 'package:objectbox/objectbox.dart';

@Entity()
class EncryptedItemMeta {
  @Id()
  int id;
  int itemId;
  String name;
  DateTime createdDate;

  EncryptedItemMeta({this.id = 0, required this.itemId, this.name = ""})
      : createdDate = DateTime.now();
}
