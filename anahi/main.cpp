#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "engine.h"
#include "datosutilesmodel.h"
#include "clubesmodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    qmlRegisterType<DatosUtilesModel>("Backend", 1, 0, "DatosUtilesModel");
    qmlRegisterType<ClubesModel>("Backend", 1, 0, "ClubesModel");

    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();
    Engine eng;
    eng.init();
    context->setContextProperty("engine", &eng);

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
