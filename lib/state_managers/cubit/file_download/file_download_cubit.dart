import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_notification/data/models/file_info/file_info.dart';
import 'package:local_notification/utils/my_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'file_download_state.dart';

class FileManagerCubit extends Cubit<FileManagerState> {
  FileManagerCubit()
      : super(
    FileManagerState(
      stop: true,
      progress: 0.0,
      newFileLocation: "",
    ),
  );

  void stopped({required bool stopped, stop}) async {
    stop == stopped;
  }

//   void downloadIfExists({
//     required FileInfo fileInfo, stop,
//   }) async {
//     bool hasPermission = await _requestWritePermission();
//     if (!hasPermission) return;
//     if (stop == false) {
//       MyUtils.getMyToast(message: "Yuklash jarayoni tugadi");
//     } else {
//       Dio dio = Dio();
//       var directory = await getDownloadPath();
//       debugPrint("Path: ${directory?.path}");
//       String url = fileInfo.fileUrl;
//       String newFileLocation =
//           "${directory?.path}/${fileInfo.fileName}${DateTime
//           .now()
//           .microsecond}${url.substring(url.length - 5, url.length)}";
//       try {
//         await dio.download(url, newFileLocation,
//             onReceiveProgress: (received, total) {
//               var pr = received / total;
//               print(pr);
//               emit(state.copyWith(progress: pr));
//             });
//         emit(state.copyWith(newFileLocation: newFileLocation));
//       } catch (error) {
//         debugPrint("Download Error:$error");
//       }
//     }
//   }
// }

// void downloadFile({
//   required String fileName,
//   required String url,
// }) async {
//   //Permission get
//   bool hasPermission = await _requestWritePermission();
//   if (!hasPermission) return;
//   Dio dio = Dio();
//
//   // Userga ko'rinadigan path
//   var directory = await getDownloadPath();
//   String newFileLocation =
//       "${directory?.path}/$fileName${url.substring(
//       url.length - 5, url.length)}";
//   var allFiles = directory?.list();
//
//   print("NEW FILE:$newFileLocation");
//
//   List<String> filePaths = [];
//   await allFiles?.forEach((element) {
//     print("FILES IN DOWNLOAD FOLDER:${element.path}");
//     filePaths.add(element.path.toString());
//   });
//
//   if (filePaths.contains(newFileLocation)) {
//     OpenFile.open(newFileLocation);
//   } else {
//     try {
//       await dio.download(url, newFileLocation,
//           onReceiveProgress: (received, total) {
//             double pr = received / total;
//             emit(state.copyWith(progress: pr));
//           });
//       OpenFile.open(newFileLocation);
//     } catch (error) {
//       debugPrint("DOWNLOAD ERROR:$error");
//     }
//   }
// }

void downloadIfExists({
  required FileInfo fileInfo,
}) async {
  bool hasPermission = await _requestWritePermission();
  if (!hasPermission) return;
  Dio dio = Dio();
  var directory = await getDownloadPath();
  if(directory==null){
    return ;
  }
  print("PATH :${directory.path}");
  String url = fileInfo.fileUrl;
  String newFileLocation =
      "${directory.path}${fileInfo.fileName}${DateTime.now().millisecond}${url.substring(url.length - 5, url.length)}";
  print("New Location : $newFileLocation");
  try {
    await dio.download(url, newFileLocation,
        onReceiveProgress: (received, total) {
          var pr = received / total;
          print(pr);
          emit(state.copyWith(progress: pr));
        });
    emit(state.copyWith(newFileLocation: newFileLocation));
  } catch (error) {
    debugPrint("DOWNLOAD ERROR:$error");
  }
}

Future<bool> _requestWritePermission() async {
  bool temp = await Permission.storage
      .request()
      .isGranted;
  if(temp) {
    return true;
  } else{
    await Permission.storage.request();
  }
  return false;

}

Future<Directory?> getDownloadPath() async {
  Directory? directory;
  try {
    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = Directory('/storage/emulated/0/Download/');
      if (!await directory.exists()) {
        directory = await getExternalStorageDirectory();
      }
    }
  } catch (err) {
    debugPrint("Cannot get download folder path");
  }
  return directory;
}}