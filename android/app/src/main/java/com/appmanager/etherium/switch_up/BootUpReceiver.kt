package com.applockFlutter

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences

class BootUpReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent?) {
        val saveAppData: SharedPreferences = context.getSharedPreferences("save_app_data", Context.MODE_PRIVATE)
        if(saveAppData.getString("is_stopped","STOP") =="1"){
            context.startService(Intent(context, ForegroundService::class.java))
        }
    }
}