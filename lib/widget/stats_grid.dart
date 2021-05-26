import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

int i = 0;
int j = 0;

class Covid {
  int defCnt;
  int deathCnt;
  int isolClearCnt;
  int isolIngCnt;
  int preCnt;
  int incDec;

  Covid(
      {this.defCnt,
      this.deathCnt,
      this.isolClearCnt,
      this.isolIngCnt,
      this.preCnt,
      this.incDec});
}

Future<Covid> getCovid() async {
  http.Response response;
  var data1;
  Covid covid;

  try {
    response =
        await http.get(Uri.parse("https://82b3497a8713.ngrok.io/covid/data"));
    data1 = json.decode(response.body);
    covid = Covid(
        defCnt: data1["data"][i]["defCnt"],
        isolClearCnt: data1["data"][i]["isolClearCnt"],
        isolIngCnt: data1["data"][i]["isolIngCnt"],
        incDec: data1["data"][i]["incDec"],
        preCnt: data1["data"][i]["defCnt"] - data1["data"][i]["isolClearCnt"],
        deathCnt: data1["data"][i]["deathCnt"]);
  } catch (e) {
    covid = null;
    print(e);
  }

  return covid;
}

class StatsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      margin: const EdgeInsets.all(10.0),
      child: FutureBuilder(
          future: getCovid(),
          builder: (context, AsyncSnapshot<Covid> snapshot) {
            if (snapshot.hasData == false) {
              return Center(
                  child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator()));
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                    child: Row(
                  children: <Widget>[
                    _buildStatCard('총 확진자',
                        '${snapshot.data.defCnt.toString()}명', Colors.orange),
                    _buildStatCard('사망자',
                        '${snapshot.data.deathCnt.toString()}명', Colors.red),
                  ],
                )),
                Flexible(
                    child: Row(
                  children: <Widget>[
                    _buildStatCard(
                        '격리 해제',
                        '${snapshot.data.isolClearCnt.toString()}명',
                        Colors.green),
                    _buildStatCard('현재 확진자',
                        '${snapshot.data.preCnt.toString()}', Colors.yellow),
                  ],
                )),
                Flexible(
                    child: Row(
                  children: <Widget>[
                    _buildStatCard('격리중',
                        '${snapshot.data.isolIngCnt.toString()}명', Colors.blue),
                    _buildStatCard('신규 확진자',
                        '${snapshot.data.incDec.toString()}명', Colors.purple),
                  ],
                ))
              ],
            );
          }),
    );
  }

  Expanded _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              count,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
