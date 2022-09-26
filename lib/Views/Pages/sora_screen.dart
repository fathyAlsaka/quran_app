import 'package:flutter/material.dart';
import '../../Models/database.dart';
import 'ayat_screen.dart';

class SoraScreen extends StatefulWidget {
  const SoraScreen({Key? key}) : super(key: key);

  @override
  _SoraScreenState createState() => _SoraScreenState();
}

class _SoraScreenState extends State<SoraScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("السور"),
        ),
        body: FutureBuilder(
          future: QuranDB.retrieve(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    var sora = snapshot.data![index];
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AyatScreen(soraName: sora["name"], soraID: sora["soraid"]),
                          )),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: ListTile(
                          leading: sora['place'] == 1
                              ? Image.asset("assets/kaba.png")
                              : Image.asset("assets/medina.png"),
                          title: Text(
                            sora['name'],
                            style: const TextStyle(fontFamily: 'quran', fontSize: 23),
                          ),
                          subtitle: Text(
                            sora['place'] == 1
                                ? 'مكية'
                                : 'مدنية',
                            style: const TextStyle(fontFamily: 'quran', fontSize: 15),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: snapshot.data!.length);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
