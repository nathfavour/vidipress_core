import 'dart:typed_data';

import '../formats/format_handler.dart';

/// Utility class for video processing
class VideoUtils {
  /// Detects the format of a video from its bytes
  static VideoFormat detectFormat(Uint8List bytes) {
    if (bytes.length < 16) {
      return VideoFormat.unknown;
    }

    // Check for MP4 format (ftyp box)
    if (bytes.length > 12 &&
        bytes[4] == 0x66 &&
        bytes[5] == 0x74 &&
        bytes[6] == 0x79 &&
        bytes[7] == 0x70) {
      return VideoFormat.mp4;
    }

    // Check for WebM format (EBML header)
    if (bytes.length > 4 &&
        bytes[0] == 0x1A &&
        bytes[1] == 0x45 &&
        bytes[2] == 0xDF &&
        bytes[3] == 0xA3) {
      return VideoFormat.webm;
    }

    // Check for AVI format (RIFF header)
    if (bytes.length > 12 &&
        bytes[0] == 0x52 &&
        bytes[1] == 0x49 &&
        bytes[2] == 0x46 &&
        bytes[3] == 0x46 &&
        bytes[8] == 0x41 &&
        bytes[9] == 0x56 &&
        bytes[10] == 0x49 &&
        bytes[11] == 0x20) {
      return VideoFormat.avi;
    }

    // Check for MOV format (ftyp box with qt)
    if (bytes.length > 12 &&
        bytes[4] == 0x66 &&
        bytes[5] == 0x74 &&
        bytes[6] == 0x79 &&
        bytes[7] == 0x70 &&
        bytes[8] == 0x71 &&
        bytes[9] == 0x74) {
      return VideoFormat.mov;
    }

    // MKV format detection would be similar to WebM as it also uses EBML

    return VideoFormat.unknown;
  }

  /// Calculates the estimated bitrate for a target file size
  static int calculateBitrateForTargetSize({
    required int targetSizeBytes,
    required int durationSeconds,
    required bool includeAudio,
    int audioBitrate = 128000, // Default audio bitrate (128 kbps)
  }) {
    // Convert target size to bits (1 byte = 8 bits)
    final targetSizeBits = targetSizeBytes * 8;

    // Account for container overhead (approximately 2%)
    final availableBits = targetSizeBits * 0.98;

    // Subtract audio bits if audio is included
    final availableForVideo =
        includeAudio
            ? availableBits - (audioBitrate * durationSeconds)
            : availableBits;

    // Calculate video bitrate (bits per second)
    final videoBitrate = availableForVideo / durationSeconds;

    // Ensure a minimum bitrate
    return videoBitrate.round().clamp(100000, 100000000);
  }

  /// Estimates the quality level (1-100) based on resolution and bitrate
  static int estimateQualityLevel(int width, int height, int bitrate) {
    // Calculate pixels
    final pixels = width * height;

    // Calculate bits per pixel (bpp)
    final bppx30 = (bitrate / pixels / 30);

    // Map bpp to quality level (values based on general video encoding guidelines)
    if (bppx30 > 0.3) return 100;
    if (bppx30 > 0.2) return 90;
    if (bppx30 > 0.15) return 80;
    if (bppx30 > 0.1) return 70;
    if (bppx30 > 0.08) return 60;
    if (bppx30 > 0.06) return 50;
    if (bppx30 > 0.04) return 40;
    if (bppx30 > 0.02) return 30;
    if (bppx30 > 0.01) return 20;
    return 10;
  }
}
