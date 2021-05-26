import 'package:covid19_app/widget/stats_grid.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/widget/custom_app_bar.dart';
import 'package:covid19_app/widget/local_dropdown.dart';

List<String> LocalList = ['전체', '서울', '대전', '대구', '부산', '경기', '제주'];
List<int> ListNum = [0, 1, 6, 3, 2, 9, 17];

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  String _local = localData;

  @override
  Widget build(BuildContext context) {
    final ScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(ScreenHeight),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: StatsGrid(),
            ),
          )
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildHeader(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'COVID-19',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                LocalDropdown(
                  locals: LocalList,
                  local: _local,
                  onChanged: (val) => setState(
                    () {
                      _local = val;
                      j = LocalList.indexOf(val);
                      i = ListNum[j];
                      print(i);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
