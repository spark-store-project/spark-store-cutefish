#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QLocale>
#include <QTranslator>
#include <QFile>
#include <QIcon>

#include "processhelper.h"
#include "utils.h"
#include "fonts.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_UseHighDpiPixmaps, true);
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling, true);
    QApplication app(argc, argv);
    app.setOrganizationName("spark-store");
    app.setWindowIcon(QIcon::fromTheme("spark-store"));

    QQmlApplicationEngine engine;

    // Translations
    QLocale locale;
    QString qmFilePath = QString("%1/%2.qm").arg("/usr/share/spark-store-cutefish/translations/").arg(locale.name());
    if (QFile::exists(qmFilePath)) {
        QTranslator *translator = new QTranslator(QGuiApplication::instance());
        if (translator->load(qmFilePath)) {
            QGuiApplication::installTranslator(translator);
        } else {
            translator->deleteLater();
        }
    }
    engine.addImportPath(QStringLiteral("qrc:/"));
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    return app.exec();
}