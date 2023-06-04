package com.rtnmaxmodule

import com.facebook.react.bridge.Callback
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.rtnmaxmodule.NativeMaxModuleSpec
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import java.util.UUID

class MaxModule(reactContext: ReactApplicationContext) : NativeMaxModuleSpec(reactContext) {

  override fun getName() = NAME

  override fun callApi(promise: Promise) {
    promise.resolve(true)
  }

  private val scope = CoroutineScope(Dispatchers.Default + Job())

  private val callbackIds = mutableMapOf<String, String>()

  override fun callApiAsync(params: String?, callback: Callback?): String {
    val callbackId = UUID.randomUUID().toString()

    scope.launch {
      callbackIds[callbackId] = ""
      // simulate request
      delay(2600)

      val result = mapOf(
        "status" to 200,
        "response" to mapOf(
          "name" to "minhnh",
          "age" to 20
        )
      )
      callback?.invoke(result.toString())
      callbackIds.remove(callbackId)
    }
    return callbackId
  }

  companion object {
    const val NAME = "RTNMaxModule"
  }
}