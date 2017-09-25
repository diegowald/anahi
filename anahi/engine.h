#ifndef ENGINE_H
#define ENGINE_H

#include <QObject>

class Engine : public QObject
{
    Q_OBJECT
public:
    explicit Engine(QObject *parent = nullptr);

    Q_INVOKABLE static void init();

    Q_INVOKABLE static void launchMap();
    Q_INVOKABLE static void launchHistoria();

    Q_INVOKABLE static int getIdAuspiciante();
    Q_INVOKABLE static QString getImageAuspiciante(int idAuspiciante);
    Q_INVOKABLE static QString getURLAuspiciante(int idAuspiciante);

    Q_INVOKABLE static void launchURL(const QString &url);

private:
    static QMap<int, QPair<QString, QString>> _auspiciantes;
    static int _currentIdAuspiciante;
};

#endif // ENGINE_H
