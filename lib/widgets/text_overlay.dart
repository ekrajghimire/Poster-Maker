import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class TextOverlay extends StatefulWidget {
  final Function(String)? onTextChanged;

  const TextOverlay({Key? key, this.onTextChanged}) : super(key: key);

  @override
  _TextOverlayState createState() => _TextOverlayState();
}

class _TextOverlayState extends State<TextOverlay> {
  String _text = 'Your Text\nHere';
  Color _textColor = Colors.white;
  double _fontSize = 16.0;
  String _fontFamily = 'AppleGothic';
  FontWeight _fontWeight = FontWeight.normal;
  FontStyle _fontStyle = FontStyle.normal;

  TextStyle get _currentStyle => TextStyle(
        fontSize: _fontSize,
        fontWeight: _fontWeight,
        fontStyle: _fontStyle,
        color: _textColor,
        fontFamily: _fontFamily,
        shadows: [
          Shadow(
            blurRadius: 10.0,
            color: Colors.black,
            offset: Offset(5.0, 5.0),
          ),
        ],
      );

  void _showEditDialog() {
    final TextEditingController textController =
        TextEditingController(text: _text);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Edit Text'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your text (use \\n for new line)',
                      ),
                      maxLines: null,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text('Font Size:'),
                        Expanded(
                          child: Slider(
                            value: _fontSize,
                            min: 6.0,
                            max: 72.0,
                            onChanged: (value) {
                              setState(() {
                                _fontSize = value;
                              });
                            },
                          ),
                        ),
                        Text('${_fontSize.toStringAsFixed(0)}'),
                      ],
                    ),
                    DropdownButton<String>(
                      value: _fontFamily,
                      hint: const Text('Select Font'),
                      items: [
                        'AppleGothic',
                        'Arial',
                        'Times New Roman',
                        'Courier New',
                      ].map((String font) {
                        return DropdownMenuItem<String>(
                          value: font,
                          child: Text(font),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _fontFamily = newValue!;
                        });
                      },
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.format_bold,
                              color: _fontWeight == FontWeight.bold
                                  ? Colors.blue
                                  : Colors.grey),
                          onPressed: () {
                            setState(() {
                              _fontWeight = _fontWeight == FontWeight.bold
                                  ? FontWeight.normal
                                  : FontWeight.bold;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.format_italic,
                              color: _fontStyle == FontStyle.italic
                                  ? Colors.blue
                                  : Colors.grey),
                          onPressed: () {
                            setState(() {
                              _fontStyle = _fontStyle == FontStyle.italic
                                  ? FontStyle.normal
                                  : FontStyle.italic;
                            });
                          },
                        ),
                        // For Color change of the text which is not required for now
                        // import also commented
                        // IconButton(
                        //   icon: const Icon(Icons.color_lens),
                        //   onPressed: () {
                        //     showDialog(
                        //       context: context,
                        //       builder: (BuildContext context) {
                        //         return AlertDialog(
                        //           title: const Text('Pick a text color'),
                        //           content: SingleChildScrollView(
                        //             child: ColorPicker(
                        //               pickerColor: _textColor,
                        //               onColorChanged: (Color color) {
                        //                 setState(() {
                        //                   _textColor = color;
                        //                 });
                        //               },
                        //             ),
                        //           ),
                        //           actions: <Widget>[
                        //             TextButton(
                        //               child: const Text('Got it'),
                        //               onPressed: () {
                        //                 Navigator.of(context).pop();
                        //               },
                        //             ),
                        //           ],
                        //         );
                        //       },
                        //     );
                        //   },
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Save'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _text = textController.text;
                      // Call the callback if provided
                      widget.onTextChanged?.call(_text);
                    });
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _showEditDialog,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Text(
            _text,
            style: _currentStyle,
            textAlign: TextAlign.center,
            softWrap: true, // Allows text to wrap to next line
          ),
        ),
      ),
    );
  }
}
