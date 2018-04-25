package com.adjust.sdk.adjustsdkplugin;

import android.content.Context;

import java.util.Map;

/**
 * com.adjust.sdk.adjustsdkplugin
 * Created by 2beens on 25.04.18.
 */
public class AdjustBridge {
    private static AdjustBridgeInstance defaultInstance;

    public static synchronized AdjustBridgeInstance getDefaultInstance() {
        if (defaultInstance == null) {
            defaultInstance = new AdjustBridgeInstance();
        }
        return defaultInstance;
    }

    public static void onCreate(Context context, Map adjustConfigMap) {
        getDefaultInstance().onCreate(context, adjustConfigMap);
    }

    public static void onResume() {
        getDefaultInstance().onResume();
    }

    public static boolean isEnabled() {
        return getDefaultInstance().isEnabled();
    }
}
