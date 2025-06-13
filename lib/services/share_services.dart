// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pitchmatter_assignment/widgets/toast_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> checkAndRequestStoragePermission() async {
  if (Platform.isAndroid) {
    final status = await Permission.manageExternalStorage.status;

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      final result = await Permission.manageExternalStorage.request();
      return result.isGranted;
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }
  } else if (Platform.isIOS) {
    final status = await Permission.photos.status;

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      final result = await Permission.photos.request();
      return result.isGranted;
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }
  }

  return false; // For other platforms or unknown state
}

Future<void> shareQRCode({
  required BuildContext context,
  required String name,
  required String company,
  required String email,
  required String phone,
  required String profileUrl,
}) async {
  final String qrData = '''
Name: $name
Company: $company
Email: $email
Phone: $phone
Profile: $profileUrl
''';

  try {
    bool storagePermission = await checkAndRequestStoragePermission();
    if (!storagePermission) {
      ToastService.sendScaffoldAlert(
        msg: 'Enable storage permission to share QR code',
        toastStatus: 'ERROR',
        context: context,
      );
      return;
    }

    // QR and canvas config
    const double imageSize = 800;
    const double borderRadius = 40;
    const double borderWidth = 40;
    const Color qrColor = Color(0xFF5E41F1);
    const Color backgroundColor = Colors.white;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint();

    // Draw white rounded background
    final rect = Rect.fromLTWH(0, 0, imageSize, imageSize);
    final rRect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    paint.color = backgroundColor;
    canvas.drawRRect(rRect, paint);

    // Paint QR code
    final qrPainter = QrPainter(
      data: qrData,
      version: QrVersions.auto,
      gapless: true,
      color: qrColor,
      emptyColor: Colors.transparent, // Background already white
    );

    final qrImage = await qrPainter.toImage((imageSize - 2 * borderWidth));
    final qrOffset = Offset(borderWidth, borderWidth);
    canvas.drawImage(qrImage, qrOffset, Paint());

    // End recording and export image
    final finalImage = await recorder
        .endRecording()
        .toImage(imageSize.toInt(), imageSize.toInt());
    final byteData =
        await finalImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    // Save and share
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/qr_code.png').create();
    await file.writeAsBytes(pngBytes);

    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'Scan this QR to connect with $name from $company!',
    );
  } catch (e) {
    debugPrint(e.toString());
    ToastService.sendScaffoldAlert(
      msg: e.toString(),
      toastStatus: 'ERROR',
      context: context,
    );
  }
}

Future<void> openMap({
  required double latitude,
  required double longitude,
  required BuildContext context,
}) async {
  final googleUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

  try {
    if (await canLaunchUrl(googleUrl)) {
      final launched = await launchUrl(googleUrl,
          mode: LaunchMode.externalApplication);
      if (!launched) {
        throw 'Could not launch map';
      }
    } else {
      throw 'Cannot launch map URL';
    }
  } catch (e, stackTrace) {
    debugPrint('Error: $e');
    debugPrint('StackTrace: $stackTrace');
    ToastService.sendScaffoldAlert(
      msg: e.toString(),
      toastStatus: 'ERROR',
      context: context,
    );
  }
}


shareProfileLink(String profileLink) {
  Share.share(profileLink);
}

Future<void> launchWebsite({required String url, required BuildContext context}) async {
  try {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri,
          mode: LaunchMode.externalApplication); // Opens in browser
    } else {
      throw 'Could not launch $url';
    }
  } catch (e) {
    ToastService.sendScaffoldAlert(
      msg: e.toString(),
      toastStatus: 'ERROR',
      context: context,
    );
    throw Exception(e);
  }
}
