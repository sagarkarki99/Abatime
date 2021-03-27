package com.sagarkarki92.abatime;

import android.graphics.Color;
import android.media.Image;
import android.view.LayoutInflater;
import android.widget.ImageView;
import android.widget.TextView;

import com.google.android.gms.ads.formats.UnifiedNativeAd;
import com.google.android.gms.ads.formats.UnifiedNativeAdView;

import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory;

import java.util.Map;

class NativeAdView implements NativeAdFactory {
    private final LayoutInflater layoutInflater;

    NativeAdView(LayoutInflater layoutInflater) {
        this.layoutInflater = layoutInflater;
    }

    @Override
    public UnifiedNativeAdView createNativeAd(
            UnifiedNativeAd nativeAd, Map<String, Object> customOptions) {
        final UnifiedNativeAdView adView =
                (UnifiedNativeAdView) layoutInflater.inflate(R.layout.native_ad, null);
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