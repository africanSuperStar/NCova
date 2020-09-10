import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../../features/status/data/models/models.dart';

/// Loads and saves a List of Favorite Country Statuses using a text file stored on the device.
///
/// Note: This class has no direct dependencies on any Flutter dependencies.
/// Instead, the `getDirectory` method should be injected. This allows for
/// testing.
class FileStorage {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const FileStorage(
    this.tag,
    this.getDirectory,
  );

  Future<List<Status>> loadFavorites() async {
    final file = await _getLocalFile();
    String string;
    try {
      string = await file.readAsString();
      final favorites = string..replaceAll(RegExp('s\^'), '');
      final statuses = json.decode(favorites).map<Status>((favorite) => Status.fromJson(favorite)).toList();
      return Future.value(statuses);
    } catch (_) {
      return Future.value(<Status>[]);
    }
  }

  Future<File> saveFavorites(List<Status> favorites) async {
    final file = await _getLocalFile();

    return file.writeAsString(
      JsonEncoder().convert(
        favorites.map((favorite) => favorite.toJson().toString()).toList(),
      ),
    );
  }

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();

    return File('${dir.path}/ArchSampleStorage__$tag.json');
  }

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();

    return file.delete();
  }
}
