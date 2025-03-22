import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import '../models/compression_config.dart';
import '../models/compression_result.dart';
import '../formats/format_handler.dart';
import '../utils/video_utils.dart';

/// Core video compression engine
class VideoCompressor {
  bool _isCancelled = false;
  Completer<void>? _cancellationCompleter;

  /// Compresses a video from a file path
  Future<CompressionResult> compressFromFile(
    String filePath, {
    required CompressionConfig config,
  }) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw FileSystemException('File not found', filePath);
    }

    final bytes = await file.readAsBytes();
    return compressFromBytes(bytes, config: config);
  }

  /// Compresses a video from bytes
  Future<CompressionResult> compressFromBytes(
    Uint8List videoBytes, {
    required CompressionConfig config,
  }) async {
    _isCancelled = false;
    _cancellationCompleter = Completer<void>();

    try {
      // Detect format and use appropriate handler
      final formatType = VideoUtils.detectFormat(videoBytes);
      final handler = FormatHandlerFactory.getHandler(formatType);

      // Extract video metadata
      final metadata = await handler.extractMetadata(videoBytes);

      // Calculate target dimensions while maintaining aspect ratio
      final (targetWidth, targetHeight) = _calculateDimensions(
        metadata.width,
        metadata.height,
        config.width,
        config.height,
      );

      // Perform the actual compression
      final compressedBytes = await handler.compress(
        videoBytes,
        config.copyWith(width: targetWidth, height: targetHeight),
        onProgress: (progress) {
          // Check for cancellation during compression
          if (_isCancelled) {
            throw Exception('Compression cancelled');
          }
        },
      );

      // Get metadata of the compressed video
      final resultMetadata = await handler.extractMetadata(compressedBytes);

      return CompressionResult(
        videoBytes: compressedBytes,
        size: compressedBytes.length,
        width: resultMetadata.width,
        height: resultMetadata.height,
        durationMs: resultMetadata.durationMs,
      );
    } catch (e) {
      if (_isCancelled) {
        // Reset cancellation state
        _isCancelled = false;
        _cancellationCompleter?.complete();
        _cancellationCompleter = null;
        throw Exception('Compression was cancelled');
      }
      rethrow;
    } finally {
      _cancellationCompleter?.complete();
      _cancellationCompleter = null;
    }
  }

  /// Cancels an ongoing compression
  Future<void> cancelCompression() async {
    if (_cancellationCompleter != null &&
        !_cancellationCompleter!.isCompleted) {
      _isCancelled = true;
      await _cancellationCompleter!.future;
    }
  }

  /// Calculates target dimensions while maintaining aspect ratio
  (int, int) _calculateDimensions(
    int originalWidth,
    int originalHeight,
    int? targetWidth,
    int? targetHeight,
  ) {
    if (targetWidth == null && targetHeight == null) {
      return (originalWidth, originalHeight);
    }

    final aspectRatio = originalWidth / originalHeight;

    if (targetWidth != null && targetHeight != null) {
      return (targetWidth, targetHeight);
    } else if (targetWidth != null) {
      final calculatedHeight = (targetWidth / aspectRatio).round();
      return (targetWidth, calculatedHeight);
    } else if (targetHeight != null) {
      final calculatedWidth = (targetHeight * aspectRatio).round();
      return (calculatedWidth, targetHeight);
    }

    return (originalWidth, originalHeight);
  }
}
