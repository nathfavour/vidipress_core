import 'dart:typed_data';

import '../models/compression_config.dart';

/// Enum for supported video formats
enum VideoFormat { mp4, webm, avi, mov, mkv, unknown }

/// Metadata for a video
class VideoMetadata {
  final int width;
  final int height;
  final int durationMs;
  final int bitrate;
  final double fps;
  final bool hasAudio;

  VideoMetadata({
    required this.width,
    required this.height,
    required this.durationMs,
    required this.bitrate,
    required this.fps,
    required this.hasAudio,
  });
}

/// Function type for compression progress callbacks
typedef ProgressCallback = void Function(double progress);

/// Abstract class for handling different video formats
abstract class FormatHandler {
  /// Compresses video bytes according to the given configuration
  Future<Uint8List> compress(
    Uint8List videoBytes,
    CompressionConfig config, {
    ProgressCallback? onProgress,
  });

  /// Extracts metadata from video bytes
  Future<VideoMetadata> extractMetadata(Uint8List videoBytes);

  /// Gets the format supported by this handler
  VideoFormat get supportedFormat;
}

/// Factory for creating appropriate format handlers
class FormatHandlerFactory {
  static FormatHandler getHandler(VideoFormat format) {
    switch (format) {
      case VideoFormat.mp4:
        return MP4FormatHandler();
      case VideoFormat.webm:
        return WebMFormatHandler();
      case VideoFormat.avi:
        return AviFormatHandler();
      case VideoFormat.mov:
        return MovFormatHandler();
      case VideoFormat.mkv:
        return MkvFormatHandler();
      default:
        throw UnsupportedError('Unsupported format: $format');
    }
  }
}

/// Handler for MP4 format
class MP4FormatHandler implements FormatHandler {
  @override
  Future<Uint8List> compress(
    Uint8List videoBytes,
    CompressionConfig config, {
    ProgressCallback? onProgress,
  }) async {
    // Implementation for MP4 compression
    // This would include parsing MP4 containers, decoding frames,
    // re-encoding with lower bitrate, etc.

    // Placeholder implementation
    return videoBytes;
  }

  @override
  Future<VideoMetadata> extractMetadata(Uint8List videoBytes) async {
    // Implementation for extracting MP4 metadata
    // Placeholder metadata
    return VideoMetadata(
      width: 1280,
      height: 720,
      durationMs: 10000,
      bitrate: 5000000,
      fps: 30.0,
      hasAudio: true,
    );
  }

  @override
  VideoFormat get supportedFormat => VideoFormat.mp4;
}

/// Handler for WebM format
class WebMFormatHandler implements FormatHandler {
  @override
  Future<Uint8List> compress(
    Uint8List videoBytes,
    CompressionConfig config, {
    ProgressCallback? onProgress,
  }) async {
    // WebM-specific implementation
    return videoBytes;
  }

  @override
  Future<VideoMetadata> extractMetadata(Uint8List videoBytes) async {
    // Implementation for extracting WebM metadata
    return VideoMetadata(
      width: 1280,
      height: 720,
      durationMs: 10000,
      bitrate: 4000000,
      fps: 30.0,
      hasAudio: true,
    );
  }

  @override
  VideoFormat get supportedFormat => VideoFormat.webm;
}

/// Handler for AVI format
class AviFormatHandler implements FormatHandler {
  @override
  Future<Uint8List> compress(
    Uint8List videoBytes,
    CompressionConfig config, {
    ProgressCallback? onProgress,
  }) async {
    // AVI-specific implementation
    return videoBytes;
  }

  @override
  Future<VideoMetadata> extractMetadata(Uint8List videoBytes) async {
    // Implementation for extracting AVI metadata
    return VideoMetadata(
      width: 1280,
      height: 720,
      durationMs: 10000,
      bitrate: 6000000,
      fps: 30.0,
      hasAudio: true,
    );
  }

  @override
  VideoFormat get supportedFormat => VideoFormat.avi;
}

/// Handler for MOV format
class MovFormatHandler implements FormatHandler {
  @override
  Future<Uint8List> compress(
    Uint8List videoBytes,
    CompressionConfig config, {
    ProgressCallback? onProgress,
  }) async {
    // MOV-specific implementation
    return videoBytes;
  }

  @override
  Future<VideoMetadata> extractMetadata(Uint8List videoBytes) async {
    // Implementation for extracting MOV metadata
    return VideoMetadata(
      width: 1280,
      height: 720,
      durationMs: 10000,
      bitrate: 6000000,
      fps: 30.0,
      hasAudio: true,
    );
  }

  @override
  VideoFormat get supportedFormat => VideoFormat.mov;
}

/// Handler for MKV format
class MkvFormatHandler implements FormatHandler {
  @override
  Future<Uint8List> compress(
    Uint8List videoBytes,
    CompressionConfig config, {
    ProgressCallback? onProgress,
  }) async {
    // MKV-specific implementation
    return videoBytes;
  }

  @override
  Future<VideoMetadata> extractMetadata(Uint8List videoBytes) async {
    // Implementation for extracting MKV metadata
    return VideoMetadata(
      width: 1280,
      height: 720,
      durationMs: 10000,
      bitrate: 5500000,
      fps: 30.0,
      hasAudio: true,
    );
  }

  @override
  VideoFormat get supportedFormat => VideoFormat.mkv;
}
