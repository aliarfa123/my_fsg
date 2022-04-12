import 'package:firebase_database/firebase_database.dart';
import 'package:my_fsg/screens/pdfcomp.dart';
import 'package:my_fsg/theme/colors.dart';
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
    pdf.addPage(Page(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return Row(children: [
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
          ]);
        }));
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
