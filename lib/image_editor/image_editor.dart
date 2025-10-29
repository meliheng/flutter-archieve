import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pro_image_editor/pro_image_editor.dart';

class ImageEditor extends StatefulWidget {
  const ImageEditor({super.key});

  @override
  State<ImageEditor> createState() => _ImageEditorState();
}

class _ImageEditorState extends State<ImageEditor> {
  final _editorKey = GlobalKey<ProImageEditorState>();
  @override
  void initState() {
    super.initState();

    // Kısa bir delay ile modu tetiklemek gerekebilir
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _editorKey.currentState?.openCropRotateEditor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset("assets/cat3.jpg", fit: BoxFit.cover),
            ProImageEditor.asset(
              "assets/cat2.jpg",
              key: _editorKey,
              configs: ProImageEditorConfigs(
                imageGeneration: ImageGenerationConfigs(
                  cropToDrawingBounds: false,
                  cropToImageBounds: false,
                ),
                cropRotateEditor: CropRotateEditorConfigs(
                  enableTransformLayers: false,
                  enableFlipAnimation: false,
                  enableGesturePop: false,
                  enableProvideImageInfos: false,
                  initialCropMode: CropMode.oval,
                  invertDragDirection: false,
                  maxScale: 1,
                  enableDoubleTap: false,
                  style: CropRotateEditorStyle(background: Colors.transparent),
                  widgets: CropRotateEditorWidgets(
                    bodyItems: (editor, rebuildStream) => [],
                    bottomBar: (editorState, rebuildStream) => null,
                    appBar: (editorState, rebuildStream) => null,
                  ),
                ),
                layerInteraction: LayerInteractionConfigs(
                  initialSelected: true,
                  selectable: LayerInteractionSelectable.enabled,
                  widgets: LayerInteractionWidgets(
                    border: (layerWidget, layerData) => SizedBox(),
                  ),
                ),
                dialogConfigs: DialogConfigs(widgets: DialogWidgets()),
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
                  appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
                  scaffoldBackgroundColor: Colors.red,
                  canvasColor: Colors.red,
                ),
                mainEditor: MainEditorConfigs(
                  invertTrackpadDirection: false,
                  enableEscapeButton: false,
                  enableCloseButton: false,
                  enableZoom: false,
                  transformSetup: MainEditorTransformSetup(
                    transformConfigs: TransformConfigs.empty(),
                  ),
                  style: MainEditorStyle(
                    appBarBackground: Colors.transparent,
                    appBarColor: Colors.transparent,
                    background: Colors.transparent,
                    outsideCaptureAreaLayerOpacity: 0,
                    uiOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                    ),
                  ),
                  widgets: MainEditorWidgets(
                    appBar: (editor, rebuildStream) => null,
                    bodyItems: (editor, rebuildStream) => [],
                    bottomBar: (editor, rebuildStream, key) => null,
                  ),
                ),
              ),
              callbacks: ProImageEditorCallbacks(),
            ),
          ],
        ),
      ),
    );
  }
}
