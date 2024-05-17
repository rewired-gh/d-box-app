import 'package:objectbox/objectbox.dart';

@Entity()
class EncryptedItem {
  @Id()
  int id;
  String name;
  List<int> encryptedContent;
  DateTime createdDate;
  @Index()
  bool isSign;

  @Transient()
  String? _content;

  EncryptedItem(this.id, this.name,
      {this.isSign = false, this.encryptedContent = const []})
      : createdDate = DateTime.now();
}
