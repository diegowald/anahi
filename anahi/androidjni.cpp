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

#include <QObject>

#ifdef Q_OS_ANDROID

#include <QDebug>
#include "androidactivity.h"
#include "selfdetachingjnienv.h"

static const JNINativeMethod JNI_METHODS[] = {
    {
        "onApplicationCreate", "()V",
        reinterpret_cast<void*>(AndroidActivity::onCreate)
    },
    {
        "onApplicationStart", "()V",
        reinterpret_cast<void*>(AndroidActivity::onStart)
    },
    {
        "onApplicationResume", "()V",
        reinterpret_cast<void*>(AndroidActivity::onResume)
    },
    {
        "onApplicationPause", "()V",
        reinterpret_cast<void*>(AndroidActivity::onPause)
    },
    {
        "onApplicationStop", "()V",
        reinterpret_cast<void*>(AndroidActivity::onStop)
    },
    {
        "onApplicationDestroy", "()V",
        reinterpret_cast<void*>(AndroidActivity::onDestroy)
    },
};
static const int sNumOfJNIMethods = sizeof(JNI_METHODS) / sizeof(JNI_METHODS[0]);

JNIEXPORT jint JNI_OnLoad(JavaVM* vm, void* /* reserved */) {
    SelfDetachingJNIEnv jni = AndroidActivity::getEnv(vm);
    if (!jni) {
        return -1;
    }

    jclass activityClass = AndroidActivity::getActivityClass(jni.getJNIEnv());
    if (!activityClass) {
        qDebug() << "JNI cannot find Activity";
        return -1;
    }

    // Register our native methods
    if (jni->RegisterNatives(activityClass, JNI_METHODS, sNumOfJNIMethods) < 0) {
        qDebug() << "JNI: failed to register methods";
        return -1;
    }

    return JNI_VERSION_1_6;
}

#endif // Q_OS_ANDROID
