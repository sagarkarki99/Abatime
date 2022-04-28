package com.sagarkarki92.abatime;

import android.graphics.Color;
import android.media.Image;
import android.view.LayoutInflater;
import android.widget.ImageView;
import android.widget.TextView;

import com.google.android.gms.ads.nativead.NativeAd;
import com.google.android.gms.ads.nativead.NativeAdView;

import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory;

import java.util.Map;

class CustomNativeAdView implements NativeAdFactory {
    private final LayoutInflater layoutInflater;

    CustomNativeAdView(LayoutInflater layoutInflater) {
        this.layoutInflater = layoutInflater;
    }

    @Override
    public NativeAdView createNativeAd(
           NativeAd nativeAd, Map<String, Object> customOptions) {
        final NativeAdView adView =
                (NativeAdView) layoutInflater.inflate(R.layout.native_ad, null);
        // final TextView headlineView = adView.findViewById(R.id.ad_headline);
        final ImageView imageView = adView.findViewById(R.id.ad_image);
        // headlineView.setText(nativeAd.getHeadline());
        imageView.setImageDrawable(nativeAd.getImages().get(0).getDrawable());
        adView.setBackgroundColor(Color.BLACK);

        adView.setNativeAd(nativeAd);
        adView.setImageView(imageView);
        // adView.setHeadlineView(headlineView);


        return adView;
    }
}