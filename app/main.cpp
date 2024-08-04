#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <qquickstyle.h>
#include <string>
#include <filesystem>
#include <fstream>

std::string readFile(std::filesystem::path path)
{
    std::ifstream f(path);
    const auto sz = (std::filesystem::file_size(path));
    std::string result(sz, '\0');
    f.read(result.data(), sz);
    return result;
}

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN) && QT_VERSION_CHECK(5, 6, 0) <= QT_VERSION && QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    app.setApplicationName("Բլոտի հաշիվ");
    app.setOrganizationName("Gurgen Melikyan");
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("_helpText", QString(readFile(std::filesystem::current_path() / "app" / "support.txt").c_str()));
    engine.load(QUrl(QStringLiteral("qrc:/qt/qml/app/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;


    return app.exec();
}
