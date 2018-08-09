#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "sprocess.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QCoreApplication::setApplicationName("PingTool2");
    QCoreApplication::setApplicationVersion("0.0.1");

    QCoreApplication::setOrganizationName("MedveSoft");
    QCoreApplication::setOrganizationDomain("org.dejqit");

    QGuiApplication app(argc, argv);

    qmlRegisterType<SProcess>("SProcess", 1, 0, "SProcess");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
