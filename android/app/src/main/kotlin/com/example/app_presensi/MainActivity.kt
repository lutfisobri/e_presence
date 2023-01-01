package com.nekoid.presensi

import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.net.Uri
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
  private val CHANNEL = "com.nekoid.presensi"

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.nekoid.presensi")
        .setMethodCallHandler { call, result ->
          when (call.method) {
            "startApplication" -> startApplication(call, result)
            "log" -> log(call, result)
            "getDeelink" -> result.success(getDeelink())
            else -> result.notImplemented()
          }
        }
  }

  private fun log(call: MethodCall, result: MethodChannel.Result) {
    val color = call.argument<String>("color")
    val text = call.argument<String>("message")
    val message = colors(color!!, text!!)
    val type = call.argument<String>("type")
    var tag = call.argument<String>("tag")
    if (tag != null) {
      tag = tag
    } else {
      tag = "Riyu"
    }
    if (type == "e") Log.e(tag, message)
    else if (type == "w") Log.w(tag, message)
    else if (type == "i") Log.i(tag, message)
    else if (type == "d") Log.d(tag, message)
    else if (type == "v") Log.v(tag, message)
    else Log.d(tag, message)

    result.success(message)
  }

  private fun startApplication(call: MethodCall, result: MethodChannel.Result) {
    val color = call.argument<String>("color")
    val text = call.argument<String>("message")
    val message = colors(color!!, text!!)
    var tag = call.argument<String>("tag")
    if (tag != null) {
      tag = tag
    } else {
      tag = "Riyu"
    }
    Log.d(tag, message)
    result.success(message)
  }

  private fun colors(color: String, text: String): String {
    val red = "\u001b[31m"
    val green = "\u001b[32m"
    val yellow = "\u001b[33m"
    val blue = "\u001b[34m"
    val magenta = "\u001b[35m"
    val cyan = "\u001b[36m"
    val white = "\u001b[37m"
    val black = "\u001b[30m"
    val orange = "\u001b[38;5;208m"
    val purple = "\u001b[38;5;141m"
    val reset = "\u001b[0m"

    try {
      return when (color) {
        "red" -> "$red$text$reset"
        "green" -> "$green$text$reset"
        "yellow" -> "$yellow$text$reset"
        "blue" -> "$blue$text$reset"
        "magenta" -> "$magenta$text$reset"
        "cyan" -> "$cyan$text$reset"
        "white" -> "$white$text$reset"
        "black" -> "$black$text$reset"
        "orange" -> "$orange$text$reset"
        "purple" -> "$purple$text$reset"
        else -> "$text"
      }
    } catch (e: Exception) {
      print(e)
      return "$text"
    }
  }

  override fun onNewIntent(intent: Intent) {
    super.onNewIntent(intent)
    val data = intent.data
    if (data != null) {
      deeplink = data
    }
  }

  var deeplink: Uri? = null

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    val data = intent.data
    if (data != null) {
      deeplink = data
    }
  }

  private fun getDeelink(): String {
    return deeplink.toString()
  }
}