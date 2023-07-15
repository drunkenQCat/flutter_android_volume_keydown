package dev.darttools.flutter_android_volume_keydown;

import static android.view.KeyEvent.KEYCODE_VOLUME_DOWN;
import static android.view.KeyEvent.KEYCODE_VOLUME_UP;
import static android.view.KeyEvent.KEYCODE_POWER;

import static dev.darttools.flutter_android_volume_keydown.FlutterAndroidVolumeKeydownPlugin.eventSink;

import android.view.KeyEvent;

import java.io.Console;

import io.flutter.embedding.android.FlutterActivity;

public class FlutterAndroidVolumeKeydownActivity extends FlutterActivity {
    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if(keyCode == KEYCODE_VOLUME_DOWN && eventSink != null) {
            eventSink.success(0);
            return true;
        }
        if(keyCode == KEYCODE_VOLUME_UP && eventSink != null) {
            eventSink.success(1);
            return true;
        }
        if(keyCode == KEYCODE_POWER && eventSink != null) {
            eventSink.success(2);
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }
    @Override
    public boolean onKeyLongPress(int keyCode, KeyEvent event) {
        throw new RuntimeException("Stub!");
    }

    @Override
    public boolean onKeyUp(int keyCode, KeyEvent event) {
        throw new RuntimeException("Stub!");
    }

    @Override
    public boolean onKeyMultiple(int keyCode, int repeatCount, KeyEvent event) {
        if(keyCode == KEYCODE_VOLUME_DOWN && eventSink != null) {
            if (repeatCount == 2) eventSink.success(3);
            if (repeatCount == 3) eventSink.success(6);
            return true;
        }
        if(keyCode == KEYCODE_VOLUME_UP && eventSink != null && repeatCount == 2) {
            if (repeatCount == 2) eventSink.success(4);
            if (repeatCount == 3) eventSink.success(7);
            return true;
        }
        if(keyCode == KEYCODE_POWER && eventSink != null && repeatCount == 2) {
            if (repeatCount == 2) eventSink.success(5);
            if (repeatCount == 3) eventSink.success(8);
            return true;
        }
        return super.onKeyMultiple(keyCode, repeatCount, event);
    }

    @Override
    public void onBackPressed() {
        throw new RuntimeException("Stub!");
    }
}