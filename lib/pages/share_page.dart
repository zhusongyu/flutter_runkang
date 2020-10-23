import 'package:flutter/material.dart';
import 'package:flutter_runkang/models.dart/share_list.dart';
import 'package:flutter_runkang/shared/image_factory.dart';
import 'package:provider/provider.dart';

class SharePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SharePageState();
  }
}

class SharePageState extends State<SharePage> {
  // ShareList _shareList = ShareList();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _shareList.items = [
    //   ShareItem(number: '1', time: '2020', buy: true),
    //   ShareItem(number: '2', time: '2022', buy: true),
    //   ShareItem(number: '3', time: '2022', buy: true)
    // ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemBuilder: (context, index) {
        return TeamItem(
          index: index,
        );
      },
      itemCount: 3,
    );
  }
}

class TeamItem extends StatelessWidget {
  int index = 0;

  TeamItem({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _shareList1 = Provider.of<ShareList>(context);
    print('_shareList1   $_shareList1');
    // TODO: implement build
    return Row(
      children: [
        ImageFactory.life,
        SizedBox(
          width: 10,
        ),
        Text('${_shareList1.items[index].num}'),
        Text('data'),
        Text('2020-08-30 17:11:00')
      ],
    );
  }
}
