/*
 * Copyright (C) 2014 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "androidactivity.h"

#if defined(Q_OS_ANDROID)

#include <QDebug>
#include <QGuiApplication>
#include <QKeyEvent>
#include <QQuickWindow>
#include <android/input.h>
#include <cassert>
#include <cmath>

#include <QtAndroidExtras/QtAndroidExtras>

#define JAVA_PACKAGE_PREFIX "anahi/"

jobject AndroidActivity::sActivity = nullptr;

jclass AndroidActivity::sActivityClass = nullptr;
jclass AndroidActivity::sSoundManagerClass = nullptr;
jclass AndroidActivity::sMotionEventClass = nullptr;
jclass AndroidActivity::sKeyEventClass = nullptr;
jclass AndroidActivity::sInputDeviceClass = nullptr;
jclass AndroidActivity::sMotionRangeClass = nullptr;
jclass AndroidActivity::sDebugClass = nullptr;

JavaVM* AndroidActivity::sJavaVM = nullptr;

SelfDetachingJNIEnv AndroidActivity::getEnv(JavaVM* vm) {
    if (vm) {
        sJavaVM = vm;
    }
    return SelfDetachingJNIEnv::fromJVM(sJavaVM);
}

void AndroidActivity::onCreate(JNIEnv* jni, jobject activity) {
    qDebug() << "In Native onCreate";

    if (!sActivity) {
        sActivity = jni->NewGlobalRef(activity);
    }
}

void AndroidActivity::onStart() {
    qDebug() << "In Native onStart";
    /*Engine* engine = Engine::getInstance(false);
    if (engine) {
        engine->onDeviceStart();
    }*/
}

void AndroidActivity::onResume() {
    qDebug() << "In Native onResume";
/*    Engine* engine = Engine::getInstance(false);
    if (engine) {
        // TODO: turn this into a signal/slot somehow.
        engine->onDeviceResume();
    }*/
}

void AndroidActivity::onPause() {
    qDebug() << "In Native onPause";
/*    Engine* engine = Engine::getInstance(false);
    if (engine) {
        // TODO: turn this into a signal/slot somehow.
        engine->onDevicePause();
    }*/
}

void AndroidActivity::onStop() {
    qDebug() << "In Native onStop";

/*    Engine* engine = Engine::getInstance(false);
    if (engine) {
        engine->onDeviceStop();
    }*/
}

void AndroidActivity::onDestroy(JNIEnv* jni, jobject) {
    qDebug() << "In Native onDestroy";

    // Must delete reference to Android Activity to make sure it doesn't leak.
    if (sActivity) {
        jni->DeleteGlobalRef(sActivity);
        sActivity = nullptr;
    }

    /*Engine* engine = Engine::getInstance(false);
    if (engine) {
        engine->onDeviceDestroy();
    }*/
}

QString AndroidActivity::getVersionName() {
    auto jni = getEnv();
    if (!jni || !getActivity()) {
        return QString();
    }
    jclass activityClass = getActivityClass(jni.getJNIEnv());
    jmethodID getVersionNameMethod = jni->GetMethodID(activityClass, "getVersionName",
            "()Ljava/lang/String;");
    jstring javaVersionName = reinterpret_cast<jstring>(jni->CallObjectMethod(getActivity(),
            getVersionNameMethod));
    if (!javaVersionName) {
        return QString();
    }
    const char* nativeVersionName = jni->GetStringUTFChars(javaVersionName, nullptr);
    QString versionName = QString::fromUtf8(nativeVersionName);
    jni->ReleaseStringUTFChars(javaVersionName, nativeVersionName);
    jni->DeleteLocalRef(javaVersionName);
    return versionName;
}

long AndroidActivity::getMemoryUsed() {
    auto jni = getEnv();
    if (!jni) {
        return 0;
    }
    jclass debugClass = getDebugClass(jni.getJNIEnv());
    jmethodID getNativeHeapAllocatedSizeMethod = jni->GetStaticMethodID(debugClass,
            "getNativeHeapAllocatedSize", "()J");
    return jni->CallStaticLongMethod(debugClass, getNativeHeapAllocatedSizeMethod, -1);
}

jobject AndroidActivity::getSoundManager() {
    auto jni = getEnv();
    if (!jni || !getActivity()) {
        return nullptr;
    }
    jclass activityClass = getActivityClass(jni.getJNIEnv());
    jmethodID getSoundManagerMethod = jni->GetMethodID(activityClass, "getSoundManager",
            "()L" JAVA_PACKAGE_PREFIX "utils/SoundManager;");
    return jni->CallObjectMethod(getActivity(), getSoundManagerMethod);
}

jclass AndroidActivity::getActivityClass(JNIEnv* jni, jobject activity)  {
    if (!sActivityClass) {
        // TODO: remove voltAir reference.
        sActivityClass = reinterpret_cast<jclass>(jni->NewGlobalRef(
                (activity) ? jni->GetObjectClass(activity)
                           : jni->FindClass(JAVA_PACKAGE_PREFIX "AnahiActivity")));
        assert(sActivityClass);
    }
    return sActivityClass;
}

jclass AndroidActivity::getInputDeviceClass(JNIEnv* jni, jobject inputDevice) {
    if (!sInputDeviceClass && inputDevice) {
        sInputDeviceClass = reinterpret_cast<jclass>(jni->NewGlobalRef(
                (inputDevice) ? jni->GetObjectClass(inputDevice)
                              : jni->FindClass("android/view/InputDevice")));
    }
    return sInputDeviceClass;
}

jclass AndroidActivity::getMotionRangeClass(JNIEnv* jni, jobject motionRange) {
    if (!sMotionRangeClass && motionRange) {
        sMotionRangeClass = reinterpret_cast<jclass>(jni->NewGlobalRef(
                (motionRange) ? jni->GetObjectClass(motionRange)
                              : jni->FindClass("android/view/InputDevice$MotionRange")));
    }
    return sMotionRangeClass;
}

jclass AndroidActivity::getDebugClass(JNIEnv *jni) {
    if (!sDebugClass) {
        sDebugClass = reinterpret_cast<jclass>(jni->NewGlobalRef(
                jni->FindClass("android/os/Debug")));
    }
    return sDebugClass;
}


#endif // Q_OS_ANDROID
