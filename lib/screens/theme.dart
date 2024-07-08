import 'package:flutter/material.dart';
import 'package:tiktickat/widgets/colorschemeview.dart';

/// Flutter code sample for [ColorScheme.fromImageProvider] with content-based dynamic color.

const Widget divider = SizedBox(height: 10);
const double narrowScreenWidthThreshold = 400;

void main() => runApp(DynamicColorExample());

class DynamicColorExample extends StatefulWidget {
  DynamicColorExample({super.key});

  final List<ImageProvider> images = <NetworkImage>[
    const NetworkImage(
        'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_1.png'),
    const NetworkImage(
        'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_2.png'),
    const NetworkImage(
        'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_3.png'),
    const NetworkImage(
        'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_4.png'),
    const NetworkImage(
        'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_5.png'),
    const NetworkImage(
        'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_6.png'),
  ];

  @override
  State<DynamicColorExample> createState() => _DynamicColorExampleState();
}

class _DynamicColorExampleState extends State<DynamicColorExample> {
  late ColorScheme currentColorScheme;
  String currentHyperlinkImage = '';
  late int selectedImage;
  late bool isLight;
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    selectedImage = 0;
    isLight = true;
    isLoading = true;
    currentColorScheme = const ColorScheme.light();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateImage(widget.images[selectedImage]);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = currentColorScheme;
    final Color selectedColor = currentColorScheme.primary;

    final ThemeData lightTheme = ThemeData(
      colorSchemeSeed: selectedColor,
      brightness: Brightness.light,
      useMaterial3: false,
    );
    final ThemeData darkTheme = ThemeData(
      colorSchemeSeed: selectedColor,
      brightness: Brightness.dark,
      useMaterial3: false,
    );

    Widget schemeLabel(String brightness, ColorScheme colorScheme) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(
          brightness,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSecondaryContainer),
        ),
      );
    }

    Widget schemeView(ThemeData theme) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ColorSchemeView(colorScheme: theme.colorScheme),
      );
    }

    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: colorScheme),
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: const Text('Content Based Dynamic Color'),
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            actions: <Widget>[
              const Icon(Icons.light_mode),
              Switch(
                  activeColor: colorScheme.primary,
                  activeTrackColor: colorScheme.surface,
                  inactiveTrackColor: colorScheme.onSecondary,
                  value: isLight,
                  onChanged: (bool value) {
                    setState(() {
                      isLight = value;
                      _updateImage(widget.images[selectedImage]);
                    });
                  })
            ],
          ),
          body: Center(
            child: isLoading
                ? const CircularProgressIndicator()
                : ColoredBox(
                    color: colorScheme.secondaryContainer,
                    child: Column(
                      children: <Widget>[
                        divider,
                        _imagesRow(
                          context,
                          widget.images,
                          colorScheme,
                        ),
                        divider,
                        Expanded(
                          child: ColoredBox(
                            color: colorScheme.surface,
                            child: LayoutBuilder(builder: (BuildContext context,
                                BoxConstraints constraints) {
                              if (constraints.maxWidth <
                                  narrowScreenWidthThreshold) {
                                return SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      divider,
                                      schemeLabel(
                                          'Light ColorScheme', colorScheme),
                                      schemeView(lightTheme),
                                      divider,
                                      divider,
                                      schemeLabel(
                                          'Dark ColorScheme', colorScheme),
                                      schemeView(darkTheme),
                                    ],
                                  ),
                                );
                              } else {
                                return SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  schemeLabel(
                                                      'Light ColorScheme',
                                                      colorScheme),
                                                  schemeView(lightTheme),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  schemeLabel(
                                                      'Dark ColorScheme',
                                                      colorScheme),
                                                  schemeView(darkTheme),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateImage(ImageProvider provider) async {
    final ColorScheme newColorScheme = await ColorScheme.fromImageProvider(
        provider: provider,
        brightness: isLight ? Brightness.light : Brightness.dark);
    if (!mounted) {
      return;
    }
    setState(() {
      selectedImage = widget.images.indexOf(provider);
      currentColorScheme = newColorScheme;
    });
  }

  // For small screens, have two rows of image selection. For wide screens,
  // fit them onto one row.
  Widget _imagesRow(BuildContext context, List<ImageProvider> images,
      ColorScheme colorScheme) {
    final double windowHeight = MediaQuery.of(context).size.height;
    final double windowWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 800) {
          return _adaptiveLayoutImagesRow(images, colorScheme, windowHeight);
        } else {
          return Column(children: <Widget>[
            _adaptiveLayoutImagesRow(
                images.sublist(0, 3), colorScheme, windowWidth),
            _adaptiveLayoutImagesRow(
                images.sublist(3), colorScheme, windowWidth),
          ]);
        }
      }),
    );
  }

  Widget _adaptiveLayoutImagesRow(
      List<ImageProvider> images, ColorScheme colorScheme, double windowWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: images
          .map(
            (ImageProvider image) => Flexible(
              flex: (images.length / 3).floor(),
              child: GestureDetector(
                onTap: () => _updateImage(image),
                child: Card(
                  color: widget.images.indexOf(image) == selectedImage
                      ? colorScheme.primaryContainer
                      : colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: windowWidth * .25),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image(image: image),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
