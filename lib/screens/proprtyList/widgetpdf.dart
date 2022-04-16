import 'package:flutter/services.dart';
import 'package:my_fsg/screens/proprtyList/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:printing/printing.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class PdfApi {
  static Future<File> generateImage(
    String img,
    address,
    name,
    contact,
    tel,
    email,
    dateTime,
    List images,
  ) async {
    final pdf = Document();
    final netImage = await networkImage(img);
    final logoImage = MemoryImage(
      (await rootBundle.load('assets/images/logo_pdf.png'))
          .buffer
          .asUint8List(),
    );
    pdf.addPage(
      MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: EdgeInsets.all(20),
          header: (context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image(
                  logoImage,
                  width: 100,
                ),
              ],
            );
          },
          build: (Context context) {
            return <Widget>[
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Arbeitsscheine',
                        style: pdfStyle,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        name + ' - ' + address,
                        style: pdfStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Padding(
                          padding: EdgeInsets.only(
                            right: 4,
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Date',
                                style: pdfStyleSmall,
                              ),
                              Text(
                                dateTime.toString().split(' ').first,
                                style: pdfStyle,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          children: [
                            Text(
                              'Time',
                              style: pdfStyleSmall,
                            ),
                            Text(
                              dateTime
                                  .toString()
                                  .split(' ')
                                  .last
                                  .split('.')
                                  .first,
                              style: pdfStyle,
                            ),
                          ],
                        ),
                      ]),
                      Container(
                        width: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Customer',
                              style: pdfStyleSmall,
                            ),
                            Text(
                              name,
                              style: pdfStyleSmall,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Address',
                              style: pdfStyleSmall,
                            ),
                            Wrap(
                              children: [
                                Text(
                                  address,
                                  style: pdfStyleSmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: pdfStyleSmall,
                          ),
                          Text(
                            'Description here',
                            style: pdfStyle,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 350,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Photos',
                        style: pdfStyle,
                      ),
                    ],
                  ),
                  Wrap(alignment: WrapAlignment.spaceAround, children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 350,
                          height: 250,
                          child: Image(netImage),
                        ),
                        Text(
                          dateTime.toString().split(' ').last.split('.').first,
                          style: pdfStyleSmall,
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 350,
                          height: 250,
                          child: Image(netImage),
                        ),
                        Text(
                          dateTime.toString().split(' ').last.split('.').first,
                          style: pdfStyleSmall,
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 350,
                          height: 250,
                          child: Image(netImage),
                        ),
                        Text(
                          dateTime.toString().split(' ').last.split('.').first,
                          style: pdfStyleSmall,
                        ),
                      ],
                    ),
                    SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 350,
                          height: 250,
                          child: Image(netImage),
                        ),
                        Text(
                          dateTime.toString().split(' ').last.split('.').first,
                          style: pdfStyleSmall,
                        ),
                      ],
                    ),
                  ]),
                ],
              ),
            ];
          },
          footer: (context) {
            final text = 'Page ${context.pageNumber} of ${context.pagesCount}';
            return Column(children: [
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text('Address', style: footerStyle),
                    Text('FSG Immobillienservice', style: footerStyleSmall),
                    Text('Lohhof 28', style: footerStyleSmall),
                    Text('20535 Hamburg', style: footerStyleSmall),
                  ]),
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text('Contact', style: footerStyle),
                    Text('Tel: 01778377976', style: footerStyleSmall),
                    Text('jg@fsg-immobillineservice.de',
                        style: footerStyleSmall),
                  ]),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    text,
                  ),
                ],
              ),
            ]);
          }),
    );
    return saveDocument(name: '$name - $address -ToDo-day.pdf', pdf: pdf);
  }

  static Future<File> saveDocument(
      {required String name, required Document pdf}) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }
}

var pdfStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 22,
);
var pdfStyleSmall = TextStyle(
  // fontWeight: FontWeight.bold,
  fontSize: 20,
);
var footerStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
);
var footerStyleSmall = TextStyle(
  // fontWeight: FontWeight.bold,
  fontSize: 10,
);
