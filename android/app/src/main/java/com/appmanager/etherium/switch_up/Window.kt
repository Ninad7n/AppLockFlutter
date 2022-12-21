package com.applockFlutter

import android.annotation.SuppressLint
import android.content.Context
import android.content.SharedPreferences
import android.graphics.PixelFormat
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.*
import android.widget.TextView
import androidx.core.content.ContextCompat
import com.andrognito.pinlockview.IndicatorDots
import com.andrognito.pinlockview.PinLockListener
import com.andrognito.pinlockview.PinLockView
import com.applockFlutter.R


@SuppressLint("InflateParams")
class Window(
		private val context: Context
) {
	private val mView: View
	var pinCode: String = ""
	var txtView: TextView? = null
	private var mParams: WindowManager.LayoutParams? = null
	private val mWindowManager: WindowManager
	private val layoutInflater: LayoutInflater

	private var mPinLockView: PinLockView? = null
	private var mIndicatorDots: IndicatorDots? = null
	private val mPinLockListener: PinLockListener = object : PinLockListener {

		@SuppressLint("LogConditional")
		override fun onComplete(pin: String) {
			Log.d(PinCodeActivity.TAG, "Pin complete: $pin")
			pinCode = pin
			doneButton()
		}

		override fun onEmpty() {
			Log.d(PinCodeActivity.TAG, "Pin empty")
		}

		@SuppressLint("LogConditional")
		override fun onPinChange(pinLength: Int, intermediatePin: String) {}
	}

	fun open() {
		try {
			if (mView.windowToken == null) {
				if (mView.parent == null) {
					mWindowManager.addView(mView, mParams)
				}
			}
		} catch (e: Exception) {
			e.printStackTrace()
		}
	}

	fun isOpen():Boolean{
		return (mView.windowToken != null && mView.parent != null)
	}

	fun close() {
		try {
			Handler(Looper.getMainLooper()).postDelayed({
				(context.getSystemService(Context.WINDOW_SERVICE) as WindowManager).removeView(mView)
				mView.invalidate()
			},500)

		} catch (e: Exception) {
			e.printStackTrace()
		}
	}

	fun doneButton(){
		try {
			mPinLockView!!.resetPinLockView()
			val saveAppData: SharedPreferences = context.getSharedPreferences("save_app_data", Context.MODE_PRIVATE)
			val dta: String = saveAppData.getString("password", "PASSWORD")!!
			if(pinCode == dta){
				println("$pinCode---------------pincode")
				close()
			}else{
				txtView!!.visibility = View.VISIBLE
			}
		} catch (e: Exception) {
			println("$e---------------doneButton")
		}
	}

	init {

		mParams = WindowManager.LayoutParams(
				WindowManager.LayoutParams.MATCH_PARENT,
				WindowManager.LayoutParams.MATCH_PARENT,
				WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY,
				WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN,
				PixelFormat.TRANSLUCENT
		)
		layoutInflater = context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
		mView = layoutInflater.inflate(R.layout.pin_activity, null)

		mParams!!.gravity = Gravity.CENTER
		mWindowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager

		mPinLockView = mView.findViewById(R.id.pin_lock_view)
		mIndicatorDots = mView.findViewById(R.id.indicator_dots)
		txtView = mView.findViewById(R.id.alertError) as TextView



		mPinLockView!!.attachIndicatorDots(mIndicatorDots)
		mPinLockView!!.setPinLockListener(mPinLockListener)
		mPinLockView!!.pinLength = 6
		mPinLockView!!.textColor = ContextCompat.getColor(context, R.color.ic_launcher_background)
		mIndicatorDots!!.indicatorType = IndicatorDots.IndicatorType.FILL_WITH_ANIMATION

	}

}