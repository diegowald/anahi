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

#ifndef ANDROIDACTIVITY_H
#define ANDROIDACTIVITY_H

#include <QObject>

#if defined(Q_OS_ANDROID)

//#include <GameInput/JoystickAxisCodes.h>
//#include <GameInput/KeyCodes.h>
//#include <GameInput/TriggerAxisCodes.h>
#include <QEvent>
#include <QMap>
#include <QSet>
#include <jni.h>
#include "selfdetachingjnienv.h"

class ControllerEvent;
class QKeyEvent;

/**
 * @ingroup Engine
 * @brief JNI interface for the main Android activity.
 *
 * This static class contains both native callbacks used by the Android activity and methods that
 * invoke their Java counterpart.
 * @note Users of this class should be aware of the different calling threads and contexts which
 * exist. Native callbacks are executing on the Android Ui (i.e. main activity looper thread), but
 * this thread is typically synchronized against the native Qt Ui thread and should not generally
 * pose thread-safety issues.
 * @note Native callbacks first two parameters are always the current JNI environment (a @c JNIEnv
 * pointer) and a reference (a @c jobject) to the invoking Android activity, unless the function has
 * no additional parameters in which case they can be removed. The convention assumed for this class
 * is to make either of these first two parameters nameless if they are unused in the callback (i.e.
 * the callback does not make calls back across the JNI boundary into Java).
 */
class AndroidActivity {
public:
    /**
     * @brief Returns the current JNI environment.
     * @note This method will cache the JVM reference so future calls do not need to provide it.
     * @param vm JavaVM to load the current environment from
     */
    static SelfDetachingJNIEnv getEnv(JavaVM* vm = nullptr);
    /**
     * @brief Returns the currently cached reference to the JVM.
     */
    static JavaVM* getJavaVM() { return sJavaVM; }

    /**
     * @brief Returns the currently cached reference to the Android activity.
     */
    static jobject getActivity() { return sActivity; }
    /**
     * @brief Returns a cached global reference to the Android activity class.
     * @note If currently unavailable, this method will load the activity class from @p env by
     * either looking through the @c CLASSPATH for the class or by retrieving the class of @p
     * activity if it is provided.
     * @param env Environment to load the activity class from
     * @param activity Optional activity object to use for class loading
     */
    static jclass getActivityClass(JNIEnv* env, jobject activity = nullptr);

    /**
     * @brief Returns whether or not the Android activity has been started previously, meaning all
     * future JNI calls should be safe to make.
     */
    static bool isStarted() { return sActivity; }

    /**
     * @ingroup JNINativeMethod
     * @brief Android activity @c onCreate lifecycle callback.
     * @param jni Current JNI environment
     * @param activity Object reference to invoking Android activity
     */
    static void onCreate(JNIEnv* jni, jobject activity);
    /**
     * @ingroup JNINativeMethod
     * @brief Android activity @c onStart lifecycle callback.
     */
    static void onStart();
    /**
     * @ingroup JNINativeMethod
     * @brief Android activity @c onResume lifecycle callback.
     */
    static void onResume();
    /**
     * @ingroup JNINativeMethod
     * @brief Android activity @c onPause lifecycle callback.
     */
    static void onPause();
    /**
     * @ingroup JNINativeMethod
     * @brief Android activity @c onStop lifecycle callback.
     */
    static void onStop();
    /**
     * @ingroup JNINativeMethod
     * @brief Android activity @c onDestroy lifecycle callback.
     * @param jni Current JNI environment
     * @param activity Object reference to invoking Android activity
     */
    static void onDestroy(JNIEnv* jni, jobject activity);

    /**
     * @brief Returns the version string of the Android application.
     */
    static QString getVersionName();
    /**
     * @brief Returns the number of bytes allocated for the native heap.
     */
    static long getMemoryUsed();


    /**
     * @brief onCallIncomming
     * @param env
     * @param obj
     */
    static void onCallIncomming(JNIEnv *env, jobject obj);

    /**
     * @brief onCallFinished
     * @param env
     * @param obj
     */
    static void onCallFinished(JNIEnv *env, jobject obj);

private:
    static jclass getInputDeviceClass(JNIEnv* jni, jobject inputDevice = nullptr);
    static jclass getMotionRangeClass(JNIEnv* jni, jobject motionRange = nullptr);
    static jclass getDebugClass(JNIEnv* jni);

    static int getMotionEventDeviceId(JNIEnv* jni, jobject motionEvent);
    static int getKeyAction(JNIEnv* jni, jobject keyEvent);
    static int getKeyEventDeviceId(JNIEnv* jni, jobject keyEvent);

    /**
     * Returns the axis value and the motion range values associated with the axis (if out params
     * are non-null).  If flatOut param is null, then the axis value returned is pre-flattened.
     */
    static float getAxisValue(JNIEnv* jni, jobject motionEvent, int axis, float* flatOut = nullptr,
            float* minOut = nullptr, float* rangeOut = nullptr);
    /**
     * Converts the axis value to be on a real scale from [-1, 1] for Joystick use.
     */
    static float getNormalizedJoystickAxisValue(JNIEnv* jni, jobject motionEvent, int axis);
    /**
     * Returns whether or not we should accept and consume Android events which have been translated
     * and possibly routed to VirtualControllers.
     */
    static bool shouldConsumeTranslatedEvents();
    static jobject getSoundManager();

    static jobject sActivity;

    static jclass sActivityClass;
    static jclass sSoundManagerClass;
    static jclass sMotionEventClass;
    static jclass sKeyEventClass;
    static jclass sInputDeviceClass;
    static jclass sMotionRangeClass;
    static jclass sDebugClass;

    static JavaVM* sJavaVM;
};

#endif // Q_OS_ANDROID
#endif // ANDROIDACTIVITY_H
