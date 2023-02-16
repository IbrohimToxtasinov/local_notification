import 'dart:io';
import 'dart:isolate';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:local_notification/data/models/file_info/file_info.dart';
import 'package:local_notification/state_managers/cubit/get_notification/get_notification_cubit.dart';
import 'package:local_notification/utils/locator.dart';
import 'package:meta/meta.dart';

part 'file_download_state.dart';

class FileDownloadCubit extends Cubit<FileDownloadState> {
  FileDownloadCubit() : super(FileDownloadInitial());

  var downloadedImagePath = '/storage/emulated/0/Download/';

  void downloadFile({required FileInfo file})  async {
    await Isolate.run(await _fileDownloader(file: file));
    Isolate.exit();
  }

  _fileDownloader({required FileInfo file}) async {
    Dio dio = appLocator<Dio>();
    try {
      bool isExist = await File("$downloadedImagePath${file.fileName}").exists();
      if(!isExist){
        appLocator<NotificationCubit>().sendNotification(id: 1, isFinished: false);
        await dio.download(
          file.fileUrl,
          "$downloadedImagePath${file.fileName}",
          onReceiveProgress: (rec, total) async{
            num progress=rec/total;
            emitProgress(progress);
            if(rec == total){
              appLocator<NotificationCubit>().sendNotification(id: 1,isFinished: true);
              emit(FileDownloadInSuccessState());
            }
          },
        );
      }
      else{
      }
    } catch (e) {}
    emit(FileDownloadInSuccessState());
  }


  emitProgress(num progress){
    emit(FileDownloadInProgressState(progress: progress));
  }
}