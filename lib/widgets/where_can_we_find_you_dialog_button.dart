import 'package:flutter/material.dart';
import 'package:myceleb/model/model.dart';
import 'package:myceleb/widgets/widgets.dart';

class WhereCanWeFindYouDialogButton extends StatefulWidget {
  const WhereCanWeFindYouDialogButton({
    Key? key,
  }) : super(key: key);

  @override
  _WhereCanWeFindYouDialogButtonState createState() =>
      _WhereCanWeFindYouDialogButtonState();
}

class _WhereCanWeFindYouDialogButtonState
    extends State<WhereCanWeFindYouDialogButton> {
  int selectedIndex = 3;

  String sortDialogTitle = 'Facebook';

  List<DialogMenuItemsModel> sortDialogItems = [
    DialogMenuItemsModel(title: 'Twitter', index: 0),
    DialogMenuItemsModel(title: 'Instagram', index: 1),
    DialogMenuItemsModel(title: 'YouTube', index: 2),
    DialogMenuItemsModel(title: 'Facebook', index: 3),
    DialogMenuItemsModel(title: 'Twitch', index: 4),
    DialogMenuItemsModel(title: 'TikTok', index: 5),
    DialogMenuItemsModel(title: 'Other', index: 6),
  ];

  updateTitle(index) {
    setState(() {
      sortDialogTitle = sortDialogItems[index].title;
      selectedIndex = sortDialogItems[index].index;
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (BuildContext context, Animation animation,
              Animation secondAnimation) {
            return listMenu();
          },
        );
      },
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.black38),
                borderRadius: BorderRadius.circular(3)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  Text(
                    sortDialogTitle,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 50),
                  Icon(
                    Icons.keyboard_arrow_down,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  listMenu() {
    return Material(
      child: SafeArea(
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Center(
                  child: Container(
                height: 450,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: sortDialogItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            DialogMenuItemsModel mySortDialogItems =
                                sortDialogItems[index];
                            return MyRadioListTile(
                              title: mySortDialogItems.title,
                              value: mySortDialogItems.index,
                              groupValue: selectedIndex,
                              onChanged: updateTitle,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )),
            ),
          ),
        ),
      ),
    );
  }
}
