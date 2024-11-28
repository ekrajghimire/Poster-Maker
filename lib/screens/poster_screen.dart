import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:poster_maker/widgets/background_image.dart';
import 'package:poster_maker/widgets/text_overlay.dart';
import 'dart:ui' as ui;
import 'package:universal_html/html.dart' as html;

class PosterScreen extends StatefulWidget {
  const PosterScreen({super.key});

  @override
  _PosterScreenState createState() => _PosterScreenState();
}

class _PosterScreenState extends State<PosterScreen> {
  final GlobalKey _posterKey = GlobalKey();
  String _currentText = 'Your Text Here';

  Future<void> _downloadPoster() async {
    try {
      // Ensure the UI is fully rendered
      await Future.delayed(const Duration(milliseconds: 300));

      // Capture the image
      final image = await _captureImage();
      if (image == null) {
        _showErrorMessage('Could not capture the poster');
        return;
      }

      // Download the image
      _saveImage(image);
      _showSuccessMessage('Poster downloaded successfully');
    } catch (e) {
      _showErrorMessage('Failed to download poster: ${e.toString()}');
    }
  }

  Future<Uint8List?> _captureImage() async {
    // Find the RenderRepaintBoundary for the poster
    final RenderRepaintBoundary? boundary =
        _posterKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    if (boundary == null) return null;

    // Capture the image with high resolution
    final ui.Image image = await boundary.toImage(pixelRatio: 4.0);

    // Convert to byte data
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData?.buffer.asUint8List();
  }

  void _saveImage(Uint8List imageBytes) {
    // Generate a unique filename
    final filename = 'poster_${DateTime.now().millisecondsSinceEpoch}.png';

    // Create a blob and download link for web
    final blob = html.Blob([imageBytes]);
    final url = html.Url.createObjectUrl(blob);

    // Create an anchor element and trigger download
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', filename)
      ..click();

    // Clean up the URL
    html.Url.revokeObjectUrl(url);
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poster Maker'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _downloadPoster,
            tooltip: 'Download Poster',
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: RepaintBoundary(
            key: _posterKey,
            child: AspectRatio(
              aspectRatio: 1 / 1, // Square poster
              child: BackgroundImage(
                child: TextOverlay(
                  onTextChanged: (text) {
                    setState(() {
                      _currentText = text;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
