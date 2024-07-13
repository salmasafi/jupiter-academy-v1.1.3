/*
  Future<ThemeMode> _getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    return isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  }

   /*return BlocProvider(
      create: (context) => JupiterCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    ); */

    /*  child: FutureBuilder<ThemeMode>(
        future: _getThemeMode(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyLoadingWidget();
          } else {
            final themeMode = snapshot.data ?? ThemeMode.light;
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: themeMode,
              navigatorKey: navigatorKey,
              home: 
            ); */

            */