import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/flavors/build_config.dart';
import 'app/flavors/env_config.dart';
import 'app/routes/app_pages.dart';

void main() {
  EnvConfig config = EnvConfig(
    appName: "ChatGPT_SB",
    shouldCollectCrashLog: true,
  );
  BuildConfig.instantiate(
    envConfig: config,
  );
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(useMaterial3: true),
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
