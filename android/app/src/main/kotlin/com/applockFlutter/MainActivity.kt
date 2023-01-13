@file:Suppress("DEPRECATION")

package com.applockFlutter

import android.annotation.SuppressLint
import android.app.AppOpsManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.os.Bundle
import android.provider.Settings
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.util.*


class MainActivity: FlutterActivity() {
    private val channel = "flutter.native/helper"
    private var appInfo: List<ApplicationInfo>? = null
    private var lockedAppList: List<ApplicationInfo> = emptyList()
    private var saveAppData: SharedPreferences? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        saveAppData =  applicationContext.getSharedPreferences("save_app_data", Context.MODE_PRIVATE)
        GeneratedPluginRegistrant.registerWith(FlutterEngine(this))
        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, result ->
            when {
                call.method.equals("addToLockedApps") -> {
                    val args = call.arguments as HashMap<*, *>
                    println("$args ----- ARGS")
                    val greetings = showCustomNotification(args)
                    result.success(greetings)
                }
                call.method.equals("setPasswordInNative") -> {
                    val args = call.arguments
                    val editor: SharedPreferences.Editor =   saveAppData!!.edit()
                    editor.putString("password", "$args")
                    editor.apply()
                    result.success("Success")
                }
                call.method.equals("checkOverlayPermission") -> {
                    result.success(Settings.canDrawOverlays(this))
                }
                call.method.equals("stopForeground") -> {
                    stopForegroundService()
                }
                call.method.equals("askOverlayPermission") -> {
                    result.success(checkOverlayPermission())
                }
                call.method.equals("askUsageStatsPermission") -> {
                    if (!isAccessGranted()) {
                        val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
                        startActivity(intent)
                    }
                }
            }
        }
    }

    @SuppressLint("CommitPrefEdits", "LaunchActivityFromNotification")
    private fun showCustomNotification(args: HashMap<*, *>):String {
        lockedAppList = emptyList()
//        val mContentView = RemoteViews(packageName, R.layout.list_view)

        appInfo  = packageManager.getInstalledApplications(PackageManager.GET_META_DATA)

        val arr : ArrayList<Map<String,*>> = args["app_list"]  as ArrayList<Map<String,*>>

        for (element in arr){
            run breaking@{
                for (i in appInfo!!.indices){
                    if(appInfo!![i].packageName.toString() == element["package_name"].toString()){
                        val ogList = lockedAppList
                        lockedAppList = ogList + appInfo!![i]
                        return@breaking
                    }
                }
            }
        }


        var packageData:List<String> = emptyList()

        for(element in lockedAppList){
            val ogList = packageData
            packageData = ogList + element.packageName
        }

        val editor: SharedPreferences.Editor =  saveAppData!!.edit()
        editor.remove("app_data")
        editor.putString("app_data", "$packageData")
        editor.apply()

        startForegroundService()

        return "Success"
    }

    private fun setIfServiceClosed(data:String){
        val editor: SharedPreferences.Editor =  saveAppData!!.edit()
        editor.putString("is_stopped",data)
        editor.apply()
    }

    private fun startForegroundService() {
        if (Settings.canDrawOverlays(this)) {
            setIfServiceClosed("1")
            ContextCompat.startForegroundService(this, Intent(this, ForegroundService::class.java))
        }
    }

   private fun stopForegroundService(){
       setIfServiceClosed("0")
       stopService( Intent(this, ForegroundService::class.java))
   }

    private fun checkOverlayPermission():Boolean {
        if (!Settings.canDrawOverlays(this)) {
            val myIntent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION)
            startActivity(myIntent)
        }
        return Settings.canDrawOverlays(this)
    }

    private fun isAccessGranted(): Boolean {
        return try {
            val packageManager = packageManager
            val applicationInfo = packageManager.getApplicationInfo(
                    packageName, 0
            )
            val appOpsManager: AppOpsManager = getSystemService(APP_OPS_SERVICE) as AppOpsManager
            val mode = appOpsManager.checkOpNoThrow(
                    AppOpsManager.OPSTR_GET_USAGE_STATS,
                    applicationInfo.uid, applicationInfo.packageName
            )
            mode == AppOpsManager.MODE_ALLOWED
        } catch (e: PackageManager.NameNotFoundException) {
            false
        }
    }
}

