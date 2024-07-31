#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <qquickstyle.h>

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN) && QT_VERSION_CHECK(5, 6, 0) <= QT_VERSION && QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    //app.setApplicationName("blot score");
    //app.setOrganizationName("None");
    //app.setOrganizationDomain("None");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/qt/qml/app/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;


    return app.exec();
}
