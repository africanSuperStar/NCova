package com.forthepeople.uncovid.notifications_enabled

import androidx.core.app.NotificationManagerCompat
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class NotificationsEnabledPlugin(private val registrar: Registrar) : MethodCallHandler {

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "com.forthepeople.uncovid/notifications_enabled")
      channel.setMethodCallHandler(NotificationsEnabledPlugin(registrar))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getNotificationsEnabled") {
      result.success(NotificationManagerCompat.from(registrar.context().applicationContext).areNotificationsEnabled())
    } else {
      result.notImplemented()
    }
  }
}
