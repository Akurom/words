import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:words/models/column_grid_model.dart';
import 'package:words/models/game_model.dart';
import 'package:words/models/grid_model.dart';
import 'package:words/models/row_grid_model.dart';
import 'package:words/views/widgets/letter.dart';
import 'package:words/views/pages/game_page_OLD.dart';
import 'package:words/const/size_constants.dart';
import 'package:words/utils/utils.dart';
import 'views/pages/game_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  GameModel gameModel = GameModel(colsNumber: 11, rowsNumber: 17);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<GameModel>.value(value: gameModel),
        ChangeNotifierProvider<ColumnGridModel>.value(value: gameModel.gridModel.columnGrid),
        ChangeNotifierProvider<RowGridModel>.value(value: gameModel.gridModel.rowsGrid),
        Provider<BuildContext>(create: (c) => c),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: GamePage(),
    );
  }
}
