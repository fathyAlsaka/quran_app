import 'package:flutter/material.dart';
import '../../Models/database.dart';

class AyatScreen extends StatelessWidget {
  AyatScreen({Key? key, required this.soraName, required this.soraID})
      : super(key: key);

  final String soraName;
  final int soraID;
  late double maxHeight;
  late double maxWidth;

  @override
  Widget build(BuildContext context) {
    maxWidth = MediaQuery.of(context).size.width - 100;
    maxHeight = MediaQuery.of(context).size.height - 180;

    return Scaffold(
      appBar: AppBar(
        title: Text(soraName),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              "assets/quran_frame2.png",
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 50, top: 80, right: 50, bottom: 100),
            child: FutureBuilder<List<Map>>(
              future: QuranDB.retrieveAyat(soraID),
              builder: (context, AsyncSnapshot<List<Map>> snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      textDirection: TextDirection.rtl,
                      children: combineAyat(snapshot.data!),
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  combineAyat(ayat) {
    List<Widget> widgets = [];
    for (Map aya in ayat) {
      String ayaID = "";
      aya["ayaid"].toString().split("").forEach((char) {ayaID += arabicNumbers[char];});
      aya["text"].toString().split(" ").forEach((word) {
        widgets.add(
            RichText(
              text: TextSpan(
                text: "$word ",
                style: const TextStyle(
                  fontFamily: 'quran',
                  fontSize: 23,
                  color: Colors.black,
                ),
              ),
            )
        );
      });


      widgets.add(
          aya["ayaid"] == 0
                  ? SizedBox(width: maxWidth,)
                  : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          width: 35,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: const AssetImage('assets/AyaNumber.png'),
                            child: Text(ayaID),
                          ),
                        ),
                      ),
      );
    }
    return widgets;
  }

  Map arabicNumbers = {
    '0': '\u0660',
    '1': '\u0661',
    '2': '\u0662',
    '3': '\u0663',
    '4': '\u0664',
    '5': '\u0665',
    '6': '\u0666',
    '7': '\u0667',
    '8': '\u0668',
    '9': '\u0669',
  };

}
