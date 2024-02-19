package com.example.playgroundnative

import android.Manifest
import android.content.pm.PackageManager
import android.os.Bundle
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.example.playgroundnative.TimeHandler
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val contactChannel = "flutter.demo/contacts"

    private val timerEventChannel = "flutter.demo/timer"

    private val permissionRequestCode = 123

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Check if the permission is not granted
        if (ContextCompat.checkSelfPermission(
                this,
                Manifest.permission.READ_CONTACTS
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            // Request the permission
            ActivityCompat.requestPermissions(
                this,
                arrayOf(Manifest.permission.READ_CONTACTS),
                permissionRequestCode
            )
        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, contactChannel).setMethodCallHandler {
                call, result ->
            if (call.method == "getContacts") {
                try {
                    val contactsService = ContactsService(context);
                    result.success(contactsService.fetchContacts());
                } catch (e: Error) {
                    result.error("An error occured", "Impossible to fetch contacts.", null)
                }
            } else {
                result.notImplemented()
            }
        }

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, timerEventChannel).setStreamHandler(
            TimeHandler
        )
    }
}

