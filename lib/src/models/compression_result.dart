import 'dart:typed_data';

/// Result of a video compression operation
class CompressionResult {
  /// Compressed video as bytes
  final Uint8List videoBytes;

  /// Size of the compressed video in bytes
  final int size;

  /// Width of the compressed video
  final int width;

  /// Height of the compressed video
  final int height;

  /// Duration of the video in milliseconds
  final int durationMs;

  /// Path to the output file if saved to disk, null otherwise
  final String? path;

  /// Constructor
  CompressionResult({
    required this.videoBytes,
    required this.size,
    required this.width,
    required this.height,
    required this.durationMs,
    this.path,
  });

  /// Compression ratio compared to original size
  double getCompressionRatio(int originalSizeInBytes) {
    if (originalSizeInBytes <= 0) return 0;
    return 1 - (size / originalSizeInBytes);
  }
}
