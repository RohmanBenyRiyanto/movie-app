import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/injections/injection.dart';
import '../../core/routes/routes.dart';
import '../res/l10n/logic/locale_cubit.dart';
import '../res/res.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(
          create: (context) => locator<LocaleCubit>()..init(),
        ),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        buildWhen: (previous, current) => previous.locale != current.locale,
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Movie App',
            routerConfig: RoutingSetting().router,
            debugShowCheckedModeBanner: false,
            scaffoldMessengerKey: snackKey,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: state.locale,
          );
        },
      ),
    );
  }
}
