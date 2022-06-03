library fancy_dialog;

import 'package:flutter/material.dart';

import 'FancyGif.dart';

const testKeys = [Key("fancyButtons"), Key("flatButtons")];

class FancyDialog extends StatefulWidget {
  const FancyDialog(
      {Key? key,
      required this.title,
      required this.description,
      this.okFun,
      this.titleTextStyle = const TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      this.descriptionTextStyle =
          const TextStyle(color: Colors.grey, fontSize: 15),
      this.cancelFun,
      this.animationType = 1,
      this.gifPath = FancyGif.MOVE_FORWARD,
      this.cancelColor = Colors.grey,
      this.okColor = Colors.pink,
      this.ok = " OK !",
      this.cancel = "Cancel",
      this.defaultButtons = true,
      this.actionButtons,
      this.theme = 0 //default theme is fancy
      })
      : super(key: key);

  final String? title;
  final String? description;
  final Function? okFun;
  final Function? cancelFun;
  final int? animationType;
  final FancyGif? gifPath;
  final Color? okColor;
  final Color? cancelColor;
  final String? ok;
  final String? cancel;
  final TextStyle titleTextStyle;
  final TextStyle descriptionTextStyle;
  final int? theme; // 0: fancy , 1:flat
  final bool defaultButtons;
  final Widget? actionButtons;
  @override
  GifDialogState createState() {
    return GifDialogState();
  }
}

class GifDialogState extends State<FancyDialog> with TickerProviderStateMixin {
  AnimationController? ac;
  Animation? animation;
  double? width;
  double? height;
  int animationAxis = 0; // 0 for x 1 for y

  String? title;
  String? description;
  Function? okFun;
  Function? cancelFun;
  FancyGif? gifPath;
  String? path;
  Color? okColor;
  Color? cancelColor;
  TextStyle? titleTextStyle;
  TextStyle? descriptionTextStyle;
  String? ok;
  String? cancel;
  int? theme;
  bool? defaultButtons;
  Widget? actionButtons;
  int package = 0; //0 user assets ,1 package assets
  @override
  void initState() {
    title = widget.title;
    description = widget.description;
    okFun = widget.okFun ?? () {};
    cancelFun = widget.cancelFun ?? () {};
    okColor = widget.okColor;
    cancelColor = widget.cancelColor;
    gifPath = widget.gifPath;
    ok = widget.ok;
    cancel = widget.cancel;
    theme = widget.theme;
    titleTextStyle = widget.titleTextStyle;
    descriptionTextStyle = widget.descriptionTextStyle;
    defaultButtons = widget.defaultButtons;
    actionButtons = widget.actionButtons;

    if(gifPath != null) {
      path = 'assets/${gifPath?.name}.gif';
      package = 1;
    }



    // if (gifPath == FancyGif.CHECK_MAIL) {
    //   path = 'assets/${gifPath?.name}.gif';
    //   package = 1;
    // } else if (gifPath == FancyGif.FUNNY_MAN) {
    //   path = 'assets/FUNNY_MAN.gif';
    //   package = 1;
    // } else if (gifPath == FancyGif.MOVE_FORWARD) {
    //   path = 'assets/MOVE_FORWARD.gif';
    //   package = 1;
    // } else if (gifPath == FancyGif.PLAY_MEDIA) {
    //   path = 'assets/PLAY_MEDIA.gif';
    //   package = 1;
    // } else if (gifPath == FancyGif.SUBMIT) {
    //   path = 'assets/SUBMIT.gif';
    //   package = 1;
    // } else if (gifPath == FancyGif.SHARE) {
    //   path = 'assets/SHARE.gif';
    //   package = 1;
    // }

    double? start;
    int animationType = widget.animationType!;
    switch (animationType) {
      case 1:
        {
          start = -1.0;
          break;
        }
      case -1:
        {
          start = 1.0;
          break;
        }
      case 2:
        {
          start = -1.0;
          break;
        }
      case -2:
        {
          start = 1.0;
          break;
        }
    }
    if (animationType.abs() == 2) animationAxis = 1;
    ac =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    animation = Tween(begin: start, end: 0.0)
        .animate(CurvedAnimation(parent: ac!, curve: Curves.easeIn));
    animation!.addListener(() {
      setState(() {});
    });

    ac!.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!defaultButtons!)
      assert(actionButtons != null,
          '\n***actionButtons cannot be null when defaultButtons is false***\n');
    width = MediaQuery.maybeOf(context)?.size.width;
    height = MediaQuery.maybeOf(context)?.size.height;
    var dialogWidth = 0.36 * (height ?? 0);

    assert(MediaQuery.maybeOf(context) != null,
        '\n****context does not contain media query object***\n');
    assert(title != null, '\n****title is required***\n');
    assert(description != null, '\n****description is required***\n');

    final image = ClipRRect(
      child: Image.asset(
        path!,
        fit: BoxFit.fill,
        width: dialogWidth * 1.1, // dialogWidth will get left/right margin?
        height: dialogWidth * 0.6,
        package: package == 1 ? 'fancy_dialog' : null,
      ),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(theme == 0 ? 15 : 0),
          topRight: Radius.circular(theme == 0 ? 15 : 0)),
    );

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(theme == 0 ? 15 : 0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: dialogWidth,
          transform: Matrix4.translationValues(
              animationAxis == 0 ? animation!.value * width : 0,
              animationAxis == 1 ? animation!.value * width : 0,
              0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(theme == 0 ? 15 : 0),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              image,
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  title!,
                  style: titleTextStyle,
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Container(
                    child: Text(
                      description!,
                      style: descriptionTextStyle,
                      textAlign: TextAlign.center,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
              widget.defaultButtons
                  ? Container(
                      child: Row(
                        mainAxisAlignment: theme == 1
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.center,
                        children: <Widget>[
                          theme == 0
                              ? customButton(cancel!, cancelColor!, cancelFun!)
                              : flatButton(cancel!, cancelColor!, cancelFun!),
                          SizedBox(
                            width: 10,
                          ),
                          theme == 0
                              ? customButton(ok!, okColor!, okFun!)
                              : flatButton(ok!, okColor!, okFun!)
                        ],
                      ),
                    )
                  : actionButtons!
            ],
          ),
        ),
      ),
    );
  }

  Widget customButton(String t, Color c, Function f) {
    return Container(
      child: ElevatedButton(
        key: testKeys[0],
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          primary: c,
        ),
        child: Text(
          t,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        onPressed: () {
          f();
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget flatButton(String t, Color c, Function f) {
    return Container(
      child: ElevatedButton(
        key: testKeys[1],
        child: Text(
          t,
          style: TextStyle(color: c, fontSize: 15),
        ),
        onPressed: () {
          f();
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
