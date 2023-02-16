import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_notification/data/models/file_info/file_info.dart';
import 'package:local_notification/state_managers/cubit/file_download/file_download_cubit.dart';
import 'package:local_notification/utils/my_utils.dart';
import 'package:open_filex/open_filex.dart';

class SingleFileDownload extends StatefulWidget {
  final FileInfo file;

  const SingleFileDownload({required this.file, Key? key}) : super(key: key);

  @override
  State<SingleFileDownload> createState() => _SingleFileDownloadState();
}

class _SingleFileDownloadState extends State<SingleFileDownload> {
  double done = 0;
  bool isDownloaded = false;

  checkStatus() async {
    isDownloaded =
        await File("/storage/emulated/0/Download/${widget.file.fileName}")
            .exists();
    setState(() {});
  }

  @override
  void initState() {
    checkStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FileDownloadCubit(),
      child: BlocConsumer<FileDownloadCubit, FileDownloadState>(
        listener: (context, state) {
          if (state is FileDownloadInSuccessState) {
            checkStatus();
          }
        },
        builder: (context, state) => Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: ListTile(
              title: Text(widget.file.fileName),
              subtitle: LinearProgressIndicator(
                value: isDownloaded
                    ? 100
                    : state is FileDownloadInProgressState
                        ? state.progress.toDouble()
                        : 0,
                backgroundColor: Colors.grey,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.file_open),
                onPressed: () async {
                  bool isExist = await File(
                          "/storage/emulated/0/Download/${widget.file.fileName}")
                      .exists();
                  if (isExist) {
                    OpenFilex.open(
                        "/storage/emulated/0/Download/${widget.file.fileName}");
                  } else {
                    MyUtils.getMyToast(
                        message: "Fileni ochish uchun yuklab oling");
                  }
                },
              ),
              leading: IconButton(
                onPressed: () {
                  context
                      .read<FileDownloadCubit>()
                      .downloadFile(file: widget.file);
                },
                icon: isDownloaded
                    ? const Icon(
                        Icons.done,
                      )
                    : const Icon(Icons.download),
              )),
        ),
      ),
    );
  }
}
