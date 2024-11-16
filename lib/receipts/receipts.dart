// ignore_for_file: depend_on_referenced_packages

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:printer_app/models/kassa_cheki.dart';
import 'package:printing/printing.dart';

class Receipts {
  Future kassaCheki(
    KassaChekiModel item,
    Order order,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: const PdfPageFormat(58 * 2.835, double.infinity),
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(4.0),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  item.brand,
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  item.phone,
                  style: pw.TextStyle(
                      fontSize: 12, fontWeight: pw.FontWeight.bold),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 2),
                pw.Text(
                  item.address,
                  style: const pw.TextStyle(fontSize: 10),
                ),
                pw.SizedBox(height: 2),
                pw.Text(
                  'Sana: ${item.date}',
                  style: const pw.TextStyle(fontSize: 10),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 10),
                pw.Divider(),
                pw.ListView.builder(
                  itemCount: order.items.length,
                  itemBuilder: (context, index) {
                    final product = order.items[index];

                    var productPrice =
                        double.parse(product.price) * double.parse(product.qty);
                    return pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(vertical: 2.0),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Expanded(
                            child: pw.Text(
                              '${product.product}',
                              style: const pw.TextStyle(fontSize: 10),
                              maxLines: 1,
                            ),
                          ),
                          pw.Text(
                            '${product.qty} x ${product.price} = $productPrice',
                            style: const pw.TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                pw.Divider(),
                pw.SizedBox(height: 5),
                pw.Text(
                  'Jami Summa: ${order.total} UZS',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.right,
                ),
                pw.SizedBox(height: 8),
                // pw.Text(
                //   'Tel: $clientPhone',
                //   style: const pw.TextStyle(
                //     fontSize: 10,
                //   ),
                //   textAlign: pw.TextAlign.center,
                // ),
                // pw.Text(
                //   'Manzil: $address',
                //   style: const pw.TextStyle(
                //     fontSize: 10,
                //   ),
                //   textAlign: pw.TextAlign.center,
                // ),
                // pw.Text(
                //   'Haridingiz uchun rahmat :)',
                //   style: const pw.TextStyle(
                //     fontSize: 10,
                //   ),
                //   textAlign: pw.TextAlign.center,
                // ),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      usePrinterSettings: true,
      onLayout: (_) async {
        return pdf.save();
      },
    );
    return pdf.save();

// try {
//     final printer = PrinterNetworkManager('192.168.123.100');

//     PosPrintResult connect = await printer.connect();

//     if (connect == PosPrintResult.success) {
//       PosPrintResult printing = await printer.printTicket(bytes);
//       // final printingUsb = await printerManager.usbPrinterConnector.send(bytes);

//       if (kDebugMode) {
//         print(printing.msg);
//       }
//       if (kDebugMode) {
//         print("SUCCESS PRINTEED ================>");
//       }
//       // print(usbPrinting.msg);

//       printer.disconnect();
//     }
//   } catch (e) {
//     log(e.toString());
//   }

    // Directly print the document using the selected printer
    //   try {
    //     await Printing.directPrintPdf(
    //       printer: _cachedPrinter!,
    //       onLayout: (PdfPageFormat format) async => pdf.save(),
    //       name: "fast_food_chek.pdf",
    //     );
    //   } catch (e) {
    //     print('Error printing: $e');
    //   }
    //
    //   clearTextFieldTexts();
    // }
  }
}
