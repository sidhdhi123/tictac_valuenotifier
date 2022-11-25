import 'dart:math';

import 'package:flutter/material.dart';

class tic extends StatelessWidget {
  String p1 = "X";
  String p2 = "O";
  String w = "";
  List<String> temp = List.filled(9, "");
  int cnt = 0;
  ValueNotifier<List<String>> l = ValueNotifier(List.filled(9, ""));
  ValueNotifier<String> msg = ValueNotifier("game is running");
  bool winner = false;
  List<int> d = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Color(0xff588C73),
        automaticallyImplyLeading: true,
        title: Text(
          "One - User",
          style: TextStyle(fontFamily: "OpenSans"),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child: InkWell(
                onTap: () {
                  // l = List.filled(9, ValueNotifier(""));
                  temp = List.filled(9, "");
                  l.value = temp;
                  // l.value = List.filled(9, ValueNotifier(""));
                  cnt = 0;

                  w = "";
                  msg.value = "game is running";
                  // winner.value = false;
                  winner = false;
                  d.clear();
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  // margin: EdgeInsets.only(top: 2,bottom: 2,  left: 5, right: 5),
                  decoration: BoxDecoration(
                      color: Color(0xffF2AE72),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: ListTile(
                    title: Icon(
                      Icons.lock_reset,
                      color: Colors.black,
                    ),
                    subtitle: Text("Reset",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                ),
              )),
            ],
          )),
          Expanded(
              child: Container(
            width: 300,
            alignment: Alignment.center,
            child: ListTile(
              title: Text(
                "Status: ",
                textAlign: TextAlign.center,
              ),
              subtitle: ValueListenableBuilder(
                  builder: (context, value, child) {
                    return Text(
                      "${value}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 26, color: Colors.black),
                    );
                  },
                  valueListenable: msg),
            ),
          )),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                des(0),
                des(1),
                des(2),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                des(3),
                des(4),
                des(5),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                des(6),
                des(7),
                des(8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  des(int i) {
    return Expanded(
        flex: 1,
        child: InkWell(
          onTap: () {
            if (l.value[i] == "" && !winner) {
              print("l.value[$i] ==${l.value[i]}");
              print("iswinner: ${!winner}");
              temp[i] = p1;
              l.value = List.from(temp);
              d.add(i);
              cnt++;
              win(p1);
              if (cnt < 8) {
                auto();
              }
            }
          },
          child: ValueListenableBuilder(
              builder: (context, value, child) {
                return Container(
                  height: double.infinity,
                  color: (l.value[i] == "")
                      ? Color(0xff588C73)
                      : (!winner)
                          ? ((l.value[i] == p1)
                              ? Color(0xffF2E394)
                              : Color(0xffF2AE72))
                          : (w == "X")
                              ? ((l.value[i] == p1)
                                  ? Color(0xffD96459)
                                  : Color(0xff588C73))
                              : (w == "O")
                                  ? ((l.value[i] == p2)
                                      ? Color(0xffD96459)
                                      : Color(0xff588C73))
                                  : Colors.purple,
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(7),
                  child: Text(
                    l.value[i],
                    style: TextStyle(fontSize: 20),
                  ),
                );
              },
              valueListenable: l),
        ));
  }

  win(String p) {
    if ((l.value[0] == p && l.value[1] == p && l.value[2] == p) ||
        (l.value[3] == p && l.value[4] == p && l.value[5] == p) ||
        (l.value[6] == p && l.value[7] == p && l.value[8] == p) ||
        (l.value[0] == p && l.value[3] == p && l.value[6] == p) ||
        (l.value[1] == p && l.value[4] == p && l.value[7] == p) ||
        (l.value[2] == p && l.value[5] == p && l.value[8] == p) ||
        (l.value[0] == p && l.value[4] == p && l.value[8] == p) ||
        (l.value[2] == p && l.value[4] == p && l.value[6] == p)) {
      msg.value = "$p is win";
      w = p;
      winner = true;
    } else if (cnt >= 8) {
      msg.value = "game is draw";
      winner = true;
    }
  }

  auto() {
    if (!winner) {
      int min = 0;
      int max = 9;
      int random = Random().nextInt(max - min) + min;
      while (true) {
        if (d.contains(random)) {
          random = Random().nextInt(max - min) + min;
        } else {
          break;
        }
      }
      d.add(random);
      cnt++;
      temp[random] = p2;
      l.value = List.from(temp);
      win(p2);
    }
  }
}
