import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CommonUtil {
  Future<List<String>> pickfile(
      {required bool allowMultiple, required FileType fileType}) async {
    List<String> filePaths = [];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: allowMultiple,
      type: fileType,
    );
    if (result != null) {
      for (PlatformFile file in result.files) {
        filePaths.add(file.path.toString());
      }
    }
    return filePaths;
  }

  Future<String> createTempDirectory() async {
    // Get application documents directory
    final directory = await getTemporaryDirectory();

    // Generate a unique path for the output directory
    final outputDirectory =
        Directory('${directory.path}/${DateTime.now().millisecondsSinceEpoch}');
    await outputDirectory.create(recursive: true);
    return outputDirectory.path;
  }

  void showSimpleDialog(BuildContext context, description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(description),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void openLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          ),
        );
      },
    );
  }
}
