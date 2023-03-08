package com.applockFlutter

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.app.usage.UsageEvents
import android.app.usage.UsageStatsManager
import android.content.*
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.view.View
import androidx.core.app.NotificationCompat
import java.util.*


class ForegroundService : Service() {
    override fun onBind(intent: Intent): IBinder? {
        throw UnsupportedOperationException("")
    }
    var timer: Timer = Timer()
    var isTimerStarted = false
    var timerReload:Long = 500
    var currentAppActivityList = arrayListOf<String>()
    private var mHomeWatcher = HomeWatcher(this)

    override fun onCreate() {
        super.onCreate()
        val channelId = "AppLock-10"
        val channel = NotificationChannel(
            channelId,
            "Channel human readable title",
            NotificationManager.IMPORTANCE_DEFAULT
        )
        (getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager).createNotificationChannel(
            channel
        )
        val notification = NotificationCompat.Builder(this, channelId)
            .setContentTitle("")
            .setContentText("").build()
        startForeground(1, notification)
        startMyOwnForeground()

    }

    override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {
        return super.onStartCommand(intent, flags, startId)
    }

    private fun startMyOwnForeground() {
        val window = Window(this)
        mHomeWatcher.setOnHomePressedListener(object : HomeWatcher.OnHomePressedListener {
            override fun onHomePressed() {
                println("onHomePressed")
                currentAppActivityList.clear()
                if(window.isOpen()){
                    window.close()
                }
            }
            override fun onHomeLongPressed() {
                println("onHomeLongPressed")
                currentAppActivityList.clear()
                if(window.isOpen()){
                    window.close()
                }
            }
        })
        mHomeWatcher.startWatch()
        timerRun(window)
    }

    override fun onDestroy() {
        timer.cancel()
        mHomeWatcher.stopWatch()
        super.onDestroy()
    }

    private fun timerRun(window:Window){
        timer.scheduleAtFixedRate(object : TimerTask() {
            override fun run() {
                isTimerStarted = true
                isServiceRunning(window)
            }
        }, 0, timerReload)
    }


    fun isServiceRunning(window:Window) {

        val saveAppData: SharedPreferences = applicationContext.getSharedPreferences("save_app_data", Context.MODE_PRIVATE)
        val lockedAppList: List<*> = saveAppData.getString("app_data", "AppList")!!.replace("[", "").replace("]", "").split(",")

        val mUsageStatsManager = getSystemService(USAGE_STATS_SERVICE) as UsageStatsManager
        val time = System.currentTimeMillis()

        val usageEvents = mUsageStatsManager.queryEvents(time - timerReload, time)
        val event = UsageEvents.Event()

        run breaking@{
            while (usageEvents.hasNextEvent()) {
                usageEvents.getNextEvent(event)
                for (element in lockedAppList) if(event.packageName.toString().trim() == element.toString().trim()){
                    println("${event.className} $element ${event.eventType}-----------Event Type")
                        if(event.eventType == UsageEvents.Event.ACTIVITY_RESUMED && currentAppActivityList.isEmpty())  {
                            currentAppActivityList.add(event.className)
                            println("$currentAppActivityList-----List--added")
                            window.txtView!!.visibility = View.INVISIBLE
                            Handler(Looper.getMainLooper()).post {
                                window.open()
                            }
                            return@breaking
                        }else if(event.eventType == UsageEvents.Event.ACTIVITY_RESUMED){
                            if(!currentAppActivityList.contains(event.className)){
                                currentAppActivityList.add(event.className)
                                println("$currentAppActivityList-----List--added")
                            }
                        }else if(event.eventType == UsageEvents.Event.ACTIVITY_STOPPED ){
                            if(currentAppActivityList.contains(event.className)){
                                currentAppActivityList.remove(event.className)
                                println("$currentAppActivityList-----List--remained")
                            }
                        }
                }
            }
        }
    }
}

