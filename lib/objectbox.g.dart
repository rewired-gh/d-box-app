// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'src/feature/settings/settings.dart';
import 'src/feature/vault/encrypted_item.dart';
import 'src/feature/vault/encrypted_item_meta.dart';
import 'src/feature/vault/vault_meta.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(2, 2811790242535780380),
      name: 'EncryptedItem',
      lastPropertyId: const obx_int.IdUid(7, 1440981706524082140),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 1667789569363794415),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 1083267998135076987),
            name: 'encryptedContent',
            type: 27,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 5281970659423513972),
            name: 'isSign',
            type: 1,
            flags: 8,
            indexId: const obx_int.IdUid(1, 7020919019952261138)),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 6390993636789534268),
            name: 'nonce',
            type: 27,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 1440981706524082140),
            name: 'mac',
            type: 27,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(3, 7985173069716592202),
      name: 'VaultMeta',
      lastPropertyId: const obx_int.IdUid(3, 38301328992577273),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 8794863291609998961),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 518839861268649420),
            name: 'masterNonce',
            type: 27,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 38301328992577273),
            name: 'dummy',
            type: 1,
            flags: 40,
            indexId: const obx_int.IdUid(2, 3857211504309017756))
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(4, 261786158343403634),
      name: 'EncryptedItemMeta',
      lastPropertyId: const obx_int.IdUid(4, 6640044150253322459),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 6271321024803391489),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 7649744335304468847),
            name: 'itemId',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 4542377351237412631),
            name: 'name',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 6640044150253322459),
            name: 'createdDate',
            type: 10,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(7, 8778369122718267783),
      name: 'Settings',
      lastPropertyId: const obx_int.IdUid(4, 5205417004198208569),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 5939039926573377667),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 2654857890752841778),
            name: 'dummy',
            type: 1,
            flags: 40,
            indexId: const obx_int.IdUid(5, 7829220152330982644)),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 5835455665605891455),
            name: 'languageCode',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 5205417004198208569),
            name: 'regionCode',
            type: 9,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(getObjectBoxModel(),
      directory: directory ?? (await defaultStoreDirectory()).path,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(7, 8778369122718267783),
      lastIndexId: const obx_int.IdUid(5, 7829220152330982644),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [
        8976722826320732793,
        4588634890854115557,
        6950302300419816828
      ],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        1205461486277506787,
        4659956656874863191,
        4140598850104626552,
        4085211508820151623,
        2185063763467598746,
        2952770497306688716,
        7313188264748893939,
        6435064475561415452,
        2354525084317388253,
        6457978573625324725,
        3402087818918753114,
        2477705914021042364,
        6998094141879085562
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    EncryptedItem: obx_int.EntityDefinition<EncryptedItem>(
        model: _entities[0],
        toOneRelations: (EncryptedItem object) => [],
        toManyRelations: (EncryptedItem object) => {},
        getId: (EncryptedItem object) => object.id,
        setId: (EncryptedItem object, int id) {
          object.id = id;
        },
        objectToFB: (EncryptedItem object, fb.Builder fbb) {
          final encryptedContentOffset = object.encryptedContent == null
              ? null
              : fbb.writeListInt64(object.encryptedContent!);
          final nonceOffset =
              object.nonce == null ? null : fbb.writeListInt64(object.nonce!);
          final macOffset =
              object.mac == null ? null : fbb.writeListInt64(object.mac!);
          fbb.startTable(8);
          fbb.addInt64(0, object.id);
          fbb.addOffset(2, encryptedContentOffset);
          fbb.addBool(4, object.isSign);
          fbb.addOffset(5, nonceOffset);
          fbb.addOffset(6, macOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final isSignParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 12, false);
          final object = EncryptedItem(id: idParam, isSign: isSignParam)
            ..encryptedContent =
                const fb.ListReader<int>(fb.Int64Reader(), lazy: false)
                    .vTableGetNullable(buffer, rootOffset, 8)
            ..nonce = const fb.ListReader<int>(fb.Int64Reader(), lazy: false)
                .vTableGetNullable(buffer, rootOffset, 14)
            ..mac = const fb.ListReader<int>(fb.Int64Reader(), lazy: false)
                .vTableGetNullable(buffer, rootOffset, 16);

          return object;
        }),
    VaultMeta: obx_int.EntityDefinition<VaultMeta>(
        model: _entities[1],
        toOneRelations: (VaultMeta object) => [],
        toManyRelations: (VaultMeta object) => {},
        getId: (VaultMeta object) => object.id,
        setId: (VaultMeta object, int id) {
          object.id = id;
        },
        objectToFB: (VaultMeta object, fb.Builder fbb) {
          final masterNonceOffset = fbb.writeListInt64(object.masterNonce);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, masterNonceOffset);
          fbb.addBool(2, object.dummy);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = VaultMeta()
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0)
            ..masterNonce =
                const fb.ListReader<int>(fb.Int64Reader(), lazy: false)
                    .vTableGet(buffer, rootOffset, 6, [])
            ..dummy =
                const fb.BoolReader().vTableGet(buffer, rootOffset, 8, false);

          return object;
        }),
    EncryptedItemMeta: obx_int.EntityDefinition<EncryptedItemMeta>(
        model: _entities[2],
        toOneRelations: (EncryptedItemMeta object) => [],
        toManyRelations: (EncryptedItemMeta object) => {},
        getId: (EncryptedItemMeta object) => object.id,
        setId: (EncryptedItemMeta object, int id) {
          object.id = id;
        },
        objectToFB: (EncryptedItemMeta object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.itemId);
          fbb.addOffset(2, nameOffset);
          fbb.addInt64(3, object.createdDate.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final itemIdParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          final nameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final object = EncryptedItemMeta(
              id: idParam, itemId: itemIdParam, name: nameParam)
            ..createdDate = DateTime.fromMillisecondsSinceEpoch(
                const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0));

          return object;
        }),
    Settings: obx_int.EntityDefinition<Settings>(
        model: _entities[3],
        toOneRelations: (Settings object) => [],
        toManyRelations: (Settings object) => {},
        getId: (Settings object) => object.id,
        setId: (Settings object, int id) {
          object.id = id;
        },
        objectToFB: (Settings object, fb.Builder fbb) {
          final languageCodeOffset = object.languageCode == null
              ? null
              : fbb.writeString(object.languageCode!);
          final regionCodeOffset = object.regionCode == null
              ? null
              : fbb.writeString(object.regionCode!);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addBool(1, object.dummy);
          fbb.addOffset(2, languageCodeOffset);
          fbb.addOffset(3, regionCodeOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final languageCodeParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8);
          final regionCodeParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 10);
          final object = Settings(
              languageCode: languageCodeParam, regionCode: regionCodeParam)
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0)
            ..dummy =
                const fb.BoolReader().vTableGet(buffer, rootOffset, 6, false);

          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [EncryptedItem] entity fields to define ObjectBox queries.
class EncryptedItem_ {
  /// See [EncryptedItem.id].
  static final id =
      obx.QueryIntegerProperty<EncryptedItem>(_entities[0].properties[0]);

  /// See [EncryptedItem.encryptedContent].
  static final encryptedContent =
      obx.QueryIntegerVectorProperty<EncryptedItem>(_entities[0].properties[1]);

  /// See [EncryptedItem.isSign].
  static final isSign =
      obx.QueryBooleanProperty<EncryptedItem>(_entities[0].properties[2]);

  /// See [EncryptedItem.nonce].
  static final nonce =
      obx.QueryIntegerVectorProperty<EncryptedItem>(_entities[0].properties[3]);

  /// See [EncryptedItem.mac].
  static final mac =
      obx.QueryIntegerVectorProperty<EncryptedItem>(_entities[0].properties[4]);
}

/// [VaultMeta] entity fields to define ObjectBox queries.
class VaultMeta_ {
  /// See [VaultMeta.id].
  static final id =
      obx.QueryIntegerProperty<VaultMeta>(_entities[1].properties[0]);

  /// See [VaultMeta.masterNonce].
  static final masterNonce =
      obx.QueryIntegerVectorProperty<VaultMeta>(_entities[1].properties[1]);

  /// See [VaultMeta.dummy].
  static final dummy =
      obx.QueryBooleanProperty<VaultMeta>(_entities[1].properties[2]);
}

/// [EncryptedItemMeta] entity fields to define ObjectBox queries.
class EncryptedItemMeta_ {
  /// See [EncryptedItemMeta.id].
  static final id =
      obx.QueryIntegerProperty<EncryptedItemMeta>(_entities[2].properties[0]);

  /// See [EncryptedItemMeta.itemId].
  static final itemId =
      obx.QueryIntegerProperty<EncryptedItemMeta>(_entities[2].properties[1]);

  /// See [EncryptedItemMeta.name].
  static final name =
      obx.QueryStringProperty<EncryptedItemMeta>(_entities[2].properties[2]);

  /// See [EncryptedItemMeta.createdDate].
  static final createdDate =
      obx.QueryDateProperty<EncryptedItemMeta>(_entities[2].properties[3]);
}

/// [Settings] entity fields to define ObjectBox queries.
class Settings_ {
  /// See [Settings.id].
  static final id =
      obx.QueryIntegerProperty<Settings>(_entities[3].properties[0]);

  /// See [Settings.dummy].
  static final dummy =
      obx.QueryBooleanProperty<Settings>(_entities[3].properties[1]);

  /// See [Settings.languageCode].
  static final languageCode =
      obx.QueryStringProperty<Settings>(_entities[3].properties[2]);

  /// See [Settings.regionCode].
  static final regionCode =
      obx.QueryStringProperty<Settings>(_entities[3].properties[3]);
}
