/// Configuration options for video compression
class CompressionConfig {
  /// Target width of the compressed video
  final int? width;

  /// Target height of the compressed video
  final int? height;

  /// Target bitrate in bits per second
  final int? bitrate;

  /// Frame rate of the compressed video
  final double? fps;

  /// Whether to include audio in the compressed output
  final bool includeAudio;

  /// Quality value from 0 (lowest) to 100 (highest)
  final int quality;

  /// Output format (e.g., 'mp4', 'webm')
  final String outputFormat;

  /// Constructor
  CompressionConfig({
    this.width,
    this.height,
    this.bitrate,
    this.fps,
    this.includeAudio = true,
    this.quality = 70,
    this.outputFormat = 'mp4',
  });

  /// Create a copy of this config with some parameters replaced
  CompressionConfig copyWith({
    int? width,
    int? height,
    int? bitrate,
    double? fps,
    bool? includeAudio,
    int? quality,
    String? outputFormat,
  }) {
    return CompressionConfig(
      width: width ?? this.width,
      height: height ?? this.height,
      bitrate: bitrate ?? this.bitrate,
      fps: fps ?? this.fps,
      includeAudio: includeAudio ?? this.includeAudio,
      quality: quality ?? this.quality,
      outputFormat: outputFormat ?? this.outputFormat,
    );
  }
}
