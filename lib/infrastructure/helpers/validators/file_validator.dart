import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileValidator extends StatefulWidget {
  const FileValidator({super.key});

  @override
  State<FileValidator> createState() => _FileValidatorState();
}

class _FileValidatorState extends State<FileValidator> {
  String? _filePath;
  String? _fileError;

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg'],
    );

    if (result != null) {
      setState(() {
        _filePath = result.files.single.path;
        _fileError = null;
      });
    } else {
      setState(() {
        _fileError = 'No file selected or invalid file format';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Format Validation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_filePath != null) Text('Selected file: $_filePath'),
            if (_fileError != null)
              Text('Error: $_fileError',
                  style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: _pickFile,
              child: const Text('Pick File'),
            ),
          ],
        ),
      ),
    );
  }
}