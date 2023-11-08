import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:agri_food_freind/myData.dart';
import 'package:agri_food_freind/request/event/event.dart';
import 'package:agri_food_freind/time_stamp_embed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:flutter_quill_extensions/presentation/embeds/editor/shims/dart_ui_real.dart';

import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart' as path;
// import 'package:permission_handler/permission_handler.dart';

import 'request/event/event_list.dart';

enum _SelectionType {
  none,
  word,
  // line,
}

class Post extends StatefulWidget {
  const Post({super.key, required this.userName});
  final String userName;
  static String routeName = "post";

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  late final QuillController _controller;
  final FocusNode _focusNode = FocusNode();

  final TextEditingController titleC = TextEditingController();
  final EventRepo eventRepo = EventRepo();
  _SelectionType _selectionType = _SelectionType.none;
  Timer? _selectAllTimer;
  // _SelectionType _selectionType = _SelectionType.none;
  var _isReadOnly = false;

  Future<String> _onImagePaste(Uint8List imageBytes) async {
    // Saves the image to applications directory
    final appDocDir = await getApplicationDocumentsDirectory();
    final file = await File(
      '${appDocDir.path}/${path.basename('${DateTime.now().millisecondsSinceEpoch}.png')}',
    ).writeAsBytes(imageBytes, flush: true);
    return file.path.toString();
  }

  void _startTripleClickTimer() {
    _selectAllTimer = Timer(const Duration(milliseconds: 900), () {
      _selectionType = _SelectionType.none;
    });
  }

  Future<String> _onImagePickCallback(File file) async {
    // Copies the picked file from temporary cache to applications directory
    final appDocDir = await getApplicationDocumentsDirectory();
    final copiedFile =
        await file.copy('${appDocDir.path}/${path.basename(file.path)}');
    return copiedFile.path.toString();
  }

  bool _onTripleClickSelection() {
    final controller = _controller;

    _selectAllTimer?.cancel();
    _selectAllTimer = null;

    if (controller.selection.isCollapsed) {
      _selectionType = _SelectionType.none;
    }

    if (_selectionType == _SelectionType.none) {
      _selectionType = _SelectionType.word;
      _startTripleClickTimer();
      return false;
    }

    if (_selectionType == _SelectionType.word) {
      final child = controller.document.queryChild(
        controller.selection.baseOffset,
      );
      final offset = child.node?.documentOffset ?? 0;
      final length = child.node?.length ?? 0;

      final selection = TextSelection(
        baseOffset: offset,
        extentOffset: offset + length,
      );

      controller.updateSelection(selection, ChangeSource.remote);

      // _selectionType = _SelectionType.line;

      _selectionType = _SelectionType.none;

      _startTripleClickTimer();

      return true;
    }

    return false;
  }

  QuillEditor get quillEditor {
    return QuillEditor(
      configurations: QuillEditorConfigurations(
        placeholder: '輸入內容',
        readOnly: _isReadOnly,
        autoFocus: false,
        enableSelectionToolbar: isMobile(),
        expands: false,
        padding: EdgeInsets.zero,
        onImagePaste: _onImagePaste,
        onTapUp: (details, p1) {
          return _onTripleClickSelection();
        },
        customStyles: const DefaultStyles(
          h1: DefaultTextBlockStyle(
            TextStyle(
              fontSize: 32,
              height: 1.15,
              fontWeight: FontWeight.w300,
            ),
            VerticalSpacing(16, 0),
            VerticalSpacing(0, 0),
            null,
          ),
          sizeSmall: TextStyle(fontSize: 9),
          subscript: TextStyle(
            fontFamily: 'SF-UI-Display',
            fontFeatures: [FontFeature.subscripts()],
          ),
          superscript: TextStyle(
            fontFamily: 'SF-UI-Display',
            fontFeatures: [FontFeature.superscripts()],
          ),
        ),
        embedBuilders: [
          ...FlutterQuillEmbeds.editorBuilders(
            imageEmbedConfigurations: const QuillEditorImageEmbedConfigurations(
              forceUseMobileOptionMenuForImageClick: true,
            ),
          ),
          TimeStampEmbedBuilderWidget()
        ],
      ),
      scrollController: ScrollController(),
      focusNode: _focusNode,
    );
  }

  QuillToolbar get quillToolbar {
    return QuillToolbar(
      configurations: QuillToolbarConfigurations(
        embedButtons: FlutterQuillEmbeds.toolbarButtons(
            imageButtonOptions: QuillToolbarImageButtonOptions(
          imageButtonConfigurations: QuillToolbarImageConfigurations(
            onImageInsertedCallback: (image) async {
              _onImagePickCallback(File(image));
            },
          ),
        )),
        showAlignmentButtons: true,
        buttonOptions: QuillToolbarButtonOptions(
          base: QuillToolbarBaseButtonOptions(
            afterButtonPressed: _focusNode.requestFocus,
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeEditor(BuildContext context) {
    return SafeArea(
      child: QuillProvider(
        configurations: QuillConfigurations(
          controller: _controller,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: quillToolbar,
            ),
            Expanded(
              flex: 15,
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: quillEditor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadFromAssets();
  }

  Future<void> _loadFromAssets() async {
    final doc = Document();

    _controller = QuillController(
      document: doc,
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('發文'),
        actions: [
          TextButton(
              onPressed: () {
                print("button post");
                print("title : " + titleC.text);
                String c = jsonEncode(_controller.document.toDelta().toJson());
                print(c);
                eventRepo
                    .post(Event(
                  title: titleC.text,
                  content: c,
                  user_id: widget.userName,
                  create_time: DateTime.now().toIso8601String(),
                ))
                    .then((value) {
                  if (jsonDecode(value)['success'] == true) {
                    Navigator.pop(context);
                  }
                  print("need to print success");
                  print(jsonDecode(value)['success']);
                });
              },
              child: const Text(
                "發布",
                style: TextStyle(color: Colors.white),
              ))
        ],
        backgroundColor: MyTheme.color,
      ),
      body: Column(children: [
        Row(
          children: [
            SizedBox(
              height: 30,
              width: MediaQuery.of(context).size.width - 50,
              child: TextField(
                controller: titleC,
                decoration: const InputDecoration.collapsed(hintText: '標題名稱'),
              ),
            )
          ],
        ),
        const Text("文章內文"),
        Expanded(
          flex: 15,
          child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: _buildWelcomeEditor(context)),
        ),
      ]),
    );
  }
}
