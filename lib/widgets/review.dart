import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:typed_data';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../uitilities/contant.dart';

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  Uint8List bytes = Uint8List(0);

  Future<void> _generatePDF() async {
    try {
      print("Generating PDF...");
      final document = PdfDocument();

      document.pages.add().graphics.drawString(
          pdftext, PdfStandardFont(PdfFontFamily.helvetica, 12),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: const Rect.fromLTWH(0, 0, 500, 900));

      bytes = Uint8List.fromList(await document.save());
      AnchorElement(
          href:
              "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
        ..setAttribute("download", "report.pdf")
        ..click();
      document.dispose();
      setState(() {});
    } catch (e) {
      print("Error generating PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Final PDF Generator and Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _generatePDF(),
              child: Text('Generate PDF'),
            ),
            SizedBox(height: 16),
            if (bytes.isNotEmpty)
              Text("PDF Generated Sucessfully")
            else
              Text('No PDF generated yet'),
          ],
        ),
      ),
    );
  }
}
