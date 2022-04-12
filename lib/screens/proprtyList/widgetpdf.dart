import 'package:flutter/services.dart';
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
    List notes,
    List toDo,
  ) async {
    final pdf = Document();
    final netImage = await networkImage(img);

    final logoImage = MemoryImage(
      (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List(),
    );
    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: EdgeInsets.all(20),
        build: (Context context) {
          return <Widget>[
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image(
                    logoImage,
                    height: 100,
                  ),
                ],
              ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: 4,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Date',
                            style: pdfStyleSmall,
                          ),
                          Text(
                            'date here',
                            style: pdfStyle,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Time',
                          style: pdfStyleSmall,
                        ),
                        Text(
                          'time here',
                          style: pdfStyle,
                        ),
                      ],
                    ),
                  ]),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
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
                      Text(
                        address,
                        style: pdfStyleSmall,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(children: [
                Text(
                  'Description',
                  style: pdfStyleSmall,
                ),
                Text(
                  'Description here',
                  style: pdfStyle,
                )
              ]),
              Row(
                children: [
                  Container(
                    width: 500,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 500,
                          height: 300,
                          child: Image(netImage),
                        ),
                        Wrap(
                          children: [
                            Text(
                              'Adress:  ' + address.toString(),
                              style: pdfStyle,
                            ),
                            Text(
                              ', Name:    ' + name.toString(),
                              style: pdfStyle,
                            ),
                          ],
                        ),
                        Wrap(children: [
                          Text(
                            'Contact: ' + contact.toString(),
                            style: pdfStyle,
                          ),
                          Text(
                            ',    Tel:     ' + tel.toString(),
                            style: pdfStyle,
                          ),
                        ]),
                        Row(children: [
                          Text(
                            'Email:   ' + email.toString(),
                            style: pdfStyle,
                          ),
                        ]),
                        Text(
                          'Notes:',
                          style: pdfStyle,
                        ),
                        Column(
                          children: List.generate(
                            notes.length,
                            (index) => Text(
                              '-' + notes[index],
                              style: pdfStyleSmall,
                            ),
                          ),
                        ),
                        Text(
                          'To Do List:',
                          style: pdfStyle,
                        ),
                        Column(
                          children: List.generate(
                            toDo.length,
                            (index) => Text(
                              '-' + toDo[index],
                              style: pdfStyleSmall,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ])
          ];
        },
      ),
    );
    return saveDocument(name: 'MyFsg.pdf', pdf: pdf);
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
