part of 'file_download_cubit.dart';

@immutable
abstract class FileDownloadState {}

class FileDownloadInitial extends FileDownloadState {}

class FileDownloadInProgressState extends FileDownloadState{
  num progress;
  FileDownloadInProgressState({required this.progress});
}
class FileDownloadInSuccessState extends FileDownloadState{}