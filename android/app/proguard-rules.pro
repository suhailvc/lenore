-keep class org.slf4j.** { *; }
-dontwarn org.slf4j.**
-dontwarn org.slf4j.impl.StaticLoggerBinder

-keep class com.myfatoorah.** { *; }
-keepclassmembers class com.myfatoorah.** { *; }
-keep class com.google.gson.** { *; }
-keepclassmembers class kotlin.** { *; }
-keep class kotlin.** { *; }
-keep class kotlinx.** { *; }

-keep class com.google.android.exoplayer2.** { *; }
-dontwarn com.google.android.exoplayer2.**
-keep class com.google.ads.interactivemedia.** { *; }
-dontwarn com.google.ads.interactivemedia.**

# ExoPlayer FirebaseAnalytics extension
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

-keep class com.google.android.gms.** { *; }
-keep class com.google.android.gms.wallet.** { *; }