import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {

  List<Stock> data = [];

  List<Stock> pool = [
    Stock(code: "601900", name: "南方传媒"),
    Stock(code: "601901", name: "方正证券"),
    Stock(code: "601928", name: "凤凰传媒"),
    Stock(code: "601939", name: "建设银行"),
    Stock(code: "601988", name: "中国银行"),
    Stock(code: "601901", name: "方正证券"),
    Stock(code: "601990", name: "南京证券"),
    Stock(code: "601998", name: "中信银行"),
    Stock(code: "600601", name: "方正科技"),
    Stock(code: "601601", name: "中国太保"),
    Stock(code: "600601", name: "方正科技"),
    Stock(code: "603833", name: "桃李面包"),
    Stock(code: "000001", name: "平安银行"),
    Stock(code: "600036", name: "招商银行"),
    Stock(code: "600999", name: "招商证券"),
    Stock(code: "000776", name: "广发证券"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search),
        titleSpacing: 0,
        title: TextField(
          autofocus: true,
          textDirection: TextDirection.ltr,
          decoration: InputDecoration(
            hintText: "请输入股票代码/简拼",
            hintStyle: TextStyle(
              color: Colors.white70
            ),
            border: InputBorder.none
          ),
          style: TextStyle(
            color: Colors.white,
            decorationColor: Colors.white,
            decorationStyle: TextDecorationStyle.solid,
          ),
          cursorColor: Colors.white,
          textInputAction: TextInputAction.done,
          onChanged: (text) {
            data = searchStock(text);
            setState(() {});
          },
          enableInteractiveSelection: false,
        ),
        actions: <Widget>[
          MaterialButton(
            child: Text(
              "取消",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context, '取消');
            },
          )
        ],
      ),
      body: SearchResultPage(
        data: data,
      ),
    );
  }

  List<Stock> searchStock(String text) {
    List<Stock> result = [];
    pool.forEach((Stock stock) {
      if (stock.code.contains(text)) {
        result.add(stock);
      }
    });
    return result;
  }
}

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchBarState();
  }

  @override
  Size get preferredSize => null;
}

class SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class Stock {
  String code;
  String name;
  String market;
  String subType;
  Stock({this.code, this.name, this.market, this.subType});
}

//搜索结果页面
class SearchResultPage extends StatelessWidget {
  final List<Stock> data;

  const SearchResultPage({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildListView(data);
  }

  ListView buildListView(List<Stock> data) {
    return ListView(
      children: data.map((Stock stock) {
        return StockView(stock: stock);
      }).toList(),
    );
  }
}

class StockView extends StatelessWidget {
  final Stock stock;

  const StockView({Key key, this.stock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(stock.name + "  " + stock.code)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: <Widget>[
            Text(stock.name),
            Container(
              margin: EdgeInsets.only(left: 16),
              child: Text(stock.code),
            ),
          ],
        ),
      ),
    );
  }
}
