import 'package:equatable/equatable.dart';

class FileManagerState extends Equatable {
  FileManagerState({
    required this.stop,
    required this.progress,
    required this.newFileLocation,
  });

  final double progress;
  final bool stop;
  final String newFileLocation;

  FileManagerState copyWith({
    double? progress,
    bool? stop,
    String? newFileLocation,
  }) =>
      FileManagerState(
        stop: stop ?? this.stop,
        progress: progress ?? this.progress,
        newFileLocation: newFileLocation ?? this.newFileLocation,
      );

  @override
  List<Object?> get props => [
        progress,
        newFileLocation,
        stop,
      ];
}
