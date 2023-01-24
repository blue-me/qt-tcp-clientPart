#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QObject>
#include "user.h"
#include"tcpclient.h"
#include <QString>
#include "message.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<User>("userExample",1,0,"User");
    qmlRegisterType<TcpClient>("tcpClientExample",1,0,"TcpClient");
    qRegisterMetaType<Message>("Message");

    QQmlApplicationEngine engine;
   // engine.addImportPath("qrc:/");
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);


//    auto loginWindow = engine.rootObjects().first()->
//            findChild<QObject*>("loginButton");

//    QObject::connect(loginWindow,SIGNAL(loginSig(string,string)),User::getInstance(),
//                     SLOT(setUsername(string,string)));



    return app.exec();
}
