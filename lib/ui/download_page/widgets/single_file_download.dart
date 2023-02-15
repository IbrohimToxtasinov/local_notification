import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_notification/data/models/file_info/file_info.dart';
import 'package:local_notification/state_managers/cubit/file_download/file_download_cubit.dart';
import 'package:local_notification/state_managers/cubit/file_download/file_download_state.dart';
import 'package:local_notification/utils/my_utils.dart';
import 'package:open_file_safe/open_file_safe.dart';

import '../../../data/services/local_notification/local_notification_service.dart';

class SingleFileDownload extends StatelessWidget {
  SingleFileDownload({Key? key, required this.fileInfo}) : super(key: key);

  final FileInfo fileInfo;
  FileManagerCubit fileManagerCubit = FileManagerCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: fileManagerCubit,
      child: BlocBuilder<FileManagerCubit, FileManagerState>(
        builder: (context, state) {
          return ListTile(
            leading: state.newFileLocation.isEmpty
                ? IconButton(
                onPressed: () {
                  if(state.progress == 0.0 ) {
                    context
                        .read<FileManagerCubit>()
                        .downloadIfExists(fileInfo: fileInfo);
                  }else if(state.progress > 0.0) {
                    context
                        .read<FileManagerCubit>()
                        .stopped(stopped: false);
                  }
                },
                icon: const Icon(Icons.download, color: Colors.white,))
                : const Icon(Icons.download_done,color: Colors.white),
            title: Text("${fileInfo.fileName}: ${state.progress * 100}%", style: TextStyle(color: Colors.white,),),
            subtitle: LinearProgressIndicator(
              value: state.progress,
              backgroundColor: Colors.white,
            ),
            trailing: IconButton(
              onPressed: () {
                if (state.newFileLocation.isNotEmpty) {
                  OpenFile.open(state.newFileLocation);
                }else if(state.progress < 100){
                  context
                      .read<FileManagerCubit>()
                      .downloadIfExists(fileInfo: fileInfo);
                  LocalNotificationService.localNotificationService
                      .showNotification(id: 5);
                }
              },
              icon: const Icon(Icons.file_open, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
