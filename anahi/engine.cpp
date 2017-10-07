#include "engine.h"
#include <QtAndroidExtras/QtAndroidExtras>
#include <jni.h>
#include <QtAndroidExtras/QtAndroidExtras>
#include <QtAndroidExtras/QAndroidJniObject>
#include <QDebug>
#include <QMap>
#include <QPair>

QMap<int, QPair<QString, QString>> Engine::_auspiciantes;
int Engine::_currentIdAuspiciante = 0;
Engine::Engine(QObject *parent) : QObject(parent)
{

}

void Engine::init()
{
    _auspiciantes[0] = QPair<QString, QString>("qrc:///auspiciantes/chistik.png", "http://farmaciachistik.com/");
    //    _auspiciantes[1] = QPair<QString, QString>("qrc:///auspiciantes/grupo-arroba.png", "https://www.grupoarroba.com.ar/");
    _auspiciantes[1] = QPair<QString, QString>("qrc:///auspiciantes/casaBernabe.png","http://casabernabesca.com.ar/");
    _auspiciantes[2] = QPair<QString, QString>("qrc:///auspiciantes/motostart.png","mailto:marzullo.motostart@gmail.com");
    _auspiciantes[3] = QPair<QString, QString>("qrc:///auspiciantes/colegioRosarioVeraPenaloza.png", "http://www.colegioverapeñaloza.com.ar");
    _auspiciantes[4] = QPair<QString, QString>("qrc:///auspiciantes/conteba.png", "http://www.contebaservicios.com.ar/");
    _auspiciantes[5] = QPair<QString, QString>("qrc:///auspiciantes/tecnoServicios.png", "http://www.tecnoservicios.com.ar");
    //_auspiciantes[0] = QPair<QString, QString>("CENTRO OPTICO LOURO -
    //        _auspiciantes[0] = QPair<QString, QString>("FRIGORIFICO VIÑUELA -
    //        _auspiciantes[0] = QPair<QString, QString>("YPF PARA YPF FULL -
    //_auspiciantes[4] = QPair<QString, QString>("CERVEZA IMPERIAL COCA - COLA -
}

void Engine::launchMap()
{
    QAndroidJniObject result = QAndroidJniObject::callStaticObjectMethod<jstring>("anahi/AnahiActivity",
                                                                                  "startMapNavigation"/*,
                                                                                                                         "()Ljava/lang/String;"*/);
    qDebug() << result.toString();
}


void Engine::launchHistoria()
{
    QAndroidJniObject result = QAndroidJniObject::callStaticObjectMethod<jstring>("anahi/AnahiActivity",
                                                                                  "startWebHistoria"/*,
                                                                                                                     "()Ljava/lang/String;"*/);
    qDebug() << result.toString();

}

void Engine::launchURL(const QString &url)
{
    QAndroidJniObject result = QAndroidJniObject::callStaticObjectMethod("anahi/AnahiActivity",
                                                                         "startURL",
                                                                         "(Ljava/lang/String;)Ljava/lang/String;",
                                                                         QAndroidJniObject::fromString(url).object<jstring>()
                                                                         );
    qDebug() << result.toString();
}

void Engine::launchMapNavigation(const QString &location)
{
    QAndroidJniObject result = QAndroidJniObject::callStaticObjectMethod("anahi/AnahiActivity",
                                                                         "launchMapNavigation",
                                                                         "(Ljava/lang/String;)Ljava/lang/String;",
                                                                         QAndroidJniObject::fromString(location).object<jstring>()
                                                                         );
    qDebug() << result.toString();
}

void Engine::call(const QString &phoneNumber)
{
    QAndroidJniObject result = QAndroidJniObject::callStaticObjectMethod("anahi/AnahiActivity",
                                                                         "call",
                                                                         "(Ljava/lang/String;)Ljava/lang/String;",
                                                                         QAndroidJniObject::fromString(phoneNumber).object<jstring>()
                                                                         );
    qDebug() << result.toString();
}

void Engine::sendWhatsApp(const QString &phoneNumber)
{
    QAndroidJniObject result = QAndroidJniObject::callStaticObjectMethod("anahi/AnahiActivity",
                                                                         "sendWhatsApp",
                                                                         "(Ljava/lang/String;)Ljava/lang/String;",
                                                                         QAndroidJniObject::fromString(phoneNumber).object<jstring>()
                                                                         );
    qDebug() << result.toString();
}


int Engine::getIdAuspiciante()
{
    qDebug() << _currentIdAuspiciante;
    qDebug() << _auspiciantes.count();
    if (_currentIdAuspiciante >= _auspiciantes.count() -1)
    {
        _currentIdAuspiciante = 0;
    }
    else
    {
        ++_currentIdAuspiciante;
    }
    return _currentIdAuspiciante;
}

QString Engine::getImageAuspiciante(int idAuspiciante)
{
    return _auspiciantes[idAuspiciante].first;
}

QString Engine::getURLAuspiciante(int idAuspiciante)
{
    return _auspiciantes[idAuspiciante].second;
}
