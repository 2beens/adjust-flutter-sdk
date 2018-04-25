package com.adjust.sdk.adjustsdkplugin;

import android.content.Context;

import com.adjust.sdk.Adjust;
import com.adjust.sdk.AdjustConfig;

import java.util.Map;

/**
 * com.adjust.sdk.adjustsdkplugin
 * Created by 2beens on 25.04.18.
 */
public class AdjustBridgeInstance {
    public void onCreate(Context context, Map adjustConfigMap) {
        String appToken = (String) adjustConfigMap.get("appToken");
        String environment = (String) adjustConfigMap.get("environment");

        AdjustConfig config = new AdjustConfig(context, appToken, environment);
        String userAgent = (String) adjustConfigMap.get("userAgent");
        config.setUserAgent(userAgent);

        AdjustSdkPlugin.log("Calling onCreate with values:");
        AdjustSdkPlugin.log("\tappToken: " + appToken);
        AdjustSdkPlugin.log("\tenvironment: " + environment);
        AdjustSdkPlugin.log("\tuserAgent: " + userAgent);

        Adjust.onCreate(config);
    }

    public boolean isEnabled() {
        return Adjust.isEnabled();
    }

    public void onResume() {
        Adjust.onResume();
    }
}
