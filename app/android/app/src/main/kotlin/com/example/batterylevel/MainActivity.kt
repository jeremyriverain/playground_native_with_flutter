package com.example.playgroundnative

import androidx.annotation.NonNull
import com.example.batterylevel.TimeHandler
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel

class MainActivity : FlutterActivity() {
    private val timerEventChannel = "flutter.demo/timer"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, timerEventChannel).setStreamHandler(
            TimeHandler
        )
    }
}
