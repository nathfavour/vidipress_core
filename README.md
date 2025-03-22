# VidiPress Core

A standalone Flutter/Dart package for video compression without external dependencies.

## Features

VidiPress Core provides a pure Dart implementation for video compression, serving as an alternative to FFmpeg for Flutter applications:

- Compress videos from files or byte arrays
- Customizable compression parameters (resolution, bitrate, quality)
- Support for multiple video formats (MP4, WebM, AVI, MOV, MKV)
- Fine-grained control over compression process
- Progress tracking and cancellation capabilities
- No external dependencies or native code required

## Getting started

To use this package, add `vidipress_core` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  vidipress_core: ^1.0.0
```

## Usage

Basic usage to compress a video file:

```dart
import 'package:vidipress_core/vidipress_core.dart';

Future<void> compressVideo() async {
  // Get an instance of VidiPress
  final vidipress = VidiPress();
  
  // Create a compression configuration
  final config = CompressionConfig(
    width: 1280,
    height: 720,
    quality: 80,
    includeAudio: true,
  );
  
  // Compress a video file
  final result = await vidipress.compressFile(
    '/path/to/video.mp4',
    config: config,
  );
  
  print('Compressed video size: ${result.size} bytes');
  print('Resolution: ${result.width}x${result.height}');
  print('Duration: ${result.durationMs}ms');
  
  // Use the compressed video bytes
  final compressedBytes = result.videoBytes;
  
  // You can save these bytes to a file
  // final file = File('/path/to/output.mp4');
  // await file.writeAsBytes(compressedBytes);
}
```

Advanced usage with custom parameters:

```dart
// Compress with target bitrate
final config = CompressionConfig(
  bitrate: 1500000, // 1.5 Mbps
  fps: 24,
  outputFormat: 'webm',
);

// Compress from bytes
final videoBytes = await File('/path/to/video.mp4').readAsBytes();
final result = await vidipress.compressBytes(
  videoBytes,
  config: config,
);

// Cancel an in-progress compression
vidipress.cancelCompression();
```

## How it works

VidiPress Core implements video compression algorithms in pure Dart:

1. It parses video containers (MP4, WebM, etc.) to extract video frames
2. Decompresses frames to raw image data
3. Applies compression techniques (resolution scaling, frame rate adjustment, etc.)
4. Re-encodes using optimized algorithms tailored for each format
5. Reassembles the video container with the new compressed data

## Performance considerations

As a pure Dart implementation, VidiPress Core prioritizes compatibility over maximum performance. For extremely large videos or performance-critical applications, consider:

- Using smaller segments of video for better memory usage
- Adjusting the quality settings to balance size and processing time
- Setting appropriate resolution limits based on target device capabilities

## Additional information

- Bug reports and feature requests: [GitHub Issues](https://github.com/nathfavour/vidipress_core/issues)
- Contributions: Pull requests are welcome
- More examples: See the `/example` folder in the repository
