import 'package:flutter/material.dart';
import 'package:local_notification/data/models/file_info/file_info.dart';
import 'package:local_notification/ui/download_page/widgets/single_file_download.dart';

class FileDownloadExample extends StatefulWidget {
  const FileDownloadExample({Key? key}) : super(key: key);

  @override
  State<FileDownloadExample> createState() => _FileDownloadExampleState();
}

class _FileDownloadExampleState extends State<FileDownloadExample> {
  int doublePress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("File download"),
      ),
      body: ListView(
        children: List.generate(filesData.length, (index) {
          var singleFile = filesData[index];
          return SingleFileDownload(file: singleFile);
        }),
      ),
    );
  }
}