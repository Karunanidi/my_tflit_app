package com.example.my_tflit_app

import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.my_tflit_app/PERMISSION"

     override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

         flutterEngine?.dartExecutor?.binaryMessenger?.let {
             MethodChannel(it, CHANNEL).setMethodCallHandler { call, result ->
                 if (call.method == "getVersion") {
                     val sdkVersion = getSdkVersion()
                     result.success(sdkVersion)
                 } else {
                     result.notImplemented()
                 }
             }
         }
    }

     private fun getSdkVersion(): Int {
        return Build.VERSION.SDK_INT
    }
}
