import 'package:hive/hive.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/persistence/persistence_constants.dart';
import 'package:collection/collection.dart';

part 'shelf_vo.g.dart';

@HiveType(typeId: HIVE_TYPE_ID_SHELF_VO, adapterName: "ShelfVOAdapter")
class ShelfVO {

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<BookVO> books;

  @HiveField(3)
  DateTime createdAt;

  ShelfVO(this.id, this.name, this.books, this.createdAt);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShelfVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          const ListEquality().equals(books, other.books);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ books.hashCode;

  @override
  String toString() {
    return 'ShelfVO{id: $id, name: $name, books: ${books.length}}';
  }
}