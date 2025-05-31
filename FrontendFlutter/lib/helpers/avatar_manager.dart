import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/constants/api_constants.dart';

Future<String?> getAvatarPath(int userId) async {
  try {
    final dir = await getApplicationDocumentsDirectory();
    final avatarDir = Directory(join(dir.path, 'avatars'));
    print('Checking if avatar dir exists');
    if (!await avatarDir.exists()) {
      await avatarDir.create(recursive: true);
    }
    print('Checked or created avatar dir');
    final filePath = join(avatarDir.path, '$userId.jpg');
    final avatarFile = File(filePath);
    print('Checking local avatar for user $userId');
    if (await avatarFile.exists()) {
      return filePath;
    }

    // Try to fetch from the server
    final url = Uri.parse('$baseUrl/getavatar/$userId');
    print('Fetching avatar for user $userId from server...');
    final response = await http.get(url).timeout(Duration(seconds: 30));
    print('Request made');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      final avatarRaw = data['avatar'];

      Uint8List bytes;
      if (avatarRaw is String) {
        // It's a base64 string
        bytes = base64Decode(avatarRaw);
      } else if (avatarRaw is List) {
        // It's a JSON-encoded list of ints
        bytes = Uint8List.fromList(List<int>.from(avatarRaw));
      } else {
        throw FormatException("Unsupported avatar format");
      }

      await avatarFile.writeAsBytes(bytes);
      return filePath;
    } else {
      print("Failed to download avatar. Status code: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("Error while fetching avatar: $e");
    return null;
  }
}

ImageProvider getAvatar(String? avatarPath) {
  if (avatarPath != null && File(avatarPath).existsSync()) {
    return FileImage(File(avatarPath));
  } else {
    return AssetImage('assets/avatar.gif');
  }
}
