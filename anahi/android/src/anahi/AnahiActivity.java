package anahi;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;

public class AnahiActivity extends org.qtproject.qt5.android.bindings.QtActivity
{

  private static AnahiActivity m_Instance;

  public AnahiActivity() {
    m_Instance = this;
  }

  @Override
  public void onCreate(Bundle savedInstanceState) {
     super.onCreate(savedInstanceState);
      onApplicationCreate();
  }

  /**
   * @brief Called when the activity is finishing or being killed by the system.
   */
  @Override
  public void onDestroy() {
      super.onDestroy();
      onApplicationDestroy();
  }


  public static String startMapNavigation() {
    String uri = "http://maps.google.com/maps?daddr=-38.715921,-62.208452";// + location;
    //Uri.parse("http://maps.google.com/maps?saddr=20.344,34.34&daddr=20.5666,45.345"));

    Intent intent = new Intent(Intent.ACTION_VIEW, android.net.Uri.parse(uri));
    intent.setClassName("com.google.android.apps.maps", "com.google.android.maps.MapsActivity");
    if (intent.resolveActivity(m_Instance.getPackageManager()) != null) {
       m_Instance.startActivity(intent);
    }
    return "OK";
  }

  public static String startWebHistoria() {
    String url = "https://www.facebook.com/clubargentinobb/";
    Intent i = new Intent(Intent.ACTION_VIEW);
    i.setData(android.net.Uri.parse(url));
    m_Instance.startActivity(i);
    return "OK";
  }

  public static String startURL(String url) {
    Intent i = new Intent(Intent.ACTION_VIEW);
    i.setData(android.net.Uri.parse(url));
    m_Instance.startActivity(i);
    return "OK";
  }

  public static String launchMapNavigation(String location) {

    Intent intent = new Intent(Intent.ACTION_VIEW, android.net.Uri.parse(location));
    intent.setClassName("com.google.android.apps.maps", "com.google.android.maps.MapsActivity");
    if (intent.resolveActivity(m_Instance.getPackageManager()) != null) {
       m_Instance.startActivity(intent);
    }
    return "OK";
  }

  public static String call(String phoneNumber) {
    Intent intent = new Intent(Intent.ACTION_CALL, android.net.Uri.parse("tel:" + phoneNumber));
    m_Instance.startActivity(intent);
    return "OK";
  }

  public static String sendWhatsApp(String phoneNumber) {
    android.net.Uri uri = android.net.Uri.parse("smsto:" + phoneNumber);
    Intent i = new Intent(Intent.ACTION_SENDTO, uri);
    i.putExtra("sms_body", "sms");
    i.setPackage("com.whatsapp");
    m_Instance.startActivity(i);
    return "OK";
  }

  public native void onApplicationCreate();
  public native void onApplicationDestroy();
  public native void onApplicationStart();
  public native void onApplicationResume();
  public native void onApplicationPause();
  public native void onApplicationStop();
}
