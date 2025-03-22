import 'dart:async';
import 'dart:typed_data';

import 'compressor/video_compressor.dart';
import 'models/compression_config.dart';
import 'models/compression_result.dart';

// TODO: Put public facing types in this file.

/// Checks if you are awesome. Spoiler: you are.
class Awesome {
  bool get isAwesome => true;
}

/// Main class for VidiPress Core functionality
class VidiPress {
  /// Singleton instance
  static final VidiPress _instance = VidiPress._internal();

  /// Factory constructor to return the singleton instance
  factory VidiPress() => _instance;

  /// Internal constructor
  VidiPress._internal();

  /// Compresses a video file from a file path
  ///
  /// Returns a [CompressionResult] with the compressed video data and metadata
  Future<CompressionResult> compressFile(
    String filePath, {
    CompressionConfig? config,
  }) async {
    final compressor = VideoCompressor();
    return compressor.compressFromFile(
      filePath,
      config: config ?? CompressionConfig(),
    );
  }

  /// Compresses a video from bytes
  ///
  /// Returns a [CompressionResult] with the compressed video data and metadata
  Future<CompressionResult> compressBytes(
    Uint8List videoBytes, {
    CompressionConfig? config,
  }) async {
    final compressor = VideoCompressor();
    return compressor.compressFromBytes(
      videoBytes,
      config: config ?? CompressionConfig(),
    );
  }

  /// Cancels any ongoing compression
  void cancelCompression() {
    VideoCompressor().cancelCompression();
  }
}
