import android.annotation.SuppressLint
import android.content.Context
import android.util.Log
import androidx.core.content.ContextCompat
import com.andrognito.pinlockview.IndicatorDots
import com.andrognito.pinlockview.PinLockListener
import com.andrognito.pinlockview.PinLockView
import com.applockFlutter.R


class PinCodeActivity(
        private val context: Context
) {

    var pinCode: String = ""

    private var mPinLockView: PinLockView? = null

    private var mIndicatorDots: IndicatorDots? = null
    private val mPinLockListener: PinLockListener = object : PinLockListener {
        @SuppressLint("LogConditional")
        override fun onComplete(pin: String) {
            Log.d(TAG, "Pin complete: $pin")
            pinCode = pin
        }

        override fun onEmpty() {
            Log.d(TAG, "Pin empty")
            pinCode = ""
        }

        @SuppressLint("LogConditional")
        override fun onPinChange(pinLength: Int, intermediatePin: String) {
            pinCode = intermediatePin
            Log.d(
                TAG,
                "Pin changed, new length $pinLength with intermediate pin $intermediatePin"
            )
        }
    }

    init {
        try{
//            setContentView(R.layout.pin_activity)
//            mPinLockView = findViewById(R.id.pin_lock_view)
//            mIndicatorDots = findViewById(R.id.indicator_dots)
            mPinLockView!!.attachIndicatorDots(mIndicatorDots)
            mPinLockView!!.setPinLockListener(mPinLockListener)
            println("Pincode class Activated--2")
//        mPinLockView.setCustomKeySet(new int[]{2, 3, 1, 5, 9, 6, 7, 0, 8, 4});
//        mPinLockView.enableLayoutShuffling();
            mPinLockView!!.pinLength = 6
            mPinLockView!!.textColor = ContextCompat.getColor(context, R.color.ic_launcher_background)
            mIndicatorDots!!.indicatorType = IndicatorDots.IndicatorType.FILL_WITH_ANIMATION

        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

//     override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
////        requestWindowFeature(Window.FEATURE_NO_TITLE)
////        window.setFlags(
////            WindowManager.LayoutParams.FLAG_FULLSCREEN,
////            WindowManager.LayoutParams.FLAG_FULLSCREEN
////        )
//        println("Pincode class Activated")
//        try{
////            setContentView(R.layout.pin_activity)
//            mPinLockView = findViewById(R.id.pin_lock_view)
//            mIndicatorDots = findViewById(R.id.indicator_dots)
//            mPinLockView!!.attachIndicatorDots(mIndicatorDots)
//            mPinLockView!!.setPinLockListener(mPinLockListener)
//            println("Pincode class Activated--2")
////        mPinLockView.setCustomKeySet(new int[]{2, 3, 1, 5, 9, 6, 7, 0, 8, 4});
////        mPinLockView.enableLayoutShuffling();
//            mPinLockView!!.pinLength = 6
//            mPinLockView!!.textColor = ContextCompat.getColor(this, R.color.white)
//            mIndicatorDots!!.indicatorType = IndicatorDots.IndicatorType.FILL_WITH_ANIMATION
//
//        } catch (e: Exception) {
//            e.printStackTrace()
//        }
//    }


//    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
//        super.onCreate(savedInstanceState, persistentState)
//        requestWindowFeature(Window.FEATURE_NO_TITLE)
////        window.setFlags(
////            WindowManager.LayoutParams.FLAG_FULLSCREEN,
////            WindowManager.LayoutParams.FLAG_FULLSCREEN
////        )
//        println("Pincode class Activated")
//        try{
//            setContentView(R.layout.pin_activity)
//            mPinLockView = findViewById(R.id.pin_lock_view)
//            mIndicatorDots = findViewById(R.id.indicator_dots)
//            mPinLockView!!.attachIndicatorDots(mIndicatorDots)
//            mPinLockView!!.setPinLockListener(mPinLockListener)
//            println("Pincode class Activated--2")
////        mPinLockView.setCustomKeySet(new int[]{2, 3, 1, 5, 9, 6, 7, 0, 8, 4});
////        mPinLockView.enableLayoutShuffling();
//            mPinLockView!!.pinLength = 6
//            mPinLockView!!.textColor = ContextCompat.getColor(this, R.color.white)
//            mIndicatorDots!!.indicatorType = IndicatorDots.IndicatorType.FILL_WITH_ANIMATION
//
//        } catch (e: Exception) {
//            e.printStackTrace()
//        }
//    }

    companion object {
        const val TAG = "PinLockView"
    }
}
//override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
//    super.onCreate(savedInstanceState, persistentState)
//    requestWindowFeature(Window.FEATURE_NO_TITLE)
////        window.setFlags(
////            WindowManager.LayoutParams.FLAG_FULLSCREEN,
////            WindowManager.LayoutParams.FLAG_FULLSCREEN
////        )
//    println("Pincode class Activated")
//    try{
//        setContentView(R.layout.pin_activity)
//        mPinLockView = findViewById(R.id.pin_lock_view)
//        mIndicatorDots = findViewById(R.id.indicator_dots)
//        mPinLockView!!.attachIndicatorDots(mIndicatorDots)
//        mPinLockView!!.setPinLockListener(mPinLockListener)
////        mPinLockView.setCustomKeySet(new int[]{2, 3, 1, 5, 9, 6, 7, 0, 8, 4});
////        mPinLockView.enableLayoutShuffling();
//        mPinLockView!!.pinLength = 6
//        mPinLockView!!.textColor = ContextCompat.getColor(this, R.color.white)
//        mIndicatorDots!!.indicatorType = IndicatorDots.IndicatorType.FILL_WITH_ANIMATION
//
//    } catch (e: Exception) {
//        e.printStackTrace()
//    }
//}